import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/modules/animation_image/zoom_animation.dart';
import 'package:social_project/shared/components/components.dart';
import '../../models/register_model.dart';


class UsersDetails extends StatelessWidget {

  RegisterModel? userData;

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  UsersDetails(this.userData);

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: "User Profile", actions: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 10),
          child: TextButton(
            onPressed: () {
              SocialCubit.get(context).updateUserData(
                  name: nameController.text,
                  phone: phoneController.text,
                  bio: bioController.text);
            },
            child: Text("Update"),
          ),
        ),
      ]),
      body: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // var cubit = SocialCubit.get(context);
          return ConditionalBuilder(
            condition: userData != null,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              onTap: ()=>navigateTo(context, ImageAnimation(image: userData!.cover!)),
                              child: Container(
                                height: 140,
                                width: double.infinity,
                                child: state
                                is SocialCoverImagePickedSuccessState
                                    ? Align(
                                  child: LinearProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                  alignment: Alignment.topCenter,
                                )
                                    : Container(),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image:  NetworkImage(
                                          userData!.cover!),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              navigateTo(context,ImageAnimation(image: userData!.image!,));
                            },
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                child: state
                                is SocialProfileImagePickedSuccessState
                                    ? CircleAvatar(
                                  child: CircularProgressIndicator(),
                                  backgroundColor: Colors.white,
                                  radius: 60,
                                )
                                    : Container(),
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(userData!.image!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    defaultFormField(
                      controller: nameController,
                      label: "${userData!.name!}",
                      context: context,
                      isprofile: true,
                      // isSelected: cubit.isTextFieldSelected,
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return "name field must be not empty";
                        }
                        return null;
                      },
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      label: "${userData!.email!}",
                      context: context,
                      isprofile: true,
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return "name field must be not empty";
                        }
                        return null;
                      },
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      label: "${userData!.phone!}",
                      isprofile: true,
                      context: context,

                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return "Phone field must be not empty";
                        }
                        return null;
                      },
                      prefixIcon: Icons.phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: bioController,
                      label: "${userData!.bio!}",
                      context: context,
                      isprofile: true,
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return "Bio field must be not empty";
                        }
                        return null;
                      },
                      prefixIcon: Icons.info_outline,
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
