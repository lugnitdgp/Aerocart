import 'package:amazon_clone/pages/home_pge.dart';
import 'package:amazon_clone/pages/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!=null? HomePage():LoginOrRegister();


    //Scaffold(
    //   body: StreamBuilder<User?>(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context,snapshot) {
    //       if(snapshot.hasData){
    //         return const HomePage();
    //       }
    //       else{
    //         return const LoginOrRegister();
    //       }
    //     },
    //   ),
    // );
  }
}