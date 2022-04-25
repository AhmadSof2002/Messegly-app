import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messegly/cubit/cubit.dart';
import 'package:messegly/cubit/states.dart';
import 'package:messegly/models/image_model.dart';
import 'package:messegly/models/message_model.dart';
import 'package:messegly/models/user_model.dart';
import 'package:messegly/shared/styles/colors.dart';
import 'package:messegly/shared/styles/custom_icons_icons.dart';

class ChatDetails extends StatelessWidget {
  UserModel model;
  ChatDetails({required this.model});

  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: model.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('${model.name}')
                ],
              )),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: SocialCubit.get(context).messages.length > 0,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var messages =
                              SocialCubit.get(context).messages[index];

                          if (SocialCubit.get(context).userModel!.uId ==
                              messages.senderId) {
                            if (messages.type == 'image') {
                              return buildImageMessage(messages, context);
                            }
                            return buildMyMessage(messages);
                          }

                          return buildMessage(messages, context);
                        },
                        separatorBuilder: (context, index) => Container(
                              height: 15,
                            ),
                        itemCount: SocialCubit.get(context).messages.length),
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(15.0)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            border: InputBorder.none,
                            hintText: 'Write your message here',
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).uploadChatImage(
                                dateTime: DateTime.now().toString(),
                                reciverId: model.uId!);
                          },
                          icon: Icon(CustomIcons.Image)),
                      Container(
                        height: 50,
                        color: defaultColor,
                        child: MaterialButton(
                          minWidth: 1.0,
                          onPressed: () {
                            SocialCubit.get(context).sendMessage(
                                receiverId: model.uId!,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text);
                          },
                          child: Icon(
                            CustomIcons.Send,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget buildImageMessage(MessageModel model, context) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        height: 250,
        width: 300,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width: 3),
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                image: NetworkImage(model.text!), fit: BoxFit.cover)),
      ),
    );

Widget buildMessage(MessageModel model, context) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0))),
          child: Text(
            model.text!,
          )),
    );

Widget buildMyMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(.2),
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0))),
          child: Text(
            model.text!,
          )),
    );
