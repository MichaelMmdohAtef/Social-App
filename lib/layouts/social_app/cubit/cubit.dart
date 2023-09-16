import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/models/message_model.dart';
import 'package:social_project/models/register_model.dart';
import 'package:social_project/modules/LoginPage/cubit/states.dart';
import 'package:social_project/modules/NewPost/new_post_screen.dart';
import 'package:social_project/modules/chats/chats_screen.dart';
import 'package:social_project/modules/feeds/feeds_screen.dart';
import 'package:social_project/modules/settings/settings_screen.dart';
import 'package:social_project/modules/users/users_screen.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_project/shared/network/local/cashe_helper.dart';

import '../../../models/posts_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialSocialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  RegisterModel? userData;
  bool isDark=isDarkMode;
  bool isSelectedMicro=false;
  bool isTextFieldWriting=false;
  String audioPath="";

  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingsScreen(false),
  ];

  List<String> titles = ["Home", "Chats", "Post", "Users", "Settings"];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline_sharp), label: "Post"),
    BottomNavigationBarItem(icon: Icon(Icons.perm_identity), label: "Users"),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings_sharp), label: "Settings"),
  ];

  Future<void>? changeModeApp(){
    isDark=!isDark;
    CasheHelper.setBoolean(key: STATE_MODE, value: isDark);
    emit(ChangeModeApp());
  }





  Future getUserData() async {
    emit(SocialGetDataLoadingState());
    return await FirebaseFirestore.instance
        .collection(Collection)
        .doc(uid)
        .get()
        .then((value) {
      userData = RegisterModel.fromjson(value.data()!);
      print("image: {userData!.image}");
      emit(SocialGetDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetDataErrorState(onError.toString()));
    });
  }

  FirebaseStorage database = FirebaseStorage.instance;

  onChangeCurrentIndex(int index) {
    if(index ==1 ){
      getAllUsers();
    }
    if (index == 2) {
      emit(OnAddNewBostCurrentIndex());
    } else {
      this.currentIndex = index;
      emit(OnChangeCurrentIndex());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileToDataBase();
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("no profile image selected");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  String? profileImageUrl;
  uploadProfileToDataBase() async {
    // emit(SocialUploadProfileToDataBaseLoadingState());
    await database
        .ref()
        .child("users/${Uri.file(profileImage!.path!).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(SocialUploadProfileToDataBaseSuccessState());
      }).catchError((error) {
        print("url failed");
        emit(SocialUploadProfileToDataBaseErrorState());
      });
      emit(SocialUploadProfileToDataBaseSuccessState());
    }).catchError((error) {
      print("uploaded failed");
      print(error.toString());
      emit(SocialUploadProfileToDataBaseErrorState());
    });
  }

  File coverImage = File("");
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      uploadCoverToDataBase();
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("no Cover image selected");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String? coverImageUrl;
  uploadCoverToDataBase() async {
    // emit(SocialUploadCoverToDataBaseLoadingState());
    await database
        .ref()
        .child("users/${Uri.file(coverImage.path!).pathSegments.last}")
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        emit(SocialUploadCoverToDataBaseSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverToDataBaseErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverToDataBaseErrorState());
    });
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print("no Post image selected");
      emit(SocialPostImagePickedErrorState());
    }
  }

  removePostImage() {
    postImage = null;
    emit(SocialPostImageRemovedSuccessState());
  }

  removePostImageUrl() {
    postImageUrl = null;
    emit(SocialPostImageUrlRemovedSuccessState());
  }

  String? postImageUrl;
  uploadPostImageToFireStorage({String? postText}) async {
    // emit(SocialUploadPostToDataBaseLoadingState());
    await database
        .ref()
        .child("posts/${Uri.file(postImage!.path!).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postImageUrl = value;
        uploadPostToFireStore(postText: postText, image: value);
        emit(SocialUploadPostImageToFireStorageSuccessState());
      }).catchError((error) {
        emit(SocialUploadPostImageToFireStorageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostImageToFireStorageErrorState());
    });
    print(postImageUrl);
  }

  DateTime date = DateTime.now();
  Future<void> uploadPostToFireStore({
    String? postText,
    String? image,
  }) async {
    emit(SocialUploadPostImageToFireStorageLoadingState());
    PostModel postModel = PostModel(
      name: userData!.name,
      image: userData!.image,
      uid: userData!.uid,
      date: date.toLocal().toString(),
      postImage: image ?? null,
      textPost: postText ?? "",
    );
    await FirebaseFirestore.instance
        .collection("Posts")
        .add(postModel.toMap())
        .then((value) {
      removePostImage();
      getAllPosts();
      emit(SocialUploadPostImageToFireStorageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadPostImageToFireStorageErrorState());
    }).whenComplete(() {
      removePostImageUrl();
    });
  }


  updateUserData({
    String? name,
    String? phone,
    String? bio,
  }) async {
    emit(UpdateUserDataLoadingState());
    print(userData!.toMap().toString());
    RegisterModel registerModel = RegisterModel(
      name!.isEmpty ? userData!.name : name,
      userData!.email,
      phone!.isEmpty ? userData!.phone : phone,
      uid,
      profileImageUrl ?? userData!.image,
      coverImageUrl ?? userData!.cover,
      bio!.isEmpty ? "write your bio ..." : bio,
      false,
    );
    Map<String, dynamic> data = registerModel.toMap();
    await FirebaseFirestore.instance
        .collection(Collection)
        .doc(uid)
        .update(data)
        .then((value) {
      getUserData();
      emit(UpdateUserDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  List<String> postId = [];
  List<PostModel> posts = [];
  List<int> likes = [];

  getAllPosts() async {
    emit(GetPostsOfUserLoadingState());
    posts = [];
    return await FirebaseFirestore.instance
        .collection("Posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("Likes").get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
        });
      });
      print(posts.length);
      emit(GetPostsOfUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetPostsOfUserErrorState());
    });
  }

  likePost(String uid) {
    emit(SetLikePostOfUserLoadingState());
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(uid)
        .collection("Likes")
        .doc(userData!.uid!)
        .set({
      "Like": true,
    }).then((value) {
      getAllPosts();
      emit(SetLikePostOfUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SetLikePostOfUserErrorState());
    });
  }
  List<RegisterModel>? users=[];
  Future getAllUsers() async {
    emit(SocialGetDataLoadingState());
      users=[];
      await FirebaseFirestore.instance
          .collection(Collection)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if(element.data()["uid"] != userData!.uid)
            users!.add(RegisterModel.fromjson(element.data()));
        });
        print(users![0].image);
        emit(SocialGetDataSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(SocialGetDataErrorState(onError.toString()));
      });
  }

  sendMessage({
    required String receiverUser,
    required String message,
    required String dateTime
}){
    MessageModel model=MessageModel(senderUserUrl: userData!.uid,
    receiverUserUrl: receiverUser,
      message: message,
      date: dateTime,
    );

    FirebaseFirestore.instance.collection(Collection)
        .doc(userData!.uid).collection("Chats").doc(receiverUser)
    .collection("Messages").add(model.toMap()).then((value){
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });

    //send message to receiver
    FirebaseFirestore.instance.collection(Collection)
        .doc(receiverUser).collection("Chats").doc(userData!.uid)
        .collection("Messages").add(model.toMap()).then((value){
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
    // getMessage(receiverUser: receiverUser);
}

 List<MessageModel> messages=[];
  getMessage({
    required String receiverUser,
  })async{
   await FirebaseFirestore.instance.collection(Collection)
        .doc(userData!.uid).collection("Chats").doc(receiverUser)
        .collection("Messages")
       .orderBy("date")
       .snapshots().listen((event) {
     messages=[];
     toast(message: "event lenght: ${event.docs.length}",
         status:toastStatus.SUCCESS);
          event.docs.forEach((element) {
            messages!.add(MessageModel.fromjson(element.data()));
            print("${element.id} jk ${element.data().toString()}");

          });
          print(messages!.length);
          emit(GetMessageSuccessState());
    });
  }
  onWritingOnTextField({required bool isWriting}){
    isTextFieldWriting = isWriting;
    emit(OnWritingOnTextField());
  }

  onChangeAudioPath({required String path}){
    audioPath = path;
    emit(OnChangeAudioPath());
  }

  onSelectedMicrofone({required bool isSelected}){
    isSelectedMicro= isSelected;
    emit(OnSelectedMicrofone());
  }
}
