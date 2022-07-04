import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/states/shopLayoutStates.dart';
import 'package:shop/models/shop_app/favourite.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constant.dart';
import '../../cubit/cubits/shopLayoutCubit.dart';
import 'productView_screen.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLayoutCubit()..getAllFavourites(),
      child: BlocConsumer<ShopLayoutCubit , ShopLayoutStates>(
        listener: (context , state){
        },
        builder: (context, state) => ConditionalBuilder(
          condition: state is! gettingAllFavourite ,
          fallback: (context) => centerCircle(),
          builder:(context)=> ConditionalBuilder(
            condition: ShopLayoutCubit
                .get(context)
                .favourites != null
                &&
                ShopLayoutCubit
                    .get(context)
                    .favourites.data.total != 0,
            fallback: (context)=>
                Center(
                  child : Text(
                    'No Favourites' ,
                    textScaleFactor: 3,
                  ),
                ),
            builder:(context)=>
                Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.all(20.0),
                  child:
                  ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: ShopLayoutCubit.get(context).favourites.data.total,
                    separatorBuilder: (context , index) => height(10.0,),
                    itemBuilder:  (context , index)  => buildItem(
                      ShopLayoutCubit.get(context).favourites.data.data[index].product ,
                      context,
                      ShopLayoutCubit.get(context),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget buildItem (ProductDataModel item , context , ShopLayoutCubit cubit){
    return GestureDetector(
      onTap: (){
        NavTo(context, ProductScreen(item.productId));
      },
      child: Container(
        padding: EdgeInsets.all(5.0,),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWithIndecator(
              image: item.image,
              height: 100.0,
              width: 100.0,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(10.0,),
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15.0,).copyWith(
                        color: defaultColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${item.price}',style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: ' L.E',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            cubit.changeIsFavourite(item.productId);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
