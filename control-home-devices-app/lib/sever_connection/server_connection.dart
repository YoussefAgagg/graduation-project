import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';



class Server {

  late IOWebSocketChannel socket ;

  var isLed1On = false;
  var isLed2On = false;
  var connected = false;

   channelConnect(){ //function to connect
    try{
      socket = IOWebSocketChannel.connect("ws://android:password@192.168.1.4:8080/connect");
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