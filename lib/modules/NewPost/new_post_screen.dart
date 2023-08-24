import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (context, state) {
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(context: context, title: "Add Post",
          actions: [
            TextButton(onPressed: ()async{
              if(cubit.postImage != null) {
               await cubit.uploadPostImageToFireStorage(postText:postController.text );
              }
              else{
                cubit.removePostImageUrl();
                cubit.uploadPostToFireStore(postText: postController.text,);
              }
              Navigator.pop(context);
            }, child:Text("Post"))
          ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(cubit.userData!.image!),
                      radius: 27,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cubit.userData!.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blueAccent,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.more_horiz,
                    //     size: 16,
                    //   ),
                    //   onPressed: () {
                    //
                    //   },
                    // ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "what is on your mind ...",
                      border: InputBorder.none,
                    ),
                    controller: postController,
                  ),
                ),
                if(cubit.postImage != null)
                  Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 210,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          )),
                    ),
                    IconButton(
                        onPressed: (){
                          cubit.removePostImage();
                        },
                        icon:Icon(Icons.clear_outlined,
                          size: 25,
                          color: Colors.black,
                        )

                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.image_outlined,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "add photo",
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        onPressed: () {
                          cubit.getPostImage();
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          "# tags",
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
