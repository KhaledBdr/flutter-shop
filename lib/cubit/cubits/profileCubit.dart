import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/states/profileStates.dart';
import 'package:shop/models/shop_app/login_user.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_points.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel user;
  ProfileCubit() : super(initialProfileState());
  void getProfile(){
    dynamic token = CacheHelper.getData(key: 'token');
    emit(gettingProfileState());
    DioHelper.getData(
        url: PROFILE,
        token: token,
    ).then((value){
      user = UserModel.fromJson(value.data);
      emit(successGettingProfileState(user));
    }).catchError((onError){
      print(onError.toString());
      emit(errorGettingProfileState(onError.toString()));
    });
  }
}