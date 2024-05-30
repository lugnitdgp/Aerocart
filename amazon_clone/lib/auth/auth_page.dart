import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/login_screens/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!=null? ScreenLayout():LoginOrRegister();
  }
}