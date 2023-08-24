import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/network/remote/dio_helper.dart';
import 'package:social_project/shared/network/remote/end_points.dart';

class SettingsScreen extends StatelessWidget {
  bool isMenu = false;
  SettingsScreen(this.isMenu);

  Map<String, dynamic> map = {};
  Map<String, dynamic> data = {};

  Future<void> getDataFromModel() async {
    await rootBundle.loadString("lib/JsonFile/data_fcm.json").then((value) {
      map = jsonDecode(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: isMenu
              ? defaultAppBar(
                  context: context,
                  title: "Profile",
                )
              : null,
          body: Padding(
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
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image:
                                    NetworkImage("${cubit.userData!.cover!}"),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      CircleAvatar(
                        radius: 65,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage("${cubit.userData!.image!}"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${cubit.userData!.name!}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${cubit.userData!.bio!}",
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Posts",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "380",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Photos",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "10k",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Followers",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "64",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Followings",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {}, child: Text("Add Photos")),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Icon(
                          Icons.edit,
                          size: 16,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () async{
                           await getDataFromModel();
                            print(map.toString());
                           await updateDestinationOfFcm();
                            print(data);
                           await FirebaseMessaging.instance
                                .subscribeToTopic("anouncment")
                                .then((value) async {
                              await DioHelper.postData(
                                url: "send",
                                data: data!,
                              ).then((value) {
                                print(value.data.toString());
                              });
                            }).catchError((error) {
                              print(error.toString());
                            });
                          },
                          child: Text("Subscribe")),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () async{
                           await FirebaseMessaging.instance
                                .unsubscribeFromTopic("anouncment")
                                .then((value) async {
                              await DioHelper.postData(
                                url: "send",
                                data: data!,
                              ).then((value) {}).catchError((error) {});
                            });
                          },
                          child: Text("Un Subscribe")),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future updateDestinationOfFcm() async{
    data = {};
    map.forEach((key, value) {
      if (key == "to") {
        data.addAll({key: URL_TO_ALL_SUBSCRIBED_IN_FCM});
      } else {
        data.addAll({key: value});
      }
    });
  }

}
