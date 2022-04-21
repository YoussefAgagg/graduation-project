import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:smart_home/controllers/homescreencontroller.dart';
import 'package:smart_home/modules/home_module/rooms_screen/garage.dart';
import 'package:smart_home/modules/home_module/rooms_screen/living_room.dart';
import 'package:smart_home/shared/AppSpaces.dart';
import 'package:smart_home/shared/components/componanets.dart';
import 'package:smart_home/shared/components/topselectitem.dart';
import 'package:smart_home/shared/constant/appassets.dart';

class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {



   return GetBuilder<HomeScreenController>(

     init: HomeScreenController(),
     builder: (controller) {

     return Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
         children: [
           const TopSelectButton(),
           AppSpaces.vertical10,
           Expanded(
             child: Row(children: [
               roomBuildItem(
                 image: AppAssets.livingRoom2,
                 onTap: (){
                   setState(() {
                     controller.setIndex(0);
                  navigateTo(context, LivingRoom());
                   });
                 },
                 text: 'Living Room',
                 isSelected: controller.index==0,
               ),
               AppSpaces.horizontal20,
               roomBuildItem(
                 image: AppAssets.bedroom1,
                 onTap: (){
                   setState(() {
                     controller.setIndex(1);
                     navigateTo(context,const garage());
                   });
                 },
                 text: 'Bedroom',
                 isSelected: controller.index==1,
               ),
             ]),
           ),
           AppSpaces.vertical20,
           Expanded(
             child: Row(children: [
               roomBuildItem(
                 image: AppAssets.office,
                 onTap: (){
                   setState(() {
                     controller.setIndex(2);
                     navigateTo(context,const garage());
                   });
                 },
                 text: 'Office',
                 isSelected: controller.index==2,
               ),
               AppSpaces.horizontal20,
               roomBuildItem(
                 image: AppAssets.kitchen,
                 onTap: (){
                   setState(() {
                     controller.setIndex(3);
                     navigateTo(context,const garage());
                   });
                 },
                 text: 'Kitchen',
                 isSelected: controller.index==3,
               ),
             ]),
           ),
           AppSpaces.vertical20,
           Expanded(
             child: Row(children: [
               roomBuildItem(
                 image: AppAssets.bathroom,
                 onTap: (){
                   setState(() {
                     controller.setIndex(4);
                     navigateTo(context,const garage());
                   });
                 },
                 text: 'Bathroom',
                 isSelected: controller.index==4,
               ),
               AppSpaces.horizontal20,
               roomBuildItem(
                 image: AppAssets.garage,
                 onTap: (){
                   setState(() {
                     controller.setIndex(5);
                     navigateTo(context,const garage());
                   });
                 },
                 text: 'Garage',
                 isSelected: controller.index==5,
               ),
             ]),
           ),
         ],
       ),
     );
     }
   );



  }
}
