import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/modules/home_module/login_page/shop_login_screen.dart';
import 'package:smart_home/shared/components/componanets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String ? ip ;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var  ipController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children:   [
                  const Text('IP Address config',style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 20,),

                  const SizedBox(height: 20,),

                  defaultTextFormField(
                      controller:ipController,
                      textInputType:TextInputType.text,
                      prefix: Icons.email,
                      label: 'Ip Address ( like 192.168.1.5)',
                      hint: 'Enter Ip Address ',
                      validateText: 'IP Address is Empty ',
                      onChang: (value){
                        debugPrint(value);
                      },
                      onSubmit: (value){
                        debugPrint(value);
                      }
                  ),
                  const SizedBox(height: 20,),


                  const SizedBox(height: 20,),
                  defaultButton(
                    background: Colors.blue,
                    text: 'add ip ',
                    width: double.infinity,
                    onPressedFunction: (){
                      if(formKey.currentState!.validate()){
                        setState(() {
                          SettingScreen.ip = ipController.text;
                          print(SettingScreen.ip);
                         // navigateTo(context,AppLoginScreen());
                        });
                      }
                      // emailController.clear();
                      // passwordController.clear();
                    },
                    radius: 5,
                  ),





                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}


