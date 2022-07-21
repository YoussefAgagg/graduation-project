
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/sever_connection/cubit/cubit.dart';
import 'package:smart_home/sever_connection/cubit/states.dart';
import 'package:smart_home/shared/components/componanets.dart';
import 'package:smart_home/shared/constant/appassets.dart';
import 'package:smart_home/shared/constant/colors/colors.dart';
import 'package:smart_home/shared/network/remot/dio_helper.dart';
import 'package:web_socket_channel/io.dart';

class LivingRoom extends StatelessWidget {
  // const LivingRoom({Key? key, required this.size}) : super(key: key);
  // final Size size;


 //  bool tableLightIsOn = false;
 //  bool mainLightIsOn = false;
 //  bool floorLightIsOn = false;
 //  bool wifiIsOn = false;
 //  bool tvLightIsOn = false;
 //  bool airConditionIsOn = false;
 //  String on = 'on';
 //  String off = 'off';
 //  late IOWebSocketChannel socket ;
 //  var connected = false;
 //
 //  // @override
 //  // void initState() {
 //  //   tableLightIsOn = false; //initially isLed1On is off so its FALSE
 //  //   floorLightIsOn = false; //initially isLed2On is off so its FALSE
 //  //   connected = false; //initially connection status is "NO" so its FALSE
 //  //
 //  //   Future.delayed(Duration.zero,() async {
 //  //     channelConnect();
 //  //     //connect to WebSocket wth NodeMCU
 //  //   });
 //  //
 //  //   super.initState();
 //  // }
 //
 // // ws://testwebsocketconection.herokuapp.com/trigger
 //  //ws://testwebsocketconection.herokuapp.com/trigger
 // // ws://192.168.43.14:8080/connect
 //  channelConnect(){ //function to connect
 //    try{
 //      socket = IOWebSocketChannel.connect("ws://android:password@192.168.1.4:8080/connect");
 //      connected = true;
 //      debugPrint('Web socket is connect');
 //       //channel IP : Port
 //      socket.stream.listen((message) {
 //        debugPrint(message);
 //        // socket.sink.add('received!');
 //        connected = true;
 //        // setState(() {
 //        //   if(message == "Hello Server!"){
 //        //     connected = true; //message is "connected" from NodeMCU
 //        //   }
 //        //   else if(message == "livingRoomLamp2:1"){
 //        //     tableLightIsOn = true;
 //        //   }else if(message == "livingRoomLamp2:0"){
 //        //     tableLightIsOn = false;
 //        //   } else if(message == "livingRoomLamp3:1"){
 //        //     floorLightIsOn = true;
 //        //   } else if(message == "livingRoomLamp3:0"){
 //        //     floorLightIsOn = false;
 //        //   }  else if(message == "livingRoom:lamp1:1"){
 //        //     mainLightIsOn = true;
 //        //   }else if(message == "livingRoom:lamp1:0"){
 //        //     mainLightIsOn = false;
 //        //   } else if(message == "livingRoomLamp4:1"){
 //        //     tvLightIsOn = true;
 //        //   } else if(message == "livingRoomLamp4:0"){
 //        //     tvLightIsOn = false;
 //        //   }
 //        //
 //        // });
 //      },
 //
 //        onDone: () {
 //
 //       // if WebSocket is disconnected
 //          debugPrint("Web socket is closed");
 //          // setState(() {
 //          //   connected = false;
 //          // });
 //        },
 //
 //        onError: (error) {
 //          debugPrint(error.toString());
 //        },);
 //    }catch (_){
 //      debugPrint("error on connecting to websockets.");
 //    }
 //  }



  // Future<void> sendCmd(String cmd) async {
  //   if(connected == true){
  //     socket.stream.listen((message) {
  //       // _recipientCtrl.add(event);
  //       // debugPrint(message);
  //       if (message == "livingRoom:lamp1:1") {
  //         mainLightIsOn = true;
  //       } else if (message == "livingRoom:lamp1:0") {
  //         mainLightIsOn = false;
  //       } else if (message == "livingRoomLamp2:1") {
  //         tableLightIsOn = true;
  //       } else if (message == "livingRoomLamp2:0") {
  //         tableLightIsOn = false;
  //       } else if (message == "livingRoomLamp3:1") {
  //         floorLightIsOn = true;
  //       } else if (message == "livingRoomLamp3:0") {
  //         floorLightIsOn = false;
  //       } else if (message == "livingRoomLamp4:1") {
  //         tvLightIsOn = true;
  //       } else if (message == "livingRoomLamp4:0") {
  //         tvLightIsOn = false;
  //       }
  //     });
  //     }else{
  //     debugPrint("Websockets is not connected.");
  //     // setState(() {
  //     //   channelConnect();
  //     // });
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconSize = size.width*0.08;
    double subtitleSize = size.width*0.10;

