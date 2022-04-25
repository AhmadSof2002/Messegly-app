import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messegly/cubit/cubit.dart';
import 'package:messegly/cubit/states.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/styles/custom_icons_icons.dart';
import 'package:intl/intl.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState) {
          Navigator.pop(context);
        }
        ;
      },
      builder: (context, state) => Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: defaultAppBar(
                leadButtonFunc: () =>
                    SocialCubit.get(context).deletePostImage(),
                context: context,
                title: 'Create post',
                actions: [
                  defaultTextButton(
                      onPressed: () {
                        if (SocialCubit.get(context).postImage == null) {
                          SocialCubit.get(context).createPost(
                              dateTime: now.toString(),
                              text: textController.text);
                        } else {
                          SocialCubit.get(context).uploadPostImage(
                              dateTime: now.toString(),
                              text: textController.text);
                        }
                      },
                      text: 'POST')
                ])),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}')),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Ahmad Sofanati',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16, height: 1.4),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 500,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0)),
                                      image: DecorationImage(
                                          image: FileImage(
                                                  SocialCubit.get(context)
                                                      .postImage!)
                                              as ImageProvider<Object>,
                                          fit: BoxFit.cover)),
                                ),
                                IconButton(
                                  splashRadius: 22,
                                  splashColor: Colors.white,
                                  onPressed: () async {
                                    SocialCubit.get(context).deletePostImage();
                                  },
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.close,
                                      size: 16.0,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    radius: 20,
                                  ),
                                  color: Colors.white,
                                )
                              ]),
                        ),
                      ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        SocialCubit.get(context).getPostImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(CustomIcons.Image), Text('Add photos')],
                      ),
                    )),
                    Expanded(
                        child:
                            TextButton(onPressed: () {}, child: Text('# tags')))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
