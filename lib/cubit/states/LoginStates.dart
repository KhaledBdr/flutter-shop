abstract class LoginState {

}
class initialLoginState extends LoginState{}

class changePassWordVisibilityLoginState extends LoginState{}

class tryingLoginStates extends LoginState{}

class successLoginStates extends LoginState{
  final LoginModel;
  successLoginStates(this.LoginModel);
}

class errorLoginStates extends LoginState{
  final error;
  errorLoginStates(this.error);
}
