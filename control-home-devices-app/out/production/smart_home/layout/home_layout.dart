import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  BlocProvider(create: (BuildContext context) => HomeCubit() ,

    child:   BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Smart Home',
              style: TextStyle(
                color: Colors.black
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            // actions: [
            //   IconButton(
            //     icon: Icon(
            //       Icons.search,
            //     ),
            //     onPressed: () {
            //      // navigateTo(context, SearchScreen());
            //     },
            //   ),
            // ],
          ),
          body:
          cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.verified_user,
                  color: Colors.black,),
                label: 'user',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                label: 'Settings',
              ),
            ],
          ),
          backgroundColor: Colors.white,
        );
      },
    )
    );}













}
