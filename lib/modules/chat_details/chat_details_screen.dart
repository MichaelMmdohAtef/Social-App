import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/models/message_model.dart';
import 'package:social_project/models/register_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  final RegisterModel? user;

  ChatDetailsScreen(this.user);
  DateTime time = DateTime.now();
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiverUser: user!.uid!);

        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {

          },
          builder:(context, state) => Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user!.image!),
                    radius: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    user!.name!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              titleSpacing: 0,
            ),
            body: layOut(context),
          ),
        );
      },
    );
  }

  Widget layOut(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0,
                builder: (context) => ListView.separated(
                    itemBuilder: (context, index) {
                      print(SocialCubit.get(context)
                          .messages[index]
                          .toMap()
                          .toString());
                      if (SocialCubit.get(context).userData!.uid ==
                          SocialCubit.get(context)
                              .messages[index]
                              .senderUserUrl) {
                        print("1");
                        return myMessageLayout(
                            SocialCubit.get(context).messages[index]);
                      } else {
                        print("2");
                        return receiverMessageLayout(
                            SocialCubit.get(context).messages[index]);
                      }
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                    itemCount: SocialCubit.get(context).messages.length),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15.0),
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "type your message here ..."),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    height: 50,
                    child: MaterialButton(
                        onPressed: () {
                          SocialCubit.get(context).sendMessage(
                              receiverUser: user!.uid!,
                              message: messageController.text,
                              dateTime: time.toLocal().toString());
                        },
                        minWidth: 1,
                        child: Icon(
                          Icons.send,
                          size: 16,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget receiverMessageLayout(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          child: Text(model.message!),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(12),
              bottomEnd: Radius.circular(5),
              topEnd: Radius.circular(5),
            ),
          ),
        ),
      );
  Widget myMessageLayout(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          child: Text(model.message!),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.2),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(5),
              bottomEnd: Radius.circular(0),
              topEnd: Radius.circular(12),
              bottomStart: Radius.circular(5),
            ),
          ),
        ),
      );
}
