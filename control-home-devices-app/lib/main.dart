import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smart_home/sever_connection/cubit/cubit.dart';
import 'package:smart_home/sever_connection/cubit/states.dart';
import 'package:smart_home/sever_connection/server_connection.dart';
import 'package:smart_home/shared/bloc_observer.dart';
import 'package:smart_home/shared/network/remot/dio_helper.dart';
import 'package:web_socket_channel/io.dart';


import 'layout/home_layout.dart';
import 'modules/home_module/login_page/shop_login_screen.dart';

void main() async{

  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
 // DioHelper.init();

  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

   return BlocProvider(
      create: (BuildContext context) => ServerCubit(),
      child: BlocConsumer<ServerCubit, ServerStates>(
        listener: (BuildContext context, ServerStates state){},
        builder:(context,state) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
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
              fontFamily: 'Jannah' ,
              primarySwatch: Colors.blue,
              splashColor: Colors.white,
              primaryColor:  Colors.grey[100],
              // backgroundColor: const Color(0xFF1A5276),
              disabledColor: Colors.grey[100],
              //colorScheme: ColorScheme.fromSwatch(accentColor: const Color(0xffaf92ea)),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              //primarySwatch: Colors.blue,
            ),
            home:  AppLoginScreen(),
          );
        },
      ),
    );

    // return  MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     appBarTheme: const AppBarTheme(
    //         backgroundColor: Colors.white,
    //         titleTextStyle: TextStyle(   color: Colors.black,
    //             fontSize: 20.0,
    //             fontWeight: FontWeight.bold),
    //         systemOverlayStyle:SystemUiOverlayStyle(
    //           statusBarColor: Colors.white,
    //           statusBarIconBrightness: Brightness.dark,
    //         ) ,
    //         iconTheme: IconThemeData(
    //           color: Colors.black,
    //         ),
    //
    //         elevation: 0.0
    //     ),
    //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //       type: BottomNavigationBarType.fixed,
    //       selectedItemColor: Colors.blue,
    //       elevation: 0.0,
    //       // unselectedItemColor: Colors.yellow,
    //
    //     ),
    //       fontFamily: 'Jannah' ,
    //     primarySwatch: Colors.blue,
    //     splashColor: Colors.white,
    //     primaryColor:  Colors.grey[100],
    //     // backgroundColor: const Color(0xFF1A5276),
    //     disabledColor: Colors.grey[100],
    //     //colorScheme: ColorScheme.fromSwatch(accentColor: const Color(0xffaf92ea)),
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //     //primarySwatch: Colors.blue,
    //   ),
    //   home:  HomeLayout(),
    // );
  }
}


