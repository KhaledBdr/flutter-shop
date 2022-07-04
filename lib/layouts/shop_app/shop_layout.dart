import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubits/shopLayoutCubit.dart';
import 'package:shop/cubit/states/shopLayoutStates.dart';
import 'package:shop/modules/shop/search_screen.dart';
import 'package:shop/modules/user/login_screen.dart';
import 'package:shop/modules/user/profile.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class ShopLayOut extends StatelessWidget{
  final user = CacheHelper.getData(key: 'token');
  @override
  Widget build(BuildContext context) {
    if(user == null){
      NavToAndCancel(context, LoginScreen());
    }
    return BlocProvider(
     create: (context)=> ShopLayoutCubit()..getAllProducts()..getAllCategories(),
     child: BlocConsumer<ShopLayoutCubit , ShopLayoutStates>(
       listener: (context, state){},
       builder: (context, state) {
         final cubit = ShopLayoutCubit.get(context);
         return Scaffold(
           appBar: AppBar(
             title: Text(
               'E7DEMNY',
               style: TextStyle(
                 shadows: <Shadow>[
                   Shadow(
                     offset: Offset(1.0, 1.0),
                     blurRadius: 3.0,
                     color: Color.fromARGB(255, 0, 0, 0),
                   ),
                   Shadow(
                     offset: Offset(1.5, 1.5),
                     blurRadius: 8.0,
                     color: Color.fromARGB(125, 0, 0, 255),
                   ),
                 ],
               ),
             ),
             actions: [
               TextButton(
                 onPressed: () {
                   NavTo(context, SearchScreen());
                 },
                 child: Icon(
                   Icons.search,
                   size: 30.0,
                   color: Colors.white,
                 ),
               ),
             ],
           ),
           body: cubit.screens[cubit.currentIndex],
           bottomNavigationBar: BottomNavigationBar(
             selectedIconTheme: IconThemeData(
               size: 30.0,
             ),
             type: BottomNavigationBarType.fixed,
             currentIndex: cubit.currentIndex,
             onTap: (index) {
               cubit.changeCurrentIndex(index);
             },
             items: cubit.BottomNavigationBarItems,
           ),
         );
       }
     ),
   );
  }
}