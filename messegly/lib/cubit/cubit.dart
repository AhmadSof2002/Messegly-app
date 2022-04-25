import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messegly/cubit/states.dart';
import 'package:messegly/models/comment_model.dart';
import 'package:messegly/models/image_model.dart';
import 'package:messegly/models/message_model.dart';
import 'package:messegly/models/post_model.dart';
import 'package:messegly/models/user_model.dart';
import 'package:messegly/modules/NewPost/new_post.dart';
import 'package:messegly/modules/chats/chats_screen.dart';
import 'package:messegly/modules/feeds/feeds_screen.dart';
import 'package:messegly/modules/settings/settings_screen.dart';
import 'package:messegly/modules/users/users_screen.dart';
import 'package:messegly/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['News Feed', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBotoomNavState());
    }
  }

  File? profileImage;

  Future<void> getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialProfileErrorPickedSuccessState());
    }
  }

  File? coverImage;

  var picker = ImagePicker();

  Future<void> getCoverFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverSuccessPickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialCoverErrorPickedSuccessState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadProfileErrorState());
      });
    }).onError((error, stackTrace) {
      emit(SocialUploadProfileErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        //emit(SocialUploadCoverSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadCoverErrorState());
      });
    }).onError((error, stackTrace) {
      emit(SocialUploadCoverErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //   } else if (profileImage != null) {
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        uId: userModel!.uId,
        bio: bio,
        cover: cover ?? userModel!.cover,
        email: userModel!.email,
        image: image ?? userModel!.image,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) => getUserData())
        .catchError((error) {});
  }

  File? postImage;

  Future<void> getPostImage() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImaagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImaagePickedErrorState());
    }
  }

  void deletePostImage() {
    postImage = null;
    emit(SocialPostImaageRemoverSuccessState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
        //emit(SocialUploadCoverSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).onError((error, stackTrace) {
      emit(SocialUploadCoverErrorState());
    });
  }

  void createPost(
      {required String dateTime, required String text, String? postImage}) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];

  List<int> likes = [];
  List<CommentModel> comments = [];
  List<Map<String, dynamic>> commentsNum = [];
  List<String> postsId = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) async {
          likes.add(value.docs.length);
          postsId.add(element.id);

          posts.add(PostModel.fromJson(element.data()));
          commentsNum.add({
            element.id: await element.reference
                .collection('comments')
                .get()
                .then((value) => value.docs.length)
          });
          emit(SocialGetPostsSuccessState());
        }).catchError((error) {});
      });
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          value.docs.forEach((element) {
            comments.add(CommentModel.fromJson(element.data()));
          });
        });
      });

      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void getComments() {
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        commentsNum.add({
          element.id: element.reference
              .collection('comments')
              .get()
              .then((value) => value.docs.length)
        });
        print(commentsNum);
        print(postsId);
      });
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost({
    required String uId,
    required String comment,
    required String postId,
    required String dateTime,
  }) {
    CommentModel model = CommentModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        text: comment,
        postId: postId);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  List<UserModel> allUsers = [];

  void getAllUsers() {
    if (allUsers.length == 0) {
      emit(SocialGetAllUserLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            allUsers.add(UserModel.fromJson(element.data()));
          print(allUsers);
          emit(SocialGetAllUserSuccessState());
        });
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState());
    });

    //set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState());
    });
  }

  List<MessageModel> messages = [];
  List<ImageModel>? images = [];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      print(messages);
      emit(SocialGetMessagesSuccessState());
    });
  }

  File? chatImage;
  Future<void> pickChatImage() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(SocialChatImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialChateImagePickedErrorState());
    }
  }

  void uploadChatImage({required String dateTime, required String reciverId}) {
    pickChatImage().then((value) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('chats/${Uri.file(chatImage!.path).pathSegments.last}')
          .putFile(chatImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          sendImage(
            dateTime: dateTime,
            reciverId: reciverId,
            img: value,
          );
          //emit(SocialUploadCoverSuccessState());
          print(value);
        }).catchError((error) {
          emit(SocialUploadChatImageErrorState());
        });
      });
    });
  }

  void sendImage({
    required String dateTime,
    required String reciverId,
    required String img,
  }) {
    MessageModel model = MessageModel(
        senderId: userModel!.uId,
        dateTime: dateTime,
        receiverId: reciverId,
        text: img,
        type: 'image');

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendImageSuccessState());
    }).catchError((error) {
      emit(SocialSendImageErrorState());
    });
  }
}
