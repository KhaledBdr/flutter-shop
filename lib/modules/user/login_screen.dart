import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubits/LoginCubit.dart';
import 'package:shop/cubit/states/LoginStates.dart';
import 'package:shop/layouts/shop_app/shop_layout.dart';
import 'package:shop/modules/user/registeration_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey <FormState> () ;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: BlocProvider(
        create: (context ) =>LoginCubit(),
        child: BlocConsumer<LoginCubit , LoginState>(
          listener: (context, state){
          if(state is successLoginStates){
            if(state.LoginModel.status){
              addToast(
                msg:state.LoginModel.message,
                state: ToastStates.SUCCESS,
              );
              CacheHelper.saveData(
                  key: 'token',
                  value: state.LoginModel.data.token
              )?.then((value){
                NavToAndCancel(context, ShopLayOut());
              });
            }else{
              addToast(msg:state.LoginModel.message , state : ToastStates.ERROR);
            }
          }
          },
          builder : (context , state){
            final cubit = LoginCubit.get(context);
            return Center(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,),
              child:SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      'login'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black,
                      ),
                    ),
                      height(10),
                      Text(
                        'Login now to user and subscribe or Offers',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      height(20.0),
                      input(
                          controller : emailController,
                          label : 'Email Address',
                          prefixIcon : Icons.email_rounded,
                          validator : (email){
                            if(email == null || email.isEmpty) return 'please Enter Your Email Address @';
                            return null;
                          },
                          keyBoard: TextInputType.emailAddress,
                      ),
                      height(20.0),

                      passwordInput(
                          suffix : true,
                          controller: passwordController,
                          suffexIcon: cubit.showPasswordLogin?Icons.visibility:Icons.visibility_off,
                          onPressedSuffexFunction: (){
                            cubit.changePasswordVisibiltyForLogin();
                          },
                          obsecure: !cubit.showPasswordLogin,
                          label: 'Password',
                          validator: (value){
                            if(value == null || value.isEmpty) return 'Please Enter Your Password';
                            if(value.length < 6) return'Your password must be more than or equal to 8 characters';
                            return null;
                          }
                      ),
                      height(
                        20.0,
                      ),

                      height(20.0,),
                      Center(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          color: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 30.0 , vertical: 15.0),
                          onPressed: ()async{
                            if(formKey.currentState.validate()){
                              // valid what to do then
                              cubit.LoginUser(
                                  email: '${emailController.text}',
                                  password: '${passwordController.text}',
                              );
                            }
                          },
                          child: ConditionalBuilder(
                            condition: state is! tryingLoginStates,
                            builder:(context)=>Text(
                              'Login'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            fallback:(context)=>centerCircle(),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text("Don't have account,"),
                          TextButton(
                            onPressed: (){
                              NavToAndCancel(context, RegisterScreen(),);
                            },
                            child: Text('create one'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ),
            );
          }
        ),

      ),
    );
  }
}
