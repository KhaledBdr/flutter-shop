class ProductModel{
  bool status;
  HomeDataModel data;
  ProductModel.fromJson(Map <String , dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel{
  List <BannerData> banners = [];
  List <ProductData> products = [];

  HomeDataModel.fromJson(Map <String , dynamic> json){
    json['banners'].forEach((element){
      BannerData b= BannerData.fromJson(element);
      banners.add(b);
    });

    json['products'].forEach((element){
      ProductData p= ProductData.fromJson(element);
      products.add(p);
    });
    }
}

class BannerData {
  dynamic id;
  String image;
  BannerData.fromJson(Map <String , dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductData {
  dynamic id;
  String image;
  dynamic price ;
  dynamic oldPrice;
  dynamic discount;
  String name;
  bool isFavourite;
  bool inCart;


  ProductData.fromJson(Map <String , dynamic> json){
    id = json['id'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    isFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
