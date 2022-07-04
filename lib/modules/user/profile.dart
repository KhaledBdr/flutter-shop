import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubits/profileCubit.dart';
import 'package:shop/cubit/states/profileStates.dart';
import 'package:shop/shared/components/components.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
        ),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()..getProfile(),
        child: BlocConsumer <ProfileCubit , ProfileStates>(
          listener: (context, state) {
            if(state is successGettingProfileState){
              if(state.user.status){
                addToast(msg: state.user.message, state: ToastStates.SUCCESS);
              }else{
                addToast(msg: state.user.message, state: ToastStates.WARNING);
              }
            }
            },
          builder: (context , state){
            final cubit = ProfileCubit.get(context);
            return Center(
              child: ConditionalBuilder(
                condition: state is! gettingProfileState,
                fallback: (context) => centerCircle(
                  color: Colors.amber,
                ),
                builder: (context) =>Text('Profile',),
              ),
            );
          }
        ),
      ),
    );
  }
}