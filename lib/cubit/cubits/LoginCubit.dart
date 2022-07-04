
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/states/LoginStates.dart';
import 'package:shop/models/shop_app/login_user.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginState> {
  static LoginCubit get(context) => BlocProvider.of(context);
  LoginCubit() : super(initialLoginState());

  UserModel LoginModel;
  bool showPasswordLogin = false;



  void changePasswordVisibiltyForLogin (){
    showPasswordLogin = !showPasswordLogin;
    emit(changePassWordVisibilityLoginState());
  }
  
  void LoginUser({
    @required String email,
    @required String password
}){
    emit(tryingLoginStates());
    DioHelper.postData(
        path: LOGIN,
        data: {
          'email': email ,
          'password' : password,
        },
    ).then((value){
      LoginModel = UserModel.fromJson(value.data);
      emit(successLoginStates(LoginModel));
    }).catchError((onError){
      print(onError.toString());
      emit(errorLoginStates(onError.toString()));
    });
  }
}