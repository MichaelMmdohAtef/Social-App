
abstract class SocialStates{}

class InitialSocialStates extends SocialStates{}


class SocialGetDataLoadingState extends SocialStates{}
class SocialGetDataSuccessState extends SocialStates{}
class SocialGetDataErrorState extends SocialStates{
  final String error;
  SocialGetDataErrorState(this.error);
}

class UpdateUserDataLoadingState extends SocialStates{}
class UpdateUserDataSuccessState extends SocialStates{}
class UpdateUserDataErrorState extends SocialStates{}

class OnChangeCurrentIndex extends SocialStates{}
class OnAddNewBostCurrentIndex extends SocialStates{}


class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}


class SocialUploadProfileToDataBaseSuccessState extends SocialStates{}
class SocialUploadProfileToDataBaseLoadingState extends SocialStates{}
class SocialUploadProfileToDataBaseErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}
class SocialUploadCoverToDataBaseSuccessState extends SocialStates{}
class SocialUploadCoverToDataBaseLoadingState extends SocialStates{}
class SocialUploadCoverToDataBaseErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}
class SocialUploadPostImageToFireStorageSuccessState extends SocialStates{}
class SocialUploadPostImageToFireStorageLoadingState extends SocialStates{}
class SocialUploadPostImageToFireStorageErrorState extends SocialStates{}

class SocialPostImageRemovedSuccessState extends SocialStates{}
class SocialPostImageUrlRemovedSuccessState extends SocialStates{}

class SocialUploadPostToDataBaseSuccessState extends SocialStates{}
class SocialUploadPostToDataBaseLoadingState extends SocialStates{}
class SocialUploadPostToDataBaseErrorState extends SocialStates{}

class GetPostsOfUserSuccessState extends SocialStates{}
class GetPostsOfUserLoadingState extends SocialStates{}
class GetPostsOfUserErrorState extends SocialStates{}

class SetLikePostOfUserSuccessState extends SocialStates{}
class SetLikePostOfUserLoadingState extends SocialStates{}
class SetLikePostOfUserErrorState extends SocialStates{}

class SendMessageSuccessState extends SocialStates{}
class GetMessageSuccessState extends SocialStates{}
class SendMessageErrorState extends SocialStates{}

class ChangeModeApp extends SocialStates{}