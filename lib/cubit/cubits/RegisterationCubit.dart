import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/states/RegisterationStates.dart';
import 'package:shop/models/shop_app/login_user.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_points.dart';

class RegisterationCubit extends Cubit <RegisterationStates>{
  RegisterationCubit() : super(initialRegisterationState());
  static RegisterationCubit get(context) => BlocProvider.of(context);

bool showPasswordReisteration = false;
bool acceptTermsRegisteration = false;

void changePasswordVisibiltyForRegisteration (){
  showPasswordReisteration = !showPasswordReisteration;
  emit(changePassWordVisibilityRegisterationStates());
}
void termsRegisteration ( bool newVal){
  acceptTermsRegisteration = newVal;
  emit(changeAcceptTermsStates());
}


UserModel user;

void ReisterUser ({
  @required dynamic name,
  @required dynamic email,
  @required dynamic password,
  @required dynamic image,
  @required dynamic phone,
})async{
  emit(tryingRegisterationStates());
  DioHelper.postData(
      path: REGISTERATION,
      data: {
        'email' : email,
        'password': password,
        'name' : name,
        'phone' : phone,
        'image' : image,
      },
  ).then((value) {
      user = UserModel.fromJson(value.data);
      emit(successRegisterationStates(user));
    }).catchError((error){
      emit(errorRegisterationStates(error.toString()));
  });
}
}