import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/states/settingStates.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class SettingCubit extends Cubit <SettingStates>{

  SettingCubit() :  super(initialSettingState());
  static SettingCubit get(context) => BlocProvider.of(context);


   bool getDarkness(){
     bool isDark = false;
     dynamic dark = CacheHelper.getData(key: 'isDark');
     if(dark == null){
       CacheHelper.saveData(key: 'isDark', value: isDark);
     }
     if(dark == true) isDark = true;
     emit(getDarknessState());
     return isDark;

   }

   void changeDarkness(value){
     CacheHelper.changeData(key: 'isDark', value: value);
     emit(changeDarknessState());
     emit(getDarknessState());
   }

  // bool isDark = false;

  // void changeAppMode ({dynamic fromShared}){
  //   emit(changeDarknessState());
  //   if(fromShared != null){
  //     isDark = fromShared;
  //     emit(changeDarknessState());
  //   }else{
  //     isDark = !isDark;
  //     CacheHelper.saveData(key: 'isDark', value: isDark)?.then((value) {
  //       emit(changeDarknessState());   } );
  //   }
  //  }

}