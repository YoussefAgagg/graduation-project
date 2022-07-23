import 'dart:convert';
import 'dart:io';

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_home/modules/home_module/login_page/cubit/states.dart';
import 'package:smart_home/modules/home_module/rooms_screen/living_room.dart';
import 'package:smart_home/shared/components/componanets.dart';
import 'package:smart_home/shared/network/end_point.dart';
import 'package:smart_home/shared/network/remot/dio_helper.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//
//
//
// import '../../home_screen.dart';
// import '../shop_login_screen.dart';
//
//
// class AppLoginCubit extends Cubit<AppLoginStates> {
//
//   AppLoginCubit() : super(LoginInitialState());
//
//
//   static AppLoginCubit get(context) => BlocProvider.of(context);
//
//  // ShopLoginModel ? loginModel ;
//   bool isObscure = true;
//
//
//   IconData suffix = Icons.visibility_outlined;
//
//   void changePasswordVisibility() {
//     isObscure = !isObscure;
//     suffix = isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//     emit(ChangePasswordVisibilityState());
//   }
//
//   void userLogin({required String email, required String password}) {
//     emit(AppLoginLoadingState());
//
//     DioHelper.postDa(username: email,password:password );
//     emit(ShopLoginSuccessState());
//
//   }
//   void login(String  email ,String  password) async {
//     emit(AppLoginLoadingState());
//     try{
//      String userpass = '$email:$password';
//       String basicAuth =
//           'Basic ' + base64.encode(utf8.encode(userpass));
//
//       print(basicAuth);
//
//      Response  response = await post(
//          Uri.parse('http://192.168.1.4:8080/login'),
//           body: jsonEncode({
//             "username":email,
//             "password":password
//           }),
//        headers: {
//          // 'Authorization': basicAuth ?? '',
//          'Content-Type': 'application/json',
//        },
//
//       );
//       // var jsonData = jsonDecode(response.body);
//       // print(jsonData);
//       print(response.statusCode);
//       print(response.body);
//
//       if(response.statusCode == 200){
//        // var data = jsonDecode(response.body.toString());
//         print('Login successfully');
//         emit(ShopLoginSuccessState());
//
//
//       }else {
//         print('failed');
//       }
//     }catch(e){
//       print(e.toString());
//       emit(AppLoginErrorState(e.toString()));
//     }
//   }
//
//   final String _baseUrl = 'http://192.168.1.4:8080/login';
//
//   Future authenticateUser(String username, String password) async {
//
//
//     try {
//       final response = await http.post( Uri.parse('http://192.168.1.4:8080/login'), body: {
//         'username': username,
//         'password': password,
//       });
//
//       switch (response.statusCode) {
//         case 200:
//           print('success');
//           break;
//         case 401:
//           print('error 404');
//           break;
//         default:
//           print('efaild');
//           break;
//       }
//     } on SocketException {
//       print('SocketException');
//     }
//   }
//
//
//
//
//
//
// }
