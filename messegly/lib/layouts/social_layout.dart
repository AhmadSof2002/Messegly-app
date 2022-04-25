import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:messegly/cubit/cubit.dart';
import 'package:messegly/cubit/states.dart';
import 'package:messegly/modules/NewPost/new_post.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/styles/custom_icons_icons.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) navigateTo(context, NewPostScreen());
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: Icon(CustomIcons.Notification)),
              IconButton(onPressed: () {}, icon: Icon(CustomIcons.Search))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.Home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.Chat), label: 'Chats'),
                      BottomNavigationBarItem(
                          icon: Container(
                              width: 38,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 3.0),
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromARGB(255, 95, 95, 95)))),
                          label: 'Create'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.Location), label: 'Users'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.Setting), label: 'Settings'),
                    ],
                    onTap: (index) {
                      cubit.changeBottomNav(index);
                    },
                    currentIndex: cubit.currentIndex,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
