import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_home/layout/home_layout.dart';
import 'package:smart_home/modules/home_module/rooms_screen/living_room.dart';
import 'package:smart_home/modules/setting_module/setting_screen.dart';
import 'package:smart_home/sever_connection/cubit/cubit.dart';
import 'package:smart_home/sever_connection/cubit/states.dart';
import 'package:smart_home/shared/components/componanets.dart';
import 'package:smart_home/shared/network/local/cash_helper.dart';

import '../home_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class AppLoginScreen extends StatelessWidget {

  var   emailController = TextEditingController();
  var  passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => ServerCubit(),
      child: BlocConsumer<ServerCubit, ServerStates>(
          listener: (context,state){
             if (state is ShopLoginSuccessState){
               ServerCubit. username =emailController.text;
               ServerCubit. password =passwordController.text;
               print(emailController.text);
               print(passwordController.text);
               ServerCubit.get(context).connect();
               navigateTo(context, HomeLayout());
            }
             else{
               showToast( msg: 'login failed');
             }
            //   } else {
            //     print(state.loginModel.message!);
            //     showToast(msg:state.loginModel.message! );
            //   }
            // }
          },
          builder: (context,state){
            ServerCubit cubit = ServerCubit.get(context);
            return
            Scaffold(appBar: AppBar(
             elevation: 0,
             // backgroundColor: Colors.white54,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    navigateTo(context, SettingScreen());
                  },
                ),
              ],

            ),

              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children:   [
                          const Text('LOGIN',style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          const SizedBox(height: 20,),
                          const Text('Login to Browser',style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey
                          ),),
                          const SizedBox(height: 20,),

                          defaultTextFormField(
                              controller:emailController,
                              textInputType:TextInputType.emailAddress,
                              prefix: Icons.email,
                              label: 'Email Address ',
                              hint: 'Enter Email Address ',
                              validateText: 'Email Address is Empty ',
                              onChang: (value){
                                debugPrint(value);
                              },
                              onSubmit: (value){
                                debugPrint(value);
                              }
                          ),
                          const SizedBox(height: 20,),

                          defaultTextFormField(
                            controller:passwordController,
                            textInputType:TextInputType.visiblePassword,
                            prefix: Icons.lock,
                            label: 'Password ',
                            hint: 'Enter Password',
                            validateText: 'Password is Empty ',
                            onChang: (value){
                              debugPrint(value);
                            },
                            onSubmit: (value){
                              // if(formKey.currentState!.validate()){
                              //   cubit.login(emailController.text, passwordController.text);
                              // }
                            },
                            suffixFunction: (){
                           cubit.changePasswordVisibility();
                            },
                            isPassword: cubit.isObscure,
                            suffix: cubit.suffix
                          ),
                          const SizedBox(height: 20,),
                          ConditionalBuilder(
                            condition: state is! AppLoginLoadingState,
                             builder: (context) => defaultButton(
                               background: Colors.blue,
                               text: 'Login',
                               width: double.infinity,
                               onPressedFunction: (){
                                 if(formKey.currentState!.validate()){
                                   cubit.login(emailController.text, passwordController.text);
                                 }


                                 // emailController.clear();
                                 // passwordController.clear();
                               },
                               radius: 10,
                             ),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     SizedBox.fromSize(
                          //       size: Size(70, 70), // button width and height
                          //       child: ClipOval(
                          //         child: Material(
                          //           color: Colors.green, // button color
                          //           child: InkWell(
                          //             splashColor: Colors.green, // splash color
                          //             onTap: () {
                          //               navigateTo(context, SettingScreen());
                          //             }, // button pressed
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: const <Widget>[
                          //                 Icon(Icons.settings), // icon
                          //                 Text("setting"), // text
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //
                          //     // TextButton(
                          //     //   onPressed: () {
                          //     //
                          //     //   },
                          //     //   child: Text(
                          //     //     'inte Now',
                          //     //   ),
                          //     // ),
                          //   ],),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

            );
          }    )

    );
  }
}
