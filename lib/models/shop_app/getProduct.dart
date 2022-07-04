class getProductModel{
  bool status;
  getProductData data;
  getProductModel.fromJson(Map <String , dynamic> json){
    status = json['status'];
    data = getProductData.fromJson(json['data']);
  }
}
class getProductData {
  dynamic id;
  String image;
  dynamic price ;
  dynamic oldPrice;
  dynamic discount;
  String name;
  bool isFavourite;
  bool inCart;
  List <dynamic> images;
  String description;

  getProductData.fromJson(Map <String , dynamic> json){
    id = json['id'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    isFavourite = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images'];
    description = json['description'];
  }
}