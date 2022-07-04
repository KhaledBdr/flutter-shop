import 'package:dio/dio.dart';
import 'package:shop/shared/network/remote/end_points.dart';

class DioHelper{
  static Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: BaseURL,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }
      ),
    );
  }

  static Future <Response> getData ({
    String url,
    Map <String , dynamic> query,
    String lang ='en',
    String token,

})async{
    dio.options.headers ={
      'lang' : lang,
      'Authorization' : token,
      'Content-Type': 'application/json',
    };
    return await dio.get(
        url  ,
        queryParameters: query,
    );
  }

  static Future <Response> postData ({
     String path,
     Map <String , dynamic> data,
    String lang ='en',
    String token,
    query
  })async{
    dio.options.headers ={
      'lang' : lang,
      'Authorization' : token??'',
      'Content-Type': 'application/json',
    };
    return dio.post(
      path ,
      data: data,
      queryParameters: query,
    );
  }
}
