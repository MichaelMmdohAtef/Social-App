import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/layouts/social_app/social_layout.dart';
import 'package:social_project/modules/LoginPage/LoginScreen.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/components/constants.dart';
import 'package:social_project/shared/network/local/cashe_helper.dart';
import 'package:social_project/shared/network/remote/dio_helper.dart';
import 'package:social_project/shared/styles/theme.dart';
import 'package:toast/toast.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> onMessage(RemoteMessage message)async{
  print("background message");
  print(message.toString());
  toast(message: message.notification!.title.toString(), status: toastStatus.SUCCESS,);
  return null;
}
Future<void>? onMessageNotification(RemoteNotification message)async{
  print("background message");
  print(message.toString());
  toast(message: message.title.toString(), status: toastStatus.SUCCESS,);
  return null;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CasheHelper.init();
  await Firebase.initializeApp();
  await DioHelper.init();

  HttpOverrides.global = MyHttpOverrides();
  timeDilation=3;
  uid = await CasheHelper.getData(key: ID);
  await CasheHelper.removeData(key: STATE_MODE);
  isDarkMode=await CasheHelper.getData(key: STATE_MODE)??false;
  var token=await FirebaseMessaging.instance.getToken();
  print(token.toString());
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    onMessageNotification(event!.notification!);
    // toast(message: event.data['id'].toString(), status: toastStatus.SUCCESS,);

  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    toast(message:event.data["id"].toString(), status: toastStatus.SUCCESS,);

  });;
  FirebaseMessaging.onBackgroundMessage(onMessage);
  print(uid);
  runApp(MyApp(uid,isDarkMode));
}


class MyApp extends StatelessWidget {
  String? uid;
  bool isDark;
  MyApp(this.uid,this.isDark);


  Widget startWidget() {
    if (this.uid != null) {
      return SocialLayout();
    } else {
      return LoginScreen();
    }
  }
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getAllPosts()..getAllUsers(),
        ),
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {

        },
        builder:(context, state)
        {
          ToastContext().init(context);
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            theme: lightTeme,
            themeMode: SocialCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: darkTheme,
            title: 'Flutter Demo',
            home: startWidget(),
          );
        },
      ),

    );

  }
}
