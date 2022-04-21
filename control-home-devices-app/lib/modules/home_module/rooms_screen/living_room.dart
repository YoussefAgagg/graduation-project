
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/shared/components/componanets.dart';
import 'package:smart_home/shared/constant/appassets.dart';
import 'package:smart_home/shared/constant/colors/colors.dart';
import 'package:web_socket_channel/io.dart';

class LivingRoom extends StatefulWidget {
  // const LivingRoom({Key? key, required this.size}) : super(key: key);
  // final Size size;


  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  bool tableLightIsOn = false;
  bool mainLightIsOn = false;
  bool floorLightIsOn = false;
  bool wifiIsOn = false;
  bool tvLightIsOn = false;
  bool airConditionIsOn = false;
  String on = 'on';
  String off = 'off';
  late IOWebSocketChannel socket ;
  var connected = false;

  // @override
  // void initState() {
  //   tableLightIsOn = false; //initially isLed1On is off so its FALSE
  //   floorLightIsOn = false; //initially isLed2On is off so its FALSE
  //   connected = false; //initially connection status is "NO" so its FALSE
  //
  //   Future.delayed(Duration.zero,() async {
  //     channelConnect();
  //     //connect to WebSocket wth NodeMCU
  //   });
  //
  //   super.initState();
  // }

