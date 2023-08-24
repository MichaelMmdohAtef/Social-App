import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/shared/components/components.dart';

import '../../models/register_model.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: "Edit Profile", actions: [
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
          var cubit = SocialCubit.get(context);
          RegisterModel userData = cubit.userData!;
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
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
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
                                        image: cubit.coverImageUrl == null
                                            ? NetworkImage(
                                                cubit.userData!.cover!)
                                            : NetworkImage(
                                                cubit.coverImageUrl!),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 13,
                                    backgroundColor: Colors.grey[350],
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        cubit.getCoverImage();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
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
                                  backgroundImage: cubit.profileImageUrl == null
                                      ? NetworkImage(cubit.userData!.image!)
                                      : NetworkImage(cubit.profileImageUrl!),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.grey[350],
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    defaultFormField(
                      controller: nameController,
                      text: "${cubit.userData!.name!}",
                      context: context,
                      label: "Name",
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
                      label: "${cubit.userData!.email!}",
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
                      text: "${cubit.userData!.phone!}",
                      context: context,
                      label: "Phone",
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
                      text: "${cubit.userData!.bio!}",
                      context: context,
                      label: "Bio",
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
    ;
  }
}
