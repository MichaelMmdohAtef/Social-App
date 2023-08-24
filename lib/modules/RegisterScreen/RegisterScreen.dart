import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/social_layout.dart';
import 'package:social_project/modules/LoginPage/LoginScreen.dart';
import 'package:social_project/shared/components/components.dart';
import 'package:social_project/shared/styles/colors.dart';
import 'package:toast/toast.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();

  bool isPassword=true;

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is SocialRegisterSuccessState){
            toast(message: "your email have been created successfully",
              status: toastStatus.SUCCESS,);
          }
          else if(state is SocialRegisterErrorState){
            toast(message: state.error.toString(),
                status: toastStatus.ERROR);
          }else if(state is OnUploadingToFirestoreSuccessState){
            toast(message: "you Data have been Uploaded successfully",
              status: toastStatus.SUCCESS,);
            navigateAndFinish(context, SocialLayout());
          }else if(state is OnUploadingToFirestoreErrorState){
            toast(message: state.error.toString(),
                status: toastStatus.ERROR);
          }
        },
        builder:(context,states){
          var cubit=RegisterCubit.get(context);
          print(cubit.isPassword);
          return Scaffold(
            appBar: AppBar(
              // title: Text(
              //   "Shop App",
              //   style: TextStyle(
              //     fontFamily: 'shortBaby',
              //     fontWeight: FontWeight.bold,
              //     fontSize: 27,
              //     color: Colors.deepOrange,
              //   ),
              // ),
              elevation: 0,
              centerTitle: true,
            ),
            body:Container(
              color: backGroundColor,
              child: Form(
                key: formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
                            style: Theme.of(context).textTheme.headline3!
                                .copyWith(
                              color: Colors.black,
                              fontFamily: 'shortBaby',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: nameController,
                            label: "Name",
                            context: context,
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return "name can not be embty";
                              }
                            },
                            hint: "enter your Name",
                            typeKeyboard: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            context: context,
                            controller: emailController,
                            label: "Email Address",
                            hint: "please enter your email",
                            onValidate: (value) {
                              if(value!.split("@")[0].isEmpty  || value.isEmpty) {
                                return "Email Address can not be embty";
                              }
                              if(value.contains("@gmail.com")){
                                return null;
                              }
                              else{
                                return "Email Address is bad format";
                              }
                            },
                            prefixIcon: Icons.email,
                            typeKeyboard: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            context: context,
                            controller: phoneController,
                            label: "Phone Number",
                            hint: "please enter your Number",
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return "this Field can not be embty";
                              }
                              else if(value.length<10 &&value.length>10){
                                return "Number should be at least 11 characters";
                              }
                            },
                            prefixIcon: Icons.phone,
                            typeKeyboard: TextInputType.number,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passWordController,
                            label: "Password",
                            ispass: cubit.isPassword,
                            context: context,
                            onSuffixPressed: (){
                              cubit.onChangePassword();
                            },
                            suffixIcon: cubit.isPassword?Icons.visibility_off:Icons.visibility,
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return "password can not be embty";
                              }
                              else if(value.length<=8){
                                return "password should be at least 9 characters";
                              }
                            },
                            hint: "please enter your password",
                            prefixIcon: Icons.lock,
                            typeKeyboard: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: confirmPassWordController,
                            label: "confirm Password",
                            ispass: cubit.isPassword,
                            context: context,
                            onSuffixPressed: (){
                              cubit.onChangePassword();
                            },
                            suffixIcon: cubit.isPassword?Icons.visibility_off:Icons.visibility,
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return "password can not be embty";
                              }
                              else if(value.length<=8){
                                return "password should be at least 9 characters";
                              }
                            },
                            hint: "enter your password again",
                            prefixIcon: Icons.lock,
                            typeKeyboard: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          defaultButton(onPressed: () async{
                            // print(formKey.currentState!.validate().toString());
                            print(emailController.text);
                            if(formKey.currentState!.validate()){
                              if(passWordController.text!=confirmPassWordController.text){
                                Toast.show("password should be equal to confirm password");
                              }
                              else {
                               await cubit.createNewAccount(emailController: emailController,
                                    passWordController: passWordController).then((value){
                                      cubit.uploadDataToFirebaseFirestore(
                                          nameController: nameController,
                                          emailController: emailController,
                                          phoneController: phoneController,
                                          passWordController: passWordController,
                                          confirmPassWordController: confirmPassWordController);
                               });

                              }
                            }

                          },
                            text: 'Register',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ) ,
          );
        } ,
      ),
    ) ;


  }
}
