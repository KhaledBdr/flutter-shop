import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubits/settingCubit.dart';
import 'package:shop/cubit/cubits/shopLayoutCubit.dart';
import 'package:shop/cubit/states/settingStates.dart';
import 'package:shop/layouts/shop_app/shop_layout.dart';
import 'package:shop/modules/onBoardScreen.dart';
import 'package:shop/modules/user/login_screen.dart';
import 'package:shop/shared/Themes/darkTheme.dart';
import 'package:shop/shared/Themes/lightTheme.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');
  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget getStartWidget (){
  dynamic onBoard = CacheHelper.getData(key: 'onBoard');
    Widget start;
    if(onBoard == true){
      if(token == null || token.length == 0){
        start = LoginScreen();
      }else{
        start = ShopLayOut();
      }
    }else{
      start = OnBoardingScreen();
    }
    return start;
  }

  runApp(
      MyApp(
        start : getStartWidget(),
        isDark : isDark,
      ),
  );
}

class MyApp extends StatelessWidget {
  final start;
  final isDark;
  MyApp({Key key, this.start , this.isDark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingCubit()..changeDarkness(isDark),
        ),
        BlocProvider(
        create: (context) => ShopLayoutCubit()..getAllProducts(),
        ),
      ],

      child: BlocConsumer <SettingCubit , SettingStates>(
        listener: (context ,state){},
        builder: (context , state) {

          final cubit = SettingCubit.get(context);

          return MaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: start,
            darkTheme: darkTheme,
            themeMode:cubit.getDarkness()?ThemeMode.dark:ThemeMode.light,
          );
        },
      ),
    );
  }
}
