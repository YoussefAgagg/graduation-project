
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


Color defaultColor= Colors.blue;

ThemeData lightMode() => ThemeData(
  primarySwatch: Colors.blue,
  splashColor: Colors.black45,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'jannah',
  textTheme: const TextTheme(bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
  )),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(   color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      systemOverlayStyle:SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ) ,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),

      elevation: 0.0
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    elevation: 0.0,
    // unselectedItemColor: Colors.yellow,

  ),



);

ThemeData darkMode() => ThemeData(
  primarySwatch: Colors.blue,
  splashColor: Colors.white,
  fontFamily: 'jannah',
  scaffoldBackgroundColor:  HexColor('333739'),
  textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),

  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: Colors.blue,
      titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      systemOverlayStyle:SystemUiOverlayStyle(
        statusBarColor:HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ) ,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 0.0
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
    opacity: 1.0
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    elevation: 0.0,
    backgroundColor: HexColor('333739'),
  ),



);

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}



