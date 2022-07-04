class CategoryModel {
  bool status;
  dynamic message;
  CategoriesInfo data;
  CategoryModel.fromJson(Map <String , dynamic> json){
    status = json['status'];
    message = json['message'];
    data = CategoriesInfo.fromJson(json['data']);
  }
}
class CategoriesInfo{
  int currentPage;
  List <CategoryData> data = [];
  CategoriesInfo.fromJson(Map <String , dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((value){
      data.add(CategoryData.fromJson(value));
    });
  }
}
class CategoryData {
  int id;
  String name;
  String image;
  CategoryData.fromJson(Map <String , dynamic> json){
      id = json['id'];
      name =  json['name'];
      image =  json['image'];
  }
}