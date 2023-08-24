import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_project/layouts/social_app/cubit/cubit.dart';
import 'package:social_project/layouts/social_app/cubit/states.dart';
import 'package:social_project/models/posts_model.dart';
import 'package:social_project/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        builder:(context, state) {
          var cubit=SocialCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.posts.length > 0 && cubit.userData !=null,
              builder:(context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDQzM0lJutgADE4Gk98nXqLDk1qrI5Y54FWQ&usqp=CAU",
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Communicate with friends",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) => buildBost(cubit.posts[index],context,index),
                      itemCount: cubit.posts.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                    ),
                  ],
                ),
              ),
              fallback:(context) => Center(child: CircularProgressIndicator()),);
        },
      listener:(context, state) {

        },);
  }

  Widget buildBost(PostModel post,BuildContext context,int index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(post.image!),
                    radius: 27,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                color: Colors.black,

                                  ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blueAccent,
                              size: 18,
                            ),
                          ],
                        ),
                        Text(
                          post.date!,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                               color: Colors.black
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Text(
                post.textPost!,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.black,
                ),
              ),
              if(post.tags != null)
                Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  top: 5,
                ),

                child: Container(
                  width: double.infinity,
                  child: Wrap(children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 3),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            "#flutter",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.blueAccent,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 3),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            "#Software_Enginear",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.blueAccent,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              if(post.postImage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(post.postImage!),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.suit_heart,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${SocialCubit.get(context).likes[index]}",
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                CupertinoIcons.chat_bubble_text,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "120 comment",
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(post.image!),
                            radius: 18,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "write a comment ...",
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.suit_heart,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
