import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubits/settingCubit.dart';
import 'package:shop/cubit/states/settingStates.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class SettingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocConsumer <SettingCubit , SettingStates>(
        listener: (context , state){},
        builder:(context, state) {
          final cubit = SettingCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dark Mode',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Switch(
                            activeColor: Colors.red,
                              value: cubit.getDarkness(),
                              onChanged: (value) {
                                cubit.changeDarkness(value);
                              }),
                        ],
                      ),
                      line(),
                      Center(
                        child: TextButton(
                          onPressed: (){
                            logOut(context);
                          },
                          child: Text(
                            'LOGOUT',
                            style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.red,
                              letterSpacing: 3.0,
                              fontWeight: FontWeight.w900,
                              shadows: <Shadow>[
                                const Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 5.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}