

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/models/register_model.dart';
import 'package:social_project/modules/RegisterScreen/cubit/states.dart';
import 'package:social_project/shared/components/constants.dart';
import 'package:social_project/shared/network/local/cashe_helper.dart';




class RegisterCubit extends Cubit<RegisterStates> {

  RegisterCubit():super(InitialRegisterStates());

  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? registerModel;
  bool isPassword=true;
  var id;


uploadDataToFirebaseFirestore({
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController phoneController,
  required TextEditingController passWordController,
  required TextEditingController confirmPassWordController,
}) async{
  emit(OnUploadingToFirestoreLoadingState());
  registerModel=RegisterModel(
      nameController.text,
      emailController.text.trim(),
      phoneController.text,
      uid,
      "https://img.freepik.com/free-icon/user_318-644324.jpg?size=626&ext=jpg&ga=GA1.2.2055448770.1689451805&semt=ais",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCbU49DD_iYcjSUEXG-Oy7POjJzaMn1GYEZg&usqp=CAU",
      "write your bio ...",
      false,
  );
  Map<String,dynamic> map=registerModel!.toMap();
  await FirebaseFirestore.instance.collection(Collection)
      .doc(uid)
      .set(map).then((value){
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passWordController.clear();
    confirmPassWordController.clear();
    emit(OnUploadingToFirestoreSuccessState());
  }).catchError((onError){
    emit(OnUploadingToFirestoreErrorState(onError.toString()));
    print(onError.toString());
  });

}

Future createNewAccount({
  required TextEditingController emailController,
  required TextEditingController passWordController,
}) async{
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passWordController.text)
      .then((value)async{
        uid=value!.user!.uid.toString();
        print("mna$uid");
        uid!=null?uid=uid:uid="";
       await CasheHelper.setString(key: ID, value: uid);
        emit(SocialRegisterSuccessState());
  }).catchError((onError){
    emit(SocialRegisterErrorState(onError.toString()));
    print(onError.toString());
  });
}



  onChangePassword(){
    isPassword=!isPassword;
    emit(OnChangeVisipilityOfPass());
  }




}