    return BlocProvider(
      create: (BuildContext context) => ServerCubit(),
      child: BlocConsumer<ServerCubit, ServerStates>(
        listener: (BuildContext context, ServerStates state)
        {},
        builder: (BuildContext context, ServerStates state)
        {
          var cubit = ServerCubit.get(context);
          return  Scaffold(
              body: Center(
                child:Container(
                  color: Colors.white,
                  child: Padding(
                    padding:  const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50,),
                       const Text('Living Room',
                       style: TextStyle(
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                         fontSize: 35
                       ),),
                          const SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:  ChooseColor.defaultBackgroundColor ,
                            ),
                            child: Stack(
                              alignment:AlignmentDirectional.bottomStart ,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width:double.infinity,
                                    height: 200,
                                    child: Image.asset(AppAssets.livingRoomImage,

                                    ),
                                  ),
                                ),

                                const Text(
                                  'Living Room',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],

                            ),
                          ),
                          const SizedBox(height: 20,),

                          Row(
                            children: [
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){
                                    //  cubit.connect();
                                        if(cubit.mainLightIsOn){ //if isLed1On is true, then turn off the led
                                          //if led is on, turn off
                                          cubit.sendCmd('livingRoom:lamp1:0');
                                          cubit.mainLightIsOn = false;
                                        }else{ //if isLed1On is false, then turn on the led
                                          //if led is off, turn on
                                          cubit.sendCmd('livingRoom:lamp1:1');
                                         cubit. mainLightIsOn = true;
                                        }

                                    },
                                    title: 'Main Light',
                                    subtitle: cubit.mainLightIsOn ? cubit.on : cubit.off ,
                                    icon:  Icon(
                                      Icons.lightbulb_outline,
                                      color:cubit.mainLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: size.width*0.08,
                                    ),
                                    lightIsOn: cubit.mainLightIsOn,
                                    size: size,
                                    subtitleFontSize: size.width*0.03,
                                    titleFontSize: size.width*0.04 ,
                                ),
                              ),
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){
                                      // setState(() {
                                      //   channelConnect();
                                      //   if(connected){
                                      //     if(tableLightIsOn){ //if isLed1On is true, then turn off the led
                                      //       //if led is on, turn off
                                      //       sendCmd("livingRoomLamp2:0");
                                      //       tableLightIsOn = false;
                                      //     }else{ //if isLed1On is false, then turn on the led
                                      //       //if led is off, turn on
                                      //       sendCmd("livingRoomLamp2:1");
                                      //       tableLightIsOn = true;
                                      //     }
                                      //   }
                                      // })
                                      ;},
                                    title: 'Table lamp',
                                    subtitle: cubit.tableLightIsOn ? cubit.on : cubit.off ,
                                    icon: Icon(
                                      Icons.lightbulb_outline,
                                      color: cubit.tableLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: iconSize,
                                    ),
                                    lightIsOn: cubit.tableLightIsOn,
                                    size: size,
                                  titleFontSize: size.width*0.04
                                ),
                              ),
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){
                                      // setState(() {
                                      //   channelConnect();
                                      //   if(floorLightIsOn){ //if isLed1On is true, then turn off the led
                                      //     //if led is on, turn off
                                      //     sendCmd("livingRoomLamp3:0");
                                      //     floorLightIsOn = false;
                                      //   }else{ //if isLed1On is false, then turn on the led
                                      //     //if led is off, turn on
                                      //     sendCmd("livingRoomLamp3:1");
                                      //     floorLightIsOn = true;
                                      //   }
                                      //  // floorLightIsOn = !floorLightIsOn;
                                      // });
                                      },
                                    title: 'Floor Lamp',
                                    subtitle: cubit.floorLightIsOn ? cubit.on : cubit.off ,
                                    icon: Icon(
                                      Icons.lightbulb_outline,
                                      color: cubit.floorLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: iconSize,
                                    ),
                                    lightIsOn: cubit.floorLightIsOn,
                                    size: size
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),

                          Row(
                            children: [
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){
                                      // setState(() {
                                      //   wifiIsOn = !wifiIsOn;
                                      // });
                                      },
                                    title: 'wifi',
                                    subtitle: '50' ,
                                    icon:  Icon(
                                      Icons.wifi,
                                      color: cubit.wifiIsOn ? Colors.green : Colors.black,
                                      size: iconSize,
                                    ),
                                    lightIsOn:cubit. wifiIsOn,
                                    size: size
                                ),
                              ),
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){
                                      // setState(() {
                                      //   channelConnect();
                                      //   if(tvLightIsOn){ //if isLed1On is true, then turn off the led
                                      //     //if led is on, turn off
                                      //     sendCmd("livingRoomLamp4:0");
                                      //     tvLightIsOn = false;
                                      //   }else{ //if isLed1On is false, then turn on the led
                                      //     //if led is off, turn on
                                      //     sendCmd("livingRoomLamp4:1");
                                      //     tvLightIsOn = true;
                                      //   }
                                      //   //tvLightIsOn = !tvLightIsOn;
                                      // });
                                      },
                                    title: 'TV',
                                    subtitle: cubit.tvLightIsOn ? cubit.on : cubit.off ,
                                    icon: Icon(
                                      Icons.tv_outlined,
                                      color: cubit.tvLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: iconSize,
                                    ),
                                    lightIsOn: cubit.tvLightIsOn,
                                    size: size
                                ),
                              ),
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){
                                      // setState(() {
                                      //   airConditionIsOn = !airConditionIsOn;
                                      // });
                                      },
                                    title: 'Air Condition',
                                    subtitle: cubit.airConditionIsOn ? cubit.on : cubit.off ,
                                    icon: Icon(
                                      Icons.air,
                                      color: cubit.airConditionIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: iconSize,
                                    ),
                                    lightIsOn: cubit.airConditionIsOn,
                                    size: size
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),

                          Container(
                            width: double.infinity,
                            child: switchBuildItem(
                                onTap: (){},
                                title: 'Speaker',
                                subtitle: '50%' ,
                                icon:  Icon(
                                  Icons.music_note_outlined,
                                  color: Colors.black,
                                  size: iconSize,
                                ),
                                lightIsOn: cubit.airConditionIsOn,
                                size: size
                            ),
                          ),






                        ],
                      ),
                    ),
                  ),
                )

              ),
            );


        },
      ),
    );


  }
}
