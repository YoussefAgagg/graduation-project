
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:smart_home/shared/constant/colors/colors.dart';

import '../appspaces.dart';


  Widget defaultTextFormField(
      {
       required  TextEditingController controller,
       required TextInputType ? textInputType,
       double   radius = 0,
       required IconData  prefix,
       IconData ? suffix,
       bool isPassword = false,
      Function ? suffixFunction ,
      required String  label ,
      String ? hint,
      Function ? onChang,
      Function ? onSubmit,
      String ? validateText,
      Function ? onTap,

    }) =>
    TextFormField(
                  validator: (value){
                    if (value!.isEmpty){
                      return validateText ;
                    }
                    return null;
                  },
                     controller: controller,
                     keyboardType: textInputType,
                     decoration:   InputDecoration(
                     border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(radius))),
                    prefixIcon: Icon(prefix,),
                       suffixIcon:
                       IconButton(
                           onPressed: (){
                             suffixFunction!();
                           },
                           icon: Icon(suffix)
                       ),
                    labelText: label,
                   hintText: hint,
                   // hintStyle: TextStyle(fontSize: 15,),
                  ),
                     onChanged: (value){
                       onChang!(value); },
                  onFieldSubmitted: (value){
                    onSubmit!(value);},
               obscureText: isPassword,
      onTap: (){
        onTap!();
      },
);


Widget defaultButton(
    { required Color  background ,
       required double width ,
       required Function  onPressedFunction ,
      required String text,
      bool isUpperCase = true,
       double radius = 0,
                 }     ) =>
    Container(
      width: double.infinity,
      child: MaterialButton(

        onPressed: (){
          onPressedFunction();
          },
        child: Text( isUpperCase? text.toUpperCase():text,
          style: const TextStyle(
          color: Colors.white,
        ),),
      ),

      decoration: BoxDecoration(color: background,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void navigateTo(context, widget)=>  Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> widget));

void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=> widget), (route) => false);

void showToast({required String msg}) =>  Fluttertoast.showToast(
    msg: msg ,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
);

Widget roomBuildItem (
{
  required String image,
  required String text,
  required bool isSelected,
  required VoidCallback onTap,
  double ? fontSize = 18,
  Color? unSelectedImageColor,
})=> Expanded (
      child: GestureDetector(
        onTap: (){
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            //gradient: isSelected ? appGradient : null,
            color: !isSelected ? ChooseColor.defaultBackgroundColor : ChooseColor.defaultColor,
           // color: !isSelected ? ChooseColor.defaultBackgroundColor: ChooseColor.defaultColor,
            //!isSelected ? Colors.grey[100] : const Color(0xFF1A5276),
          ),
          child: Column(children: [
            AppSpaces.vertical15,
            Center(
              child: SizedBox(
                width: Get.width/ 5,
                height: Get.height / 10,
                child: Image.asset(image,
                 // color: isSelected ? Colors.white :  Get.theme.primaryColor,
                  //isSelected ? Colors.white : const Color(0xFF1A5276),
                ),
              ),
            ),
            AppSpaces.vertical15,
             Text(
              text,
                style: TextStyle(
                color:  isSelected ? Colors.white : Colors.black,
                fontSize: fontSize , ),
            ),
            AppSpaces.vertical15,
          ]),
        ),
      ),
    );

       Widget switchBuildItem({
         required Icon icon,
         required String title,
         required String subtitle,
         required bool lightIsOn,
         required VoidCallback onTap,
         double ? subtitleFontSize = 17,
         double ? titleFontSize = 14,
         Size ? size,
         Color? unSelectedImageColor,
})=>    GestureDetector(
         onTap: (){
           onTap();
         },
         child: Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
           ),
           child: Card(
             color: ChooseColor. defaultBackgroundColor,
             child: SizedBox(
                 height: size!.width * 0.27,
                 width: size.width * 0.30,
               child: Center(
                 child: Column(
                     children: [
                       ListTile(
                         leading : icon ,
                         title:  Text(
                           subtitle ,
                           style: TextStyle(
                               color: Colors.grey,
                               fontWeight: FontWeight.bold,
                               fontSize: size.width*0.03
                           ),
                         ),
                       ),
                       const SizedBox(height: 10,),
                        Text(
                         title,
                         style:  TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: size.width*0.03),
                       ),
                     ]),
               ),
             ),
           ),
         ),
       );


final appGradient = LinearGradient(
  colors: [
    Get.theme.primaryColor,
    Get.theme.colorScheme.secondary,
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);




// CardField(
//     Size size,
//     Icon icon,
//     String title,
//     String subtitle,
//     ) {
//   return Card(
//       child: SizedBox(
//           height: size.width * .23,
//           width: size.width * .26,
//           child: Center(
//             child: Column(children: [
//               ListTile(
//                 leading: icon,
//                 title: Text(
//                   subtitle,
//                   style: const TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 13),
//                 ),
//               ),
//               Text(
//                 title,
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14),
//               ),
//             ]),
//           )));
// }



