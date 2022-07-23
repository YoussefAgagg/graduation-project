import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/sever_connection/cubit/cubit.dart';
import 'package:smart_home/sever_connection/cubit/states.dart';
import 'package:smart_home/shared/components/componanets.dart';
import 'package:smart_home/shared/constant/appassets.dart';
import 'package:smart_home/shared/constant/colors/colors.dart';

class Bedroom extends StatelessWidget {

  const Bedroom({Key? key,}) : super(key: key);
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
                          const Text('Bedroom',
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
                                    child: Image.asset(AppAssets.bed,

                                    ),
                                  ),
                                ),

                                const Text(
                                  'Bedroom',
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

                                          if(cubit.bedRoomMainLightIsOn){ //if isLed1On is true, then turn off the led
                                            //if led is on, turn off
                                            cubit.sendCmd('bedRoom:lamp1:0');
                                            cubit.bedRoomMainLightIsOn = false;
                                          }else{ //if isLed1On is false, then turn on the led
                                            //if led is off, turn on
                                            cubit.sendCmd('bedRoom:lamp1:1');
                                            cubit. bedRoomMainLightIsOn = true;

                                        }
                                  },
                                  title: 'Main Light',
                                  subtitle: cubit.bedRoomMainLightIsOn ? cubit.on : cubit.off ,
                                  icon:  Icon(
                                    Icons.lightbulb_outline,
                                    color:cubit.bedRoomMainLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                    size: size.width*0.08,
                                  ),
                                  lightIsOn: cubit.bedRoomMainLightIsOn,
                                  size: size,
                                  subtitleFontSize: size.width*0.03,
                                  titleFontSize: size.width*0.04 ,
                                ),
                              ),
                              Expanded(
                                child: switchBuildItem(
                                    onTap: (){

                                        if(cubit.bedRoomTableLightIsOn){ //if isLed1On is true, then turn off the led
                                          //if led is on, turn off
                                          cubit.sendCmd('bedRoom:lamp2:0');
                                          cubit.bedRoomTableLightIsOn = false;
                                        }else{ //if isLed1On is false, then turn on the led
                                          //if led is off, turn on
                                          cubit.sendCmd('bedRoom:lamp2:1');
                                          cubit. bedRoomTableLightIsOn = true;
                                        }},
                                    title: 'Table lamp',
                                    subtitle: cubit.bedRoomTableLightIsOn ? cubit.on : cubit.off ,
                                    icon: Icon(
                                      Icons.lightbulb_outline,
                                      color: cubit.bedRoomTableLightIsOn ? Colors.yellow.shade600 : Colors.black,
                                      size: iconSize,
                                    ),
                                    lightIsOn: cubit.bedRoomTableLightIsOn,
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