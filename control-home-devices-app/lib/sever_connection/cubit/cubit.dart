

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/modules/setting_module/setting_screen.dart';
import 'package:smart_home/sever_connection/cubit/states.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


import 'package:web_socket_channel/io.dart';

class ServerCubit extends Cubit<ServerStates> {

  ServerCubit() : super(CounterInitialState());

  static ServerCubit get(context) => BlocProvider.of(context);

  bool counter = true;
  String on = 'on';
  String off = 'off';
 IOWebSocketChannel? socket ;
  //Future <IOWebSocketChannel> ?connection;
  final StreamController<dynamic> _recipientCtrl = StreamController<dynamic>();
  final StreamController<dynamic> _sentCtrl = StreamController<dynamic>();
    int? delay;
      String ? ip = SettingScreen.ip ;
   String endpoint='ws://${SettingScreen.ip}:8080/connect';
    //  'ws://android:password@192.168.1.4:8080/connect';
     // 'ws://testwebsocketconection.herokuapp.com/trigger' ;
  bool livingRoomTableLightIsOn = false;
  bool livingRoomMainLightIsOn = false;
  bool livingRoomFloorLightIsOn = false;
  bool bedRoomTableLightIsOn = false;
  bool bedRoomMainLightIsOn = false;
  bool garageDoorIsOn = false;
  bool wifiIsOn = false;
  bool tvLightIsOn = false;
  bool airConditionIsOn = false;
   bool  connected = false;
  static String ? username ;
  static String ? password;



  void flap()
  {
    counter = !counter;
    emit(CounterPlusState(counter));
  }

  bool sureConnect(){

    return false ;
  }

  // get stream => _recipientCtrl.stream;

  get sink => _sentCtrl.sink;



  void connect() async{
    print('print ');
    print(username);
    print(password);

    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    socket = IOWebSocketChannel.connect(
      endpoint ,
      headers: {
      'Authorization': basicAuth  ,
    },);
    print(basicAuth);
    connected = true;
    emit(ConnectServer());
    debugPrint('Web socket is connect');
    socket!.stream.listen((message) {
      // _recipientCtrl.add(event);
        debugPrint(message);
       if(message == "livingRoom:lamp1:1"){
        livingRoomMainLightIsOn = true;
        }else if(message == "livingRoom:lamp1:0"){
         livingRoomMainLightIsOn = false;
        } else if(message == "livingRoom:lamp2:1"){
          livingRoomTableLightIsOn = true;
        }else if(message == "livingRoom:lamp2:0"){
          livingRoomTableLightIsOn = false;
        } else if(message == "livingRoom:lamp3:1"){
          livingRoomFloorLightIsOn = true;
        } else if(message == "livingRoom:lamp3:0"){
          livingRoomFloorLightIsOn = false;
        } else if(message == "bedRoom:lamp1:1"){
         bedRoomMainLightIsOn = true;
        } else if(message == "bedRoom:lamp1:0"){
         bedRoomMainLightIsOn = false;
        }else if(message == "bedRoom:lamp2:1"){
         bedRoomTableLightIsOn = true;
       } else if(message == "bedRoom:lamp2:0"){
         bedRoomTableLightIsOn = false;
       }
       else if(message == "garage:door:1"){
         garageDoorIsOn = true;
       } else if(message == "garage:door:0"){
         garageDoorIsOn = false;
       }

         emit(ListenMessage());
    }
    , onError: (e) async {
      _recipientCtrl.addError(e);
      debugPrint(e);
      emit(ErrorConnectServer());
      await Future.delayed(Duration(seconds: delay!));
      connect();
    }, onDone: () async {
      await Future.delayed(const Duration(seconds: 5));
      debugPrint('close sn reconnect');
      emit(OnDonConnectServer());
      connect();
     // AutoReconnectWebSocket(endpoint);
    },
        cancelOnError: true);

  }



  Future<void> sendCmd(String cmd) async {

    if(connected == true){
      socket!.sink.add(cmd);
      emit(SendMessage());
    }else{
      debugPrint("Websockets is not connected.");
      connect();
      // emit(SendMessage());
    }
  }


  void login(String  email ,String  password) async {
    emit(AppLoginLoadingState());
    print ('username:'+email+'  '+'password:'+password);
    try{
      Response  response = await http.post(
        Uri.parse('http://${SettingScreen.ip}:8080/login'),
        body: jsonEncode({
          "username":email,
          "password":password
        }),
        headers: {
          'Content-Type': 'application/json',
        },

      );
      print(response.statusCode);
      print(response.body);

      if(response.statusCode == 200){
        print('Login successfully');
        emit(ShopLoginSuccessState());

      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
      emit(AppLoginErrorState(e.toString()));
    }
  }

  bool isObscure = true;


  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isObscure = !isObscure;
    suffix = isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }





}