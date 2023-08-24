import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/models/register_model.dart';
import 'package:social_project/modules/LoginPage/LoginScreen.dart';
import 'package:social_project/modules/NewPost/new_post_screen.dart';
import 'package:social_project/modules/settings/settings_screen.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/components/constants.dart';
import 'package:social_project/shared/network/local/cashe_helper.dart';
import 'package:toast/toast.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if(state is OnAddNewBostCurrentIndex){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        ToastContext().init(context);
        var cubit = SocialCubit.get(context);
        RegisterModel? model;
        if (cubit.userData !=null)
          model=cubit.userData;
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(icon:cubit.isDark?Icon(Icons.light_mode):
              Icon(Icons.dark_mode),
                onPressed: (){
                cubit.changeModeApp();
                },
              ),
              IconButton(icon:Icon(Icons.notifications_outlined),
              onPressed: (){},
              ),
              IconButton(icon:Icon(Icons.search),
                onPressed: (){},
              ),
              PopupMenuButton(itemBuilder: (context) =>menus(),
              onSelected: (value) {
                if (value == 1){
                  navigateTo(context,SettingsScreen(true));
                }else if (value == 2){
                  navigateAndFinish(context,LoginScreen());
                }
              },
              ),
            ],
          ),
          body:  cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap:(index) {
              cubit.onChangeCurrentIndex(index);
            },
          ),
        );
      },
    );
  }
  List<PopupMenuItem> menus()=>[
    PopupMenuItem(child: Container(
      height: 25,
      child: Row(
  children: [
      Icon(Icons.person_outline_sharp,
      color: Colors.grey[700],
      ),
      SizedBox(width: 10,),
      Text("Profile",
        style:TextStyle(
          color: Colors.grey[700],
        )

      ),
  ],
  ),
    ),
  value: 1,
  ),
    PopupMenuItem(child: Container(
      height: 25,
      child: Row(
        children: [
          Icon(Icons.logout,
            color: Colors.grey[700],

          ),
          SizedBox(width: 10,),
          Text("Sign Out",
          style: TextStyle(
            color: Colors.grey[700],
          ),
          ),
        ],
      ),
    ),
      value: 2,
    ),

  ];
}
