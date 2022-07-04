class RegisterationStates{}

class initialRegisterationState extends RegisterationStates{}

class changePassWordVisibilityRegisterationStates extends RegisterationStates{}

class changeAcceptTermsStates extends RegisterationStates{}

class tryingRegisterationStates extends RegisterationStates{}

class successRegisterationStates extends RegisterationStates{
  final RegisterModel;
  successRegisterationStates(this.RegisterModel);
}

class errorRegisterationStates extends RegisterationStates {
  final error;
  errorRegisterationStates(this.error);
}