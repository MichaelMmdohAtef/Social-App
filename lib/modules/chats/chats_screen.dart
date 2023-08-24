import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/models/register_model.dart';
import 'package:social_project/modules/chat_details/chat_details_screen.dart';
import 'package:social_project/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildLayout(context, cubit.users![index]),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[600],
                ),
              ),
              itemCount: cubit.users!.length,
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildLayout(BuildContext context, RegisterModel user) =>
      InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(user));
        },
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.image!),
                  radius: 27,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  user.name!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ],
        ),
      );
}
