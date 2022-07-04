import 'package:shop/shared/components/constant.dart';

class FavouriteModel{
  bool status;
  FavouriteDataModel data;
  FavouriteModel.fromJson(Map <String , dynamic> json){
    status = json['status'];
    data = FavouriteDataModel.fromJson(json['data']);
  }
}

class FavouriteDataModel{
  int total;
  List <DataDataModel> data = [];
  FavouriteDataModel.fromJson(Map <String , dynamic> json){
    total = json['total'];
    if( json['total'] != 0) {
      json['data'].forEach((value) {
        DataDataModel newModel = DataDataModel.fromJson(value);
        data.add(newModel);
      });
    }
  }
}
class DataDataModel{
  int favouriteId;
  ProductDataModel product;
  DataDataModel.fromJson(Map <String , dynamic> json){
    favouriteId = json['id'];
    product = ProductDataModel.fromJson(json['product']);
  }
}

class ProductDataModel{
  int productId;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String name;
  String image;
  ProductDataModel.fromJson(Map <String , dynamic> json){
    productId = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
  }
}