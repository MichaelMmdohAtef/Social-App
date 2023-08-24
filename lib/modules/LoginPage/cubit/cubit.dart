import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/modules/LoginPage/cubit/states.dart';



class LoginCubit extends Cubit<LoginStates> {

  LoginCubit():super(InitialLoginStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword=true;


  var id;


  Future LoginAccount({
    required TextEditingController emailController,
    required TextEditingController passWordController,
  }) async{
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(),
    password: passWordController.text).then((value){
      emit(SocialLoginSuccessState(value.user!.uid));
      emailController.clear();
      passWordController.clear();
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLoginErrorState(onError.toString()));
    });
  }


  onChangePassword(){
    isPassword=!isPassword;
    emit(OnChangeVisipilityOfPass());
  }



}