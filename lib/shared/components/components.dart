import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/shared/styles/colors.dart';
import 'package:toast/toast.dart';


Widget defaultFormField({
  TextEditingController? controller,
  String? label,
  String? hint,
  String? text,
  required String? Function(String?) onValidate,
  IconData? prefixIcon,
  IconData? suffixIcon,
  TextInputType? typeKeyboard,
  bool ispass = false,
  bool isprofile= false,
  bool isSelected=false,
  Function()? onSuffixPressed,
  required BuildContext? context,
  Function(String)? onFieldSubmitted
}) =>
    TextFormField(
      controller: controller,
      obscureText: ispass!,
      cursorColor:Colors.black,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: '${label??""}',
        hintText: "${hint}",
        prefixIcon: prefixIcon!=null?Icon(
          prefixIcon,
        ):null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        hintStyle: Theme.of(context!).textTheme.bodyText1,
        enabled:isprofile?false:true,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onSuffixPressed,
                icon: Icon(suffixIcon),
              )
            : null,
      ),
      onTap:(){
        if(text!=null)
          controller!.text=text??"";
      },
      keyboardType: typeKeyboard,
      validator: onValidate,
    );

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: 40,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: MaterialButton(
          color: defaultButtonColor,
          textColor: CupertinoColors.darkBackgroundGray,
          onPressed: onPressed,
          child: Text(
            "${text}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?  actions,
})=>AppBar(
  title: Text(title??""),
  actions: actions,
  titleSpacing: 5,
  leading: IconButton(
    icon: Icon(Icons.keyboard_double_arrow_left_rounded),
    onPressed:(){
      Navigator.pop(context);
    } ,
  ),
);

void navigateTo(context, route) => Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => route,
      ),
    );

void navigateAndFinish(context, route) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => route), (route) => false);

void toast({
  required String message,
  required toastStatus status,
}) =>
    Toast.show(
      message,
      gravity: Toast.bottom,
      duration: 3,
      backgroundColor: changetoastColor(status),
    );

enum toastStatus { SUCCESS, ERROR }

Color changetoastColor(status) {
  Color? color;
  switch (status) {
    case toastStatus.SUCCESS:
      color = Colors.green;
      break;
    case toastStatus.ERROR:
      color = Colors.red;
      break;
  }
  return color!;
}

Widget myDevider()=>Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Container(
    color: Colors.black,
    child:SizedBox(
      width: double.infinity,
      height: 2,
    ),
  ),
);


