import 'package:dio/dio.dart';

class DioHelper{

  static Dio? dio;

  static init(){
    dio=Dio(BaseOptions(
      baseUrl: "https://fcm.googleapis.com/fcm/",
      receiveDataWhenStatusError: true,
      headers: {
          "Content-Type":"application/json",
          "Authorization":"key=AAAAN3RyODI:APA91bEUjN3jyNvsb6o8x5F-3JUMQn-zsh5JEOVq6inH074nLhWAIfEjdmscQbW45W8CrQASZbhiVBvyjcTzeYmCbbV4NRgSsIO5rk0hjRXnLm80NlwmwViZw5WrRXNYbhZUevMZXeE1"
      }
    ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String,dynamic> data,
})async{
   return await dio!.post(url,data:data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String,dynamic> data,
    String? token,
  })async{
    return await dio!.put(url,data:data);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map? data,
    String? token,
    String? language="en",
  })async{
    return await dio!.get(url,queryParameters:query);
  }



}
