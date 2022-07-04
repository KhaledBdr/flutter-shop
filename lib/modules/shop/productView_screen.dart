import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shop/cubit/cubits/shopLayoutCubit.dart';
import 'package:shop/cubit/states/shopLayoutStates.dart';
import 'package:shop/models/shop_app/getProduct.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constant.dart';

class ProductScreen extends StatelessWidget {
  dynamic productId;
  ProductScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    print(productId);
    return BlocProvider(
      create:(context)=> ShopLayoutCubit()..getProductFromId(productId),
      child: BlocConsumer<ShopLayoutCubit , ShopLayoutStates>(
        listener: (context, state) {

        },
        builder:(context , state){
          final cubit = ShopLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: ConditionalBuilder(
                condition: state is successGettingProduct,
                fallback: (context) =>Text('Getting Information....',),
                builder:(context)=> Text(
                  cubit.product.data.name,
                  overflow:TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: state is successGettingProduct,
              fallback: (context) => centerCircle(),
              builder: (context)=> ListView(
                padding: EdgeInsetsDirectional.only(
                  start: 20.0,
                  top: 20.0,
                  end: 20.0,
                  bottom: 50.0,
                ),
                shrinkWrap: true,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      ImageWithIndecator(
                        image: cubit.product.data.image,
                        width: double.infinity,
                      ),
                      if(cubit.product.data.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(.7),
                        ),
                        child: Text(
                          '-${cubit.product.data.discount}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  height(20.0,),
                  line(),
                  height(20.0,),
                  Text(
                    'Product Name: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      letterSpacing: 2.0,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${cubit.product.data.name}',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: defaultColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ), // name
                  height(20.0,),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      letterSpacing: 2.0,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0,),
                    child: Text(
                      '${cubit.product.data.description}',
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  height(20.0,),
                  Text(
                    'Price',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      letterSpacing: 2.0,
                      color: Colors.red,
                    ),
                  ),
                  height(5.0,),
                  Row(
                    children: [
                      if(cubit.product.data.discount != 0)
                        Spacer(),
                      if(cubit.product.data.discount == 0)
                        width(20.0,),
                      Text(
                        '${cubit.product.data.price} L.E',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          color: defaultColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Spacer(),
                      if(cubit.product.data.discount != 0)
                      Text(
                        '${cubit.product.data.oldPrice} L.E',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  height(20.0,),
                  line(),
                  height(20.0,),
                  CarouselSlider(
                      items: getCarouselItems(cubit.product.data.images , context),
                      options: Options,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  List getCarouselItems (List <dynamic> images , context){
    List <ClipRRect> CarouselItems= [];
    images.forEach((image) {
      CarouselItems.add( returnClipRRect(image , context));
    });
    return CarouselItems;
  }

  returnClipRRect (image , context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GestureDetector(
        onTap: (){
          NavTo(context , PhotoView(
            imageProvider: NetworkImage(image),
          ) );
        },
        child: ImageWithIndecator(
          image: image,
          width: 350,
          height: 350.0,
        ),
      ),
    );
  }

  CarouselOptions Options = new CarouselOptions(
  height: 350.0,
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
  );
}
