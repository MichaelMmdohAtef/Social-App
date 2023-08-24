
abstract class LoginStates{}

class InitialLoginStates extends LoginStates{}

class OnChangeVisipilityOfPass extends LoginStates{}

class SocialLoginLoadingState extends LoginStates{}
class SocialLoginSuccessState extends LoginStates{
  final String uid;

  SocialLoginSuccessState(this.uid);
}
class SocialLoginErrorState extends LoginStates{
  final String error;
  SocialLoginErrorState(this.error);

}





