
import 'package:flutter/material.dart';
import 'package:shop/modules/user/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

Color defaultColor = Colors.blue;

void logOut (context){
  CacheHelper.deleteData(key: 'token')
      .then((value) {
    NavToAndCancel(context, LoginScreen());
  },);
}

void printFullText (String text){
  final pattern = RegExp('.{1,800}'); //800 is the size of the chunck
  pattern.allMatches(text)
      .forEach((element){
        print(element.group(0));
      }
      );
}

String token = '';