import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';


class DioHelper {

  static Dio ? dio;

  // static init() {
  //   dio = Dio(
  //     BaseOptions(
  //       baseUrl: 'https://student.valuxapps.com/api/',
  //       receiveDataWhenStatusError: true,
  //       // headers: { 'Content-Type': 'application/json',
  //       //   'lang':'ar',},
  //
  //     ),
  //   );
  // }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic> ?query,
    String lang = 'en',
    String ?token,
  }) async
  {
    dio!.options.headers =
    {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response>postDa({
    String ?username,
    String ?password,
    String ?url,
  }) async {
    String userpass = '$username:$password';
    String basicAuth =
        'Basic ' + userpass;
    print(basicAuth);
    return dio!.post ('http://localhost:8080/login',
        options: Options(headers: <String, String>{
          'authorization': basicAuth,
          'Content-Type': 'application/json',
        })
    );
  }

  static Future<Response> postData({
    required String url,
    // required Map<String,dynamic> data,
    Map<String, dynamic> ? query,
    String lang = 'en',
    String ?username,
    String ?password,
    String ? basicAuth
  }) async
  {
    dio!.options.headers =
    {
      'lang': lang,
      'Authorization': basicAuth ?? '',
      'Content-Type': 'application/json',
    };

    basicAuth = 'Basic ' + ('$username:$password');
    return dio!.post(
        url,
        queryParameters: query,
        data: {
          "username": "android",
          "password": "password"
        }

    );
  }


  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');


  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String ?token,
  }) async
  {
    dio!.options.headers =
    {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
  static Future<Response> connection(){


    String username = 'android';
    String password = 'password';
    // String userpass = 'android:password';
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    dio!.post(
        'ws://192.168.1.4:8080/connect',
        data: {
          "username": "android",
          "password": "password"
        });
    IOWebSocketChannel socket = IOWebSocketChannel.connect(
        'ws://192.168.1.4:8080/connect',
        headers:<String, dynamic> {
          'Authorization': basicAuth  ,
          'Content-Type': 'application/json',
        },);
    socket.stream.listen((message) {
      // _recipientCtrl.add(event);
      debugPrint(message);
    });
    return dio!.post(
        'ws://192.168.1.4:8080/connect',
        data: {
        "username": "android",
        "password": "password"
        });


  }


}










