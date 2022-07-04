// search models

class searchProductModel{
  bool status;
  searchProductDataInfo data;
  searchProductModel.fromJson(Map <String , dynamic> json){
    status = json['status'];
      data = searchProductDataInfo.fromJson(json['data']);

  }
}
class searchProductDataInfo{
  List <SearchProductData> data = [];
  int total;
  searchProductDataInfo.fromJson(Map <String , dynamic> json){
    total = json['total'];

    if(json['total'] !=0 ) {
      json['data'].forEach((pro) {
        data.add(SearchProductData.fromJson(pro));
      });
    }
  }
}
class SearchProductData {
  dynamic id;
  String image;
  dynamic price ;
  String name;
  bool isFavourite;
  bool inCart;

  SearchProductData.fromJson(Map <String , dynamic> json){

    id = json['id'];
    image = json['image'];
    price = json['price'];
    name = json['name'];
    isFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}