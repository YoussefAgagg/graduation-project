import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/layout/cubit/states.dart';
import 'package:smart_home/modules/home_module/home_screen.dart';
import 'package:smart_home/modules/login_module/login_screen.dart';
import 'package:smart_home/modules/setting_module/setting_screen.dart';
import 'package:web_socket_channel/io.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
     HomeScreen(),
    const SettingScreen(),
    const LoginScreen(),


  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }


  late IOWebSocketChannel socket ;

  var isLed1On = false;
  var isLed2On = false;
  var connected = false;

  channelConnect(){ //function to connect
    try{
      socket = IOWebSocketChannel.connect("ws://testwebsocketconection.herokuapp.com/trigger");
      connected = true;//channel IP : Port
      socket.stream.listen((message) {
        debugPrint(message);
        // socket.sink.add('received!');
        connected = true;

        if (message == "Hello Server!") {
          connected = true; //message is "connected" from NodeMCU
        }
        else if (message == "livingRoomLamp1:1") {
          isLed1On = true;
        } else if (message == "livingRoomLamp1:0") {
          isLed1On = false;
        } else if (message == "livingRoomLamp2:1") {
          isLed2On = true;
        } else if (message == "livingRoomLamp2:0") {
          isLed2On = false;
        }
      },

        onDone: () {
          //if WebSocket is disconnected
          debugPrint("Web socket is closed");
          connected = false;
        },
        onError: (error) {
          debugPrint(error.toString());
        },);
    }catch (_){
      debugPrint("error on connecting to websockets.");
    }
  }

  Future<void> sendCmd(String cmd) async {
    if(connected == true){
      socket.sink.add(cmd);
    }else{
      channelConnect();
      debugPrint("Websockets is not connected.");
    }
  }

  @override
  void dispose() {
    socket.sink.close();

  }


}