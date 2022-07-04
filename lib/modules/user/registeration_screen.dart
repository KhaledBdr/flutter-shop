import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop/cubit/states/RegisterationStates.dart';
import 'package:shop/cubit/cubits/RegisterationCubit.dart';
import 'package:shop/layouts/shop_app/shop_layout.dart';
import 'package:shop/modules/terms.dart';
import 'package:shop/modules/user/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';


class RegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController imgController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController re_passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future <String> getLocation () async{
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List <Placemark> place = await placemarkFromCoordinates(position.latitude, position.longitude);


    Placemark placeMark  = place[0];
      String locality = placeMark.locality;
      String administrativeArea = placeMark.administrativeArea;
      String country = placeMark.country;
      String address = " ${locality}, ${administrativeArea} , ${country}";


      return address;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create:(context) => RegisterationCubit(),
        child: BlocConsumer <RegisterationCubit , RegisterationStates>(
          listener: (context, state) {
            if(state is successRegisterationStates){
              if(state.RegisterModel.status){
                CacheHelper.saveData(
                    key: 'token',
                    value: state.RegisterModel.data.token
                )?.then((value){
                  NavToAndCancel(context, ShopLayOut());
                });

                addToast(
                  msg: state.RegisterModel.message,
                  state: ToastStates.SUCCESS,
                );
              }else{
                addToast(
                  msg: state.RegisterModel.message,
                  state: ToastStates.ERROR,
                );
              }
            }
          },
          builder : (context , state){
          final cubit = RegisterationCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    height(10.0,),
                    Text(
                      'Register User',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    height(10.0,),
                    input(
                      keyBoard: TextInputType.text,
                      controller: nameController,
                      label: 'User Name',
                      prefixIcon: Icons.drive_file_rename_outline,
                      validator: (value){
                        if( value == null || value.isEmpty) return 'Please Enter Your Name';
                        if(value.length <= 5) return 'please Enter Your Full Name';
                        return null;
                      },
                    ),
                    height(30.0,),
                    input(
                      controller: phoneController,
                      label: 'Phone Number',
                      prefixIcon: Icons.phone,
                      validator: (value){
                        if(value == null || value.isEmpty) return 'please Enter Your Phone';
                        return null;
                      },
                      keyBoard: TextInputType.number,
                    ),
                    height(30.0,),
                    input(
                      controller: emailController,
                      label: 'Email Address',
                      prefixIcon: Icons.alternate_email_outlined,
                      validator: (value){
                        if(value == null || value.isEmpty) return 'please Enter Your Email Address @';
                        if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) == false)
                          return 'Not Valid Email';
                        return null;
                      },
                      keyBoard: TextInputType.emailAddress,
                    ),
                    height(30.0,),
                    // passwordInput(
                    //   controller: addressController,
                    //   label: 'Address',
                    //   obsecure: false,
                    //   suffix: true,
                    //   suffexIcon: Icons.auto_fix_high,
                    //   suffixColor : Colors.blue,
                    //   onPressedSuffexFunction:  () async{
                    //     String address =await getLocation();
                    //     addressController.text = address;
                    //   },
                    //   prefix: Icons.not_listed_location_rounded,
                    //   validator: (value){
                    //     if(value == null || value.isEmpty) return 'please Enter Your Address.';
                    //     if(value.length < 10)  return 'Be more precise';
                    //     return null;
                    //   },
                    // ),
                    // height(
                    //     20.0,
                    //   ),
                    input(
                        controller: imgController,
                        label: 'Image Url',
                        prefixIcon: Icons.image,
                        validator: (value){
                          if(value == null || value.length == 0) return 'please insert alink to your image';
                          return null;
                        },
                        keyBoard: TextInputType.text
                    ),
                      height(20.0),
                      passwordInput(
                        suffix : true,
                        controller: passwordController,
                        suffexIcon: cubit.showPasswordReisteration?Icons.visibility:Icons.visibility_off,
                        onPressedSuffexFunction: (){
                          cubit.changePasswordVisibiltyForRegisteration();
                        },
                        obsecure: !cubit.showPasswordReisteration,
                        label: 'Password',
                        validator: (value){
                          if(value == null || value.isEmpty) return 'Please Enter Your Password';
                          if(value.length < 8) return'Your password must be more than or equal to 8 characters';
                          return null;
                        }
                      ),
                    height(
                      20.0,
                    ),
                    passwordInput(
                      controller: re_passwordController,
                      suffix: false,
                      onPressedSuffexFunction: (){},
                      obsecure: true,
                      validator: (value){
                        if(value == null || value.isEmpty) return 'please Repeat your password here';
                        if(value != passwordController.text) return "passwords don't match.";
                        return null;
                      },
                      label: 'repeat your password please',
                    ),
                    height(20.0,),
                    Row(
                      children: [
                        Checkbox(
                            value: cubit.acceptTermsRegisteration,
                            onChanged: (newValue){
                              cubit.termsRegisteration(newValue);
                            }),
                        Expanded(
                            child: TextButton(
                              child: Text(
                                'By Checking you agree and accept all our rights and terms....',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize :12.0 ,
                                ),
                              ),
                              onPressed: (){
                                NavTo(context,Terms_Screen() );
                              },
                            ),
                        ),
                      ],
                    ),
                    height(20.0,),
                    MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 30.0 , vertical: 15.0),
                      onPressed:cubit.acceptTermsRegisteration? (){
                        if(formKey.currentState.validate()){
                          // valid what to do then
                          cubit.ReisterUser(
                            name: nameController.text,
                            email: emailController.text,
                            image : imgController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                          );
                        }else{
                          print('not valid');
                        };
                      }:(){ /* do nothing */},
                      child: ConditionalBuilder(
                        condition: state is! tryingRegisterationStates,
                        builder: (context) =>  Text(
                          'register',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        fallback: (context) => centerCircle(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children :[
                        Text('already have account,'),
                        TextButton(
                          onPressed: (){
                            NavTo(context, LoginScreen());
                          },
                          child: Text(
                            'Login now!',
                            style: TextStyle(
                            decoration: TextDecoration.underline
                          ),
                          ),
                        ),
                      ],

                    ),
                  ],
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
