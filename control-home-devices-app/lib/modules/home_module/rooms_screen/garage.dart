import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/sever_connection/cubit/cubit.dart';
import 'package:smart_home/sever_connection/cubit/states.dart';
import 'package:smart_home/shared/components/componanets.dart';
import 'package:smart_home/shared/constant/appassets.dart';
import 'package:smart_home/shared/constant/colors/colors.dart';

class garage extends StatelessWidget {
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
                          const Text('Garage',
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
                                    child: Image.asset(AppAssets.garage1,

                                    ),
                                  ),
                                ),

                                const Text(
                                  'Garage',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              switchBuildItem(
                                onTap: (){

                                  if(cubit.garageDoorIsOn){ //if isLed1On is true, then turn off the led
                                    //if led is on, turn off
                                    cubit.sendCmd('garage:door:0');
                                    cubit.garageDoorIsOn = false;
                                  }else{ //if isLed1On is false, then turn on the led
                                    //if led is off, turn on
                                    cubit.sendCmd('garage:door:0');
                                    cubit. garageDoorIsOn = true;

                                  }
                                },
                                title: 'garage door',
                                subtitle: cubit.garageDoorIsOn ? 'open' : 'close' ,
                                icon:  Icon(
                                  Icons.garage_outlined,
                                  color:cubit.garageDoorIsOn ? Colors.yellow.shade600 : Colors.black,
                                  size: size.width*0.08,
                                ),
                                lightIsOn: cubit.garageDoorIsOn,
                                size: size,
                                subtitleFontSize: size.width*0.03,
                                titleFontSize: size.width*0.04 ,
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