import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/layout/cubit/states.dart';
import 'package:smart_home/modules/home_module/home_screen.dart';
import 'package:smart_home/modules/home_module/login_page/shop_login_screen.dart';
import 'package:smart_home/modules/setting_module/setting_screen.dart';
import 'package:web_socket_channel/io.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
     HomeScreen(),
     AppLoginScreen(),
    const SettingScreen(),

  ];
  List<String> title = [
    'Hi yousef',
    '',
    '',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }




}