 // ws://testwebsocketconection.herokuapp.com/trigger
  //ws://testwebsocketconection.herokuapp.com/trigger
 // ws://192.168.43.14:8080/connect
  channelConnect(){ //function to connect
    try{
      socket = IOWebSocketChannel.connect("ws://192.168.1.4:8080/connect");
      connected = true;
      debugPrint('Web socket is connect');
       //channel IP : Port
      socket.stream.listen((message) {
        debugPrint(message);
        // socket.sink.add('received!');
        connected = true;
        setState(() {
          if(message == "Hello Server!"){
            connected = true; //message is "connected" from NodeMCU
          }
          else if(message == "livingRoomLamp2:1"){
            tableLightIsOn = true;
          }else if(message == "livingRoomLamp2:0"){
            tableLightIsOn = false;
          } else if(message == "livingRoomLamp3:1"){
            floorLightIsOn = true;
          } else if(message == "livingRoomLamp3:0"){
            floorLightIsOn = false;
          }  else if(message == "livingRoomLamp1:1"){
            mainLightIsOn = true;
          }else if(message == "livingRoomLamp1:0"){
            mainLightIsOn = false;
          } else if(message == "livingRoomLamp4:1"){
            tvLightIsOn = true;
          } else if(message == "livingRoomLamp4:0"){
            tvLightIsOn = false;
          }

        });
      },

        onDone: () {

       // if WebSocket is disconnected
          debugPrint("Web socket is closed");
          setState(() {
            connected = false;
          });
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
      debugPrint("Websockets is not connected.");
      setState(() {
        channelConnect();
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconSize = size.width*0.08;
    double subtitleSize = size.width*0.10;

      return Scaffold(
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
                                setState(() {
                                  channelConnect();
                                  if(mainLightIsOn){ //if isLed1On is true, then turn off the led
                                    //if led is on, turn off
                                    sendCmd("livingRoomLamp1:0");
                                    mainLightIsOn = false;
                                  }else{ //if isLed1On is false, then turn on the led
                                    //if led is off, turn on
                                    sendCmd("livingRoomLamp1:1");
                                    mainLightIsOn = true;
                                  }
                                  //mainLightIsOn = !mainLightIsOn;
                                });
                              },
                              title: 'Main Light',
                              subtitle: mainLightIsOn ? on : off ,
                              icon:  Icon(
                                Icons.lightbulb_outline,
                                color:mainLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                size: size.width*0.08,
                              ),
                              lightIsOn: mainLightIsOn,
                              size: size,
                              subtitleFontSize: size.width*0.03,
                              titleFontSize: size.width*0.04 ,
                          ),
                        ),
                        Expanded(
                          child: switchBuildItem(
                              onTap: (){
                                setState(() {
                                  channelConnect();
                                  if(connected){
                                    if(tableLightIsOn){ //if isLed1On is true, then turn off the led
                                      //if led is on, turn off
                                      sendCmd("livingRoomLamp2:0");
                                      tableLightIsOn = false;
                                    }else{ //if isLed1On is false, then turn on the led
                                      //if led is off, turn on
                                      sendCmd("livingRoomLamp2:1");
                                      tableLightIsOn = true;
                                    }
                                  }

                                 // tableLightIsOn = !tableLightIsOn;

                                });},
                              title: 'Table lamp',
                              subtitle: tableLightIsOn ? on : off ,
                              icon: Icon(
                                Icons.lightbulb_outline,
                                color: tableLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                size: iconSize,
                              ),
                              lightIsOn: tableLightIsOn,
                              size: size,
                            titleFontSize: size.width*0.04
                          ),
                        ),
                        Expanded(
                          child: switchBuildItem(
                              onTap: (){
                                setState(() {
                                  channelConnect();
                                  if(floorLightIsOn){ //if isLed1On is true, then turn off the led
                                    //if led is on, turn off
                                    sendCmd("livingRoomLamp3:0");
                                    floorLightIsOn = false;
                                  }else{ //if isLed1On is false, then turn on the led
                                    //if led is off, turn on
                                    sendCmd("livingRoomLamp3:1");
                                    floorLightIsOn = true;
                                  }
                                 // floorLightIsOn = !floorLightIsOn;
                                });},
                              title: 'Floor Lamp',
                              subtitle: floorLightIsOn ? on : off ,
                              icon: Icon(
                                Icons.lightbulb_outline,
                                color: floorLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                size: iconSize,
                              ),
                              lightIsOn: floorLightIsOn,
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
                                setState(() {
                                  wifiIsOn = !wifiIsOn;
                                });
                                },
                              title: 'wifi',
                              subtitle: '50' ,
                              icon:  Icon(
                                Icons.wifi,
                                color: wifiIsOn ? Colors.green : Colors.black,
                                size: iconSize,
                              ),
                              lightIsOn: wifiIsOn,
                              size: size
                          ),
                        ),
                        Expanded(
                          child: switchBuildItem(
                              onTap: (){
                                setState(() {
                                  channelConnect();
                                  if(tvLightIsOn){ //if isLed1On is true, then turn off the led
                                    //if led is on, turn off
                                    sendCmd("livingRoomLamp4:0");
                                    tvLightIsOn = false;
                                  }else{ //if isLed1On is false, then turn on the led
                                    //if led is off, turn on
                                    sendCmd("livingRoomLamp4:1");
                                    tvLightIsOn = true;
                                  }
                                  //tvLightIsOn = !tvLightIsOn;
                                });
                                },
                              title: 'TV',
                              subtitle: tvLightIsOn ? on : off ,
                              icon: Icon(
                                Icons.tv_outlined,
                                color: tvLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                size: iconSize,
                              ),
                              lightIsOn: tvLightIsOn,
                              size: size
                          ),
                        ),
                        Expanded(
                          child: switchBuildItem(
                              onTap: (){
                                setState(() {
                                  airConditionIsOn = !airConditionIsOn;
                                });},
                              title: 'Air Condition',
                              subtitle: airConditionIsOn ? on : off ,
                              icon: Icon(
                                Icons.air,
                                color: airConditionIsOn ? Colors.yellow.shade600 : Colors.black,
                                size: iconSize,
                              ),
                              lightIsOn: airConditionIsOn,
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
                          lightIsOn: airConditionIsOn,
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

    //     Container(
    //     alignment: FractionalOffset.center,
    //     child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //     Padding(
    //     padding: const EdgeInsets.all(8.0),
    // child: Icon(
    // Icons.lightbulb_outline,
    // color: _lightIsOn ? Colors.yellow.shade600 : Colors.black,
    // size: 60,),)
    // ],)
    // ,);
      //   Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           CardField(
      //               size,
      //               const Icon(
      //                 Icons.lightbulb_outline,
      //                 color: Colors.orange,
      //               ),
      //               'Main Light',
      //               '50%'),
      //           CardField(size, const Icon(Icons.lightbulb_outline, color: Colors.grey),
      //               'Table Lamp', 'Off'),
      //           CardField(size, const Icon(Icons.lightbulb_outline, color: Colors.grey),
      //               'Floor Lamp', 'Off'),
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           CardField(
      //               size,
      //               const Icon(
      //                 Icons.music_note_outlined,
      //                 color: Colors.amber,
      //               ),
      //               'Speaker',
      //               '50%'),
      //           CardField(
      //               size, const Icon(Icons.radio, color: Colors.grey), 'Socket', 'Off'),
      //           CardField(size, const Icon(Icons.wifi_outlined, color: Colors.green),
      //               'Sensor', 'Off'),
      //         ],
      //       ),
      //       CardField(
      //           size,
      //           const Icon(
      //             Icons.air,
      //             color: Colors.teal,
      //           ),
      //           'Air Condition',
      //           '50%'),
      //     ],
      //   ),
      // );

  }
}
// GestureDetector(
//
//   onTap: (){
//     setState(() {
//       _lightIsOn = !_lightIsOn;
//     });
//     },
//   child: Card(
//     child: SizedBox(
//       height: size.width * .27,
//       width: size.width * .29,
//       child: Center(
//         child: Column(
//             children: [
//               ListTile(
//                 leading: Icon(
//                  Icons.lightbulb_outline,
//                  color: _lightIsOn ? Colors.yellow.shade600 : Colors.black,
//                size: 40,
//               ),
//                 title: const Text(
//                   'On ',
//                   style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               const Text(
//                 'floor lamp ',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14),
//               ),
//             ]),
//       ),
//     ),
//   ),
// ),