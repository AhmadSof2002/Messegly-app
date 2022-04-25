import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messegly/cubit/cubit.dart';
import 'package:messegly/cubit/states.dart';
import 'package:messegly/models/post_model.dart';
import 'package:messegly/models/user_model.dart';
import 'package:messegly/modules/comments/comments_screen.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/components/constants.dart';
import 'package:messegly/shared/components/constants.dart';
import 'package:messegly/shared/styles/colors.dart';
import 'package:messegly/shared/styles/custom_icons_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: SocialCubit.get(context).userModel != null &&
          SocialCubit.get(context).posts.isNotEmpty &&
          SocialCubit.get(context).comments.isNotEmpty,
      fallback: (context) => Center(child: CircularProgressIndicator()),
      builder: (context) => BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          var cubit = SocialCubit.get(context);

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?t=st=1647782764~exp=1647783364~hmac=4c0f77ec5257ea4f7c5f20ee7381f0a577689d8ab462e98c4c29361382bd2e5b&w=900'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white)),
                        )
                      ]),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                    SocialCubit.get(context).posts[index],
                    context,
                    index,
                  ),
                  separatorBuilder: (conext, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 8.0,
                )
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget buildPostItem(
    PostModel model,
    context,
    index,
  ) {
    final DateTime time1 = DateTime.parse(model.dateTime.toString());
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${model.image}')),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 15, height: 1.4),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        Text(
                          '${timeago.format(time1)}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      splashRadius: 16,
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                  width: double.infinity,
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: defaultColor,
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: defaultColor,
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                            image: NetworkImage(
                              '${model.postImage}',
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                CustomIcons.Heart,
                                size: 17,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentsScreen(
                                      model:
                                          SocialCubit.get(context).posts[index],
                                      postId: SocialCubit.get(context)
                                          .postsId[index],
                                    )), //// HERE B IS THE CLASS ON WHICH YOU NEED TO CARRY DATA FROM CLASS A
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                CustomIcons.Chat,
                                size: 17,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).commentsNum[index][SocialCubit.get(context).postsId[index]]}' ??
                                    '0 comments',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                  width: double.infinity,
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
                              radius: 18,
                              backgroundImage: NetworkImage(
                                  '${SocialCubit.get(context).userModel!.image}')),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Write a comment ...',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          CustomIcons.Heart,
                          size: 17,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Heart',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
