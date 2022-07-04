import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubits/shopLayoutCubit.dart';
import 'package:shop/cubit/states/shopLayoutStates.dart';
import 'package:shop/models/shop_app/category.dart';
import 'package:shop/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopLayoutCubit , ShopLayoutStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        final cubit = ShopLayoutCubit.get(context);
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).categories != null,
          fallback: (context) => centerCircle(),
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  buildCategoriesList(
                      cubit.categories ,
                      context
                  ),
                ],
              ),
          ),
        );
      },
    );
  }

  Widget buildCategoriesList (CategoryModel categories ,BuildContext context){
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          height(20.0,),
          Text(
            'All Categories',
            style: Theme.of(context).textTheme.headline6,
          ),
          height(20.0,),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 1/1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: categories.data.data.map((e){
              return buildCategoryCard(e, context);
            }).toList(),
          ),
        ],
      ),
    );
  }
  Widget buildCategoryCard(category , context){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300],
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image(
            image: NetworkImage('${category.image}'),
            height: 150.0,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
            '${category.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }

}
