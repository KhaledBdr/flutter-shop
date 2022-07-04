import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubits/shopLayoutCubit.dart';
import 'package:shop/cubit/states/shopLayoutStates.dart';
import 'package:shop/models/shop_app/category.dart';
import 'package:shop/models/shop_app/product.dart';
import 'package:shop/modules/shop/productView_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constant.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopLayoutCubit , ShopLayoutStates>(
      listener: (context , state) {
        if(state is successGettingAllProducts) {
          print('Number of Products : ${ShopLayoutCubit
              .get(context)
              .products
              .data
              .products
              .length}');
          print('Number of Banners : ${ShopLayoutCubit
              .get(context)
              .products
              .data
              .banners
              .length}');
        }
        if(state is successGettingAllCategories)
          print('Number of categories : ${ShopLayoutCubit.get(context).categories.data.data.length}');
      },
      builder: (context , state) {
        final cubit = ShopLayoutCubit.get(context);
        return ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).products != null,
            builder: (context){
              return productsBuilder(cubit , context);
            },
            fallback: (context) {

              return centerCircle();
            }
        );
      },

    );
  }

  Widget productsBuilder (ShopLayoutCubit cubit , BuildContext context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(20.0),
          CarouselSlider(
              items: cubit.products.data.banners.map((li)=> ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage(
                    '${li.image}',
                  ),
                  width: double.infinity,
                  fit: BoxFit.cover,

                ),
              )
              ).toList(),
              options: CarouselOptions(
                height: 180.0,
                aspectRatio: 16/9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )
          ),
          height(10.0),
          line(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(20.0),
                Text(
                  'Categories',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                height(10.0),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategory(cubit.categories.data.data[index]),
                    separatorBuilder: (context, index) => width(10.0,),
                    itemCount: cubit.categories.data.data.length ,
                  ),
                ),
                height(20.0),
                Text(
                  'New Products',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,),
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.75,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children:
              cubit.products.data.products.map((e){
                return buildProduct(e  , cubit, context);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProduct (ProductData data , ShopLayoutCubit cubit,BuildContext context){
    return  GestureDetector(
      onTap: (){
        NavTo(context, ProductScreen(data.id));
      },
      child: Container(
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children :[
                  ImageWithIndecator(
                  image: data.image,
                  width: double.infinity,
                  height: 200.0,
                  ),
                  if(data.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Text(
                      'discount'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      data.name,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    height(5.0),
                    Row(
                      children: [
                        Text(
                          '${data.price.round()} L.E',
                          style:Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 13.0,
                            color: defaultColor,
                          ),
                        ),
                        width(5.0),
                        if(data.discount != 0)
                        Text(
                          '${data.oldPrice.round()}',
                          style:Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: 14.0,
                          onPressed: (){
                            cubit.changeIsFavourite(data.id);
                          },
                          icon: Icon(
                            data.isFavourite? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
  Widget buildCategory(CategoryData category){
    return Container(
      width: 100,
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image:
            NetworkImage(category.image),
            fit: BoxFit.cover,
            width: 100.0,
            height: 100.0,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100.0,
            child: Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  khaled edit 2