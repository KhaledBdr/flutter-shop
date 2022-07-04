import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/states/shopLayoutStates.dart';
import 'package:shop/models/shop_app/category.dart';
import 'package:shop/models/shop_app/getProduct.dart';
import 'package:shop/models/shop_app/product.dart';
import 'package:shop/models/shop_app/search.dart';
import 'package:shop/modules/shop/catergories_screen.dart';
import 'package:shop/modules/shop/favourite_screen.dart';
import 'package:shop/modules/shop/home_screen.dart';
import 'package:shop/modules/shop/setting_screen.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_points.dart';

import '../../models/shop_app/favourite.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit() : super(initialState());
  static ShopLayoutCubit get(context) => BlocProvider.of(context);
// home_layout
  List <BottomNavigationBarItem> BottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home Page',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.category,
      ),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'Favourite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Setting',
    ),
  ];
  List <Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];
  int currentIndex = 0;

  void changeCurrentIndex (int value){
    currentIndex = value;
    emit(changeBottomNavigationItemState());
  }

  ////////////////////////////////////////////////////////////////////////////////
  // home screen
  ProductModel products;

  void getAllProducts (){
    emit(gettingAllProducts());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value){
      if(value != null){
        products =ProductModel.fromJson(value.data);
      };
      emit(successGettingAllProducts());
    }).catchError((error){
      print('Error ${error.toString()}');
      emit(errorGettingAllProducts(error.toString()));
    });
  }

  ////////////////////////////////////////////////////////////////////////////////
  // categories screen

  CategoryModel categories;
  void getAllCategories (){
    emit(gettingAllCategories());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value){
      categories = CategoryModel.fromJson(value.data);
      emit(successGettingAllCategories());
    }).catchError((error){
      print(error.toString());
      emit(errorGettingAllCategories(error));
    });
  }

  ////////////////////////////////////////////////////////////////////////////////
  // Favourite Screen
  FavouriteModel favourites;
  void getAllFavourites () {
    favourites = null;
    emit(gettingAllFavourite());
    DioHelper.getData(
      url: FAVOURITE,
      token: token,
    ).then((value) {
      favourites = FavouriteModel.fromJson(value.data);
      emit(successGettingAllFavourite());
    }).catchError((error) {
      print(error.toString());
      emit(errorGettingAllFavourite(error));
    });
  }

  void changeIsFavourite(dynamic productId){
    emit(tryingChangeIsFavourite());
    DioHelper.postData(
        path: FAVOURITE,
        token : token,
        data: {
          'product_id' : productId,
        }
        ).then((value){
          emit(successChangeIsFavourite());
          getAllFavourites();
          getAllProducts();
        }).catchError((error){
          emit(errorChangeIsFavourite(error));
          print(error.toString());
        });
  }


    ////////////////////////////////////////////////////////////////////////////////
    // Search Screen
  searchProductModel searchResult;
  void getSearchAboutProducts(String key){
    searchResult = null;
    emit(postingSearch());
    DioHelper.postData(
      path: SEARCH,
      query: {
        'Authorization' : token,
      },
      data: {
        'text' : key,
      }
    ).then((value) {
      print(value.data['data']['total']);
      searchResult = searchProductModel.fromJson(value.data);
      emit(successPostingSearch());
    }).catchError((error){
      print(error.toString());
      emit(errorPostingSearch(error));
      });
  }


////////////////////////////////////////////////////////////////////////////////
// getProduct Screen
  getProductModel product;
  void getProductFromId(dynamic id){
    product = null;
    emit(gettingProduct());
    DioHelper.getData(
      url: '$PRODUCT/$id',
      token: token,
    ).then((value){
      emit(successGettingProduct());

      product = getProductModel.fromJson(value.data);
      print(product.data.images.runtimeType);
    }).catchError((error){
      print('here');
      print(error.toString());
      emit(errorGettingProduct(error));
    });
  }
}