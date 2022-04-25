abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  final String error;
  SocialGetAllUserErrorState(this.error);
}

class SocialChangeBotoomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

//firebase
class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileErrorPickedSuccessState extends SocialStates {}

class SocialCoverSuccessPickedSuccessState extends SocialStates {}

class SocialCoverErrorPickedSuccessState extends SocialStates {}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;
  SocialLikePostErrorState(this.error);
}

class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {
  final String error;
  SocialCommentPostErrorState(this.error);
}

class SocialGetCommentsLoadingState extends SocialStates {}

class SocialGetCommentsSuccessState extends SocialStates {}

class SocialGetCommentsErrorState extends SocialStates {
  final String error;
  SocialGetCommentsErrorState(this.error);
}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileErrorState extends SocialStates {}

class SocialUploadCoverSuccessState extends SocialStates {}

class SocialUploadCoverErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

//create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImaagePickedSuccessState extends SocialStates {}

class SocialPostImaagePickedErrorState extends SocialStates {}

class SocialPostImaageRemoverSuccessState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}
//chat

class SocialSendMessagesSuccessState extends SocialStates {}

class SocialSendMessagesErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {}

class SocialChatImagePickedSuccessState extends SocialStates {}

class SocialChateImagePickedErrorState extends SocialStates {}

class SocialSendImageSuccessState extends SocialStates {}

class SocialSendImageErrorState extends SocialStates {}

class SocialUploadChatImageErrorState extends SocialStates {}
