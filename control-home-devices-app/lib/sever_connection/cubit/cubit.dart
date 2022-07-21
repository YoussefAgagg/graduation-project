

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final String endpoint='ws://192.168.1.4:8080/connect';
    //  'ws://android:password@192.168.1.4:8080/connect';
     // 'ws://testwebsocketconection.herokuapp.com/trigger' ;
  bool tableLightIsOn = false;
  bool mainLightIsOn = false;
  bool floorLightIsOn = false;
  bool wifiIsOn = false;
  bool tvLightIsOn = false;
  bool airConditionIsOn = false;
  bool connected = false;



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

  // AutoReconnectWebSocket(endpoint, {delay = 5}) {
  //   socket!.stream.listen((event) {
  //     socket!.sink.add(event);
  //   });
  //   connect();
  //   emit(ReConnectServer());
  // }

  void connect() async{
    String username = 'android';
    String password = 'password';
    // String userpass = 'android:password';
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
        mainLightIsOn = true;
        }else if(message == "livingRoom:lamp1:0"){
         mainLightIsOn = false;
        } else if(message == "livingRoomLamp2:1"){
          tableLightIsOn = true;
        }else if(message == "livingRoomLamp2:0"){
          tableLightIsOn = false;
        } else if(message == "livingRoomLamp3:1"){
          floorLightIsOn = true;
        } else if(message == "livingRoomLamp3:0"){
          floorLightIsOn = false;
        } else if(message == "livingRoomLamp4:1"){
          tvLightIsOn = true;
        } else if(message == "livingRoomLamp4:0"){
          tvLightIsOn = false;
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

  Future<void> listenCmd(String cmd) async {

    if(connected == true){
     // request true or flase
      socket!.stream.listen((message) {
        // _recipientCtrl.add(event);
        // debugPrint(message);
        if (message == "livingRoom:lamp1:1") {
          mainLightIsOn = true;
        } else if (message == "livingRoom:lamp1:0") {
          mainLightIsOn = false;
        } else if (message == "livingRoomLamp2:1") {
          tableLightIsOn = true;
        } else if (message == "livingRoomLamp2:0") {
          tableLightIsOn = false;
        } else if (message == "livingRoomLamp3:1") {
          floorLightIsOn = true;
        } else if (message == "livingRoomLamp3:0") {
          floorLightIsOn = false;
        } else if (message == "livingRoomLamp4:1") {
          tvLightIsOn = true;
        } else if (message == "livingRoomLamp4:0") {
          tvLightIsOn = false;
        }
        emit(ListenMessage());
      });
    }else{
      debugPrint("Websockets is not connected.");
      connect();


    }
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
    print (email+'  '+password);
    try{
      Response  response = await http.post(
        Uri.parse('http://192.168.1.4:8080/login'),
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