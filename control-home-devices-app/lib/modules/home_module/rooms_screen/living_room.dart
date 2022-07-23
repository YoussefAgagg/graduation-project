
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

                                        if(cubit.livingRoomMainLightIsOn){ //if isLed1On is true, then turn off the led
                                          //if led is on, turn off
                                          cubit.sendCmd('livingRoom:lamp1:0');
                                          cubit.livingRoomMainLightIsOn = false;
                                        }else{ //if isLed1On is false, then turn on the led
                                          //if led is off, turn on
                                          cubit.sendCmd('livingRoom:lamp1:1');
                                          cubit. livingRoomMainLightIsOn = true;
                                      }
                                    },
                                    title: 'Main Light',
                                    subtitle: cubit.livingRoomMainLightIsOn ? cubit.on : cubit.off ,
                                    icon:  Icon(
                                      Icons.lightbulb_outline,
                                      color:cubit.livingRoomMainLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: size.width*0.08,
                                    ),
                                    lightIsOn: cubit.livingRoomMainLightIsOn,
                                    size: size,
                                    subtitleFontSize: size.width*0.03,
                                    titleFontSize: size.width*0.04 ,
                                ),
                              ),
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){
                                       if(cubit.connected){
                                         if(cubit.livingRoomTableLightIsOn){ //if isLed1On is true, then turn off the led
                                           //if led is on, turn off
                                           cubit.sendCmd('livingRoom:lamp2:0');
                                           cubit.livingRoomTableLightIsOn = false;
                                         }else{ //if isLed1On is false, then turn on the led
                                           //if led is off, turn on
                                           cubit.sendCmd('livingRoom:lamp2:1');
                                           cubit. livingRoomTableLightIsOn = true;
                                         }
                                       }
                                       },
                                    title: 'Table lamp',
                                    subtitle: cubit.livingRoomTableLightIsOn ? cubit.on : cubit.off ,
                                    icon: Icon(
                                      Icons.lightbulb_outline,
                                      color: cubit.livingRoomTableLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: iconSize,
                                    ),
                                    lightIsOn: cubit.livingRoomTableLightIsOn,
                                    size: size,
                                  titleFontSize: size.width*0.04
                                ),
                              ),
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){
                                      if(cubit.connected){
                                        if(cubit.livingRoomFloorLightIsOn){ //if isLed1On is true, then turn off the led
                                          //if led is on, turn off
                                          cubit.sendCmd('livingRoom:lamp3:0');
                                          cubit.livingRoomFloorLightIsOn = false;
                                        }else{ //if isLed1On is false, then turn on the led
                                          //if led is off, turn on
                                          cubit.sendCmd('livingRoom:lamp3:1');
                                          cubit. livingRoomFloorLightIsOn = true;
                                        }}},
                                    title: 'Floor Lamp',
                                    subtitle: cubit.livingRoomFloorLightIsOn ? cubit.on : cubit.off ,
                                    icon: Icon(
                                      Icons.lightbulb_outline,
                                      color: cubit.livingRoomFloorLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: iconSize,
                                    ),
                                    lightIsOn: cubit.livingRoomFloorLightIsOn,
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
