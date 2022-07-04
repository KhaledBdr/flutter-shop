import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubits/shopLayoutCubit.dart';
import 'package:shop/cubit/states/shopLayoutStates.dart';
import 'package:shop/models/shop_app/search.dart';
import 'package:shop/shared/components/components.dart';
import '../../shared/components/constant.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchKey = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopLayoutCubit , ShopLayoutStates>(
      listener: (context, state) {
      },
      builder: (context, state){
        final cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Searching',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                height(20.0),
                input(
                    controller: searchKey,
                    label: 'Type to search',
                    prefixIcon: Icons.saved_search,
                    validator: (String value){
                      if(value.isEmpty || value == null || value.length == 0){
                        return 'Enter the product to search about';
                      }
                      return null;
                    },
                    keyBoard: TextInputType.text,
                    onChange: (String value){
                      cubit.getSearchAboutProducts(value);
                    }
                ),
                ConditionalBuilder(
                    condition: ShopLayoutCubit.get(context).searchResult != null,
                    fallback: (context) {
                      return Column(
                        children: [
                          height(30.0),
                          Center(
                            child: Text(
                              'Type product name to search...',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      );
                    },
                  builder: (context){
                      return ConditionalBuilder(
                        condition: ShopLayoutCubit.get(context).searchResult.data.total != 0,
                        builder: (context)=> searchBuilder(cubit.searchResult , context),
                        fallback: (context) => Column(
                          children: [
                            height(30.0),
                            Center(
                              child: Text(
                                'No Products like this name',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                      );
                      },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
Widget searchBuilder (searchProductModel model  , BuildContext context){
  return Expanded(
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(20.0,),
          Container(
            color: Colors.grey[300],
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children:
                  model.data.data.map((e){
                    return buildProduct(e , context);
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildProduct (SearchProductData data , BuildContext context){
  return  Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: NetworkImage('${data.image}'),
          width: double.infinity,
          height: 200.0,
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
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    iconSize: 14.0,
                    onPressed: (){

                    },
                    icon: Icon(
                      data.isFavourite? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
