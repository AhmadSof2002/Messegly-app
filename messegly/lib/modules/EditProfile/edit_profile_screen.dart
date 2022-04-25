import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messegly/cubit/cubit.dart';
import 'package:messegly/cubit/states.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/styles/custom_icons_icons.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();

  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = SocialCubit.get(context).userModel!.name!;
        bioController.text = SocialCubit.get(context).userModel!.bio!;
        phoneController.text = SocialCubit.get(context).userModel!.phone!;
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: defaultAppBar(actions: [
                defaultTextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    },
                    text: 'UPDATE'),
                SizedBox(
                  width: 15,
                )
              ], context: context, title: 'Edit Profile')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 190,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 140.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0)),
                                        image: DecorationImage(
                                            image: coverImage == null
                                                ? NetworkImage(
                                                    '${userModel!.cover}')
                                                : FileImage(coverImage)
                                                    as ImageProvider<Object>,
                                            fit: BoxFit.cover)),
                                  ),
                                  IconButton(
                                    splashRadius: 22,
                                    splashColor: Colors.white,
                                    onPressed: () async {
                                      SocialCubit.get(context)
                                          .getCoverFromGallery();
                                    },
                                    icon: CircleAvatar(
                                      child: Icon(
                                        CustomIcons.Camera,
                                        size: 16.0,
                                      ),
                                      radius: 20,
                                    ),
                                    color: Colors.white,
                                  )
                                ]),
                          ),
                          Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  radius: 64.0,
                                  child: CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: profileImage == null
                                          ? NetworkImage('${userModel!.image}}')
                                          : FileImage(profileImage)
                                              as ImageProvider<Object>),
                                ),
                                IconButton(
                                  splashRadius: 18,
                                  splashColor: Colors.transparent,
                                  onPressed: () {
                                    SocialCubit.get(context).getFromGallery();
                                  },
                                  icon: CircleAvatar(
                                    child: Icon(
                                      CustomIcons.Camera,
                                      size: 16.0,
                                    ),
                                    radius: 20,
                                  ),
                                  color: Colors.white,
                                )
                              ])
                        ]),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'Upload profile',
                                  radius: 10),
                              if (state is SocialUserUpdateLoadingState)
                                SizedBox(
                                  height: 5,
                                ),
                              if (state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator()
                            ],
                          )),
                        SizedBox(
                          width: 5,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'Upload COVER',
                                  radius: 10),
                              if (state is SocialUserUpdateLoadingState)
                                SizedBox(
                                  height: 5,
                                ),
                              if (state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator()
                            ],
                          )),
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: defaultTextFormField(
                        hintText: 'Name',
                        controller: nameController,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        prefixIcon: CustomIcons.User2,
                        prefixColor: Colors.black54),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: defaultTextFormField(
                        hintText: 'Bio',
                        controller: bioController,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'bio must not be empty';
                          }
                          return null;
                        },
                        prefixIcon: CustomIcons.Info_Circle,
                        prefixColor: Colors.black54),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: defaultTextFormField(
                        hintText: 'Phone Number',
                        controller: phoneController,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        prefixIcon: CustomIcons.Call,
                        prefixColor: Colors.black54),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
