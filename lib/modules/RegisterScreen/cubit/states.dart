
abstract class RegisterStates{}

class InitialRegisterStates extends RegisterStates{}

class OnChangeVisipilityOfPass extends RegisterStates{}

class SocialRegisterLoadingState extends RegisterStates{}
class SocialRegisterSuccessState extends RegisterStates{
}
class SocialRegisterErrorState extends RegisterStates{
  final String error;
  SocialRegisterErrorState(this.error);
}
class OnUploadingToFirestoreLoadingState extends RegisterStates{}
class OnUploadingToFirestoreSuccessState extends RegisterStates{
}
class OnUploadingToFirestoreErrorState extends RegisterStates{
  final String error;
  OnUploadingToFirestoreErrorState(this.error);
}



