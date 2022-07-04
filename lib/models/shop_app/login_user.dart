class UserModel{
  bool status;
  String message;
  UserData data;
  UserModel.fromJson(Map <String , dynamic> json){
    status = json['status'];
    message = json['message'];
    if(status == true) {
      data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    }
  }
}

class UserData{
  dynamic id;
  String name;
  String email;
  String token;
  dynamic phone;
  String image;
  UserData.fromJson(Map <String , dynamic> incomingData){
    id = incomingData['id'];
    name = incomingData['name'];
    email = incomingData['email'];
    token = incomingData['token'];
    phone = incomingData['phone'];
    image = incomingData['image'];
  }
  }