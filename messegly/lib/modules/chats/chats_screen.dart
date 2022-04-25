import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messegly/cubit/cubit.dart';
import 'package:messegly/cubit/states.dart';
import 'package:messegly/models/user_model.dart';
import 'package:messegly/modules/chats/chat_details_screen.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: SocialCubit.get(context).allUsers.isNotEmpty,
        builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildChatItem(
                context, SocialCubit.get(context).allUsers[index]),
            separatorBuilder: (context, index) => Divider(
                  height: 2,
                ),
            itemCount: SocialCubit.get(context).allUsers.length),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildChatItem(context, UserModel model) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetails(model: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 25, backgroundImage: NetworkImage('${model.image}')),
              SizedBox(
                width: 15,
              ),
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
            ],
          ),
        ),
      );
}
