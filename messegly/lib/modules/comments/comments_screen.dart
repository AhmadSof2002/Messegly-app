import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messegly/cubit/cubit.dart';
import 'package:messegly/cubit/states.dart';
import 'package:messegly/models/comment_model.dart';
import 'package:messegly/models/post_model.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:messegly/shared/components/constants.dart';
import 'package:messegly/shared/styles/custom_icons_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsScreen extends StatelessWidget {
  PostModel model;
  String postId;

  CommentsScreen({
    required this.model,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var commentController = TextEditingController();
    final DateTime time1 = DateTime.parse(model.dateTime.toString());
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: defaultAppBar(
              context: context,
              title: 'Comments',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildTopCommentSection(context, time1),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ConditionalBuilder(
                              condition: SocialCubit.get(context)
                                      .comments[index]
                                      .postId ==
                                  postId,
                              builder: (context) => buildCommentsSection(
                                  context,
                                  time1,
                                  SocialCubit.get(context).comments[index]),
                              fallback: (context) => Container(),
                            ),
                          ),
                      itemCount: SocialCubit.get(context).comments.length),
                ),
                Container(
                  height: 70,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            unfocus(context);
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CircleAvatar(
                                    radius: 18,
                                    backgroundImage: NetworkImage(
                                        '${SocialCubit.get(context).userModel!.image}')),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: TextField(
                                    controller: commentController,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.send),
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .commentPost(
                                                    postId: postId,
                                                    comment:
                                                        commentController.text,
                                                    dateTime: now.toString(),
                                                    uId:
                                                        SocialCubit.get(context)
                                                            .userModel!
                                                            .uId!);
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        hintStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13),
                                        hintText: "Type in your comment",
                                        fillColor: Colors.white70),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget buildTopCommentSection(context, time1) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage('${model.image}')),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '${model.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15, height: 1.4),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  child: Text(
                    '${model.text}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Text('${timeago.format(time1)}'),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 3,
            color: Color.fromARGB(255, 78, 77, 77),
          ),
        ],
      );

  Widget buildCommentsSection(context, time1, CommentModel commentModel) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage('${commentModel.image}')),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '${commentModel.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15, height: 1.4),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  child: Text(
                    '${commentModel.text}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Text('${timeago.format(time1)}'),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
        ],
      );

  var currentFocus;

  unfocus(context) {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

class TimeAgo {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime notificationDate =
        DateFormat("dd-MM-yyyy h:mma").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
