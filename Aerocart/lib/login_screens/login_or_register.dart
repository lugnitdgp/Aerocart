import 'package:amazon_clone/login_screens/login_page.dart';
import 'package:amazon_clone/login_screens/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showloginpage = true;

  void togglepage(){
    setState(() {
      showloginpage=!showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showloginpage){
      return LoginPage(onTap: togglepage);
    }
    else{
      return RegisterPage(onTap: togglepage,);
    }

  }
}