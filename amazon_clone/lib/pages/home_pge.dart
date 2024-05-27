import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signout() async{
    await FirebaseAuth.instance.signOut();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
          title :Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10,8,0,0),
                child: Image.asset('lib/images/amazon.png',height: 35,),
              ),
            ],
          ),
        backgroundColor: Colors.cyanAccent,
        toolbarHeight: 65,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search), iconSize: 30,),         
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined), iconSize: 27,),
          IconButton(onPressed: signout, icon: const Icon(Icons.logout))
        ],
      ),

        body: const Center(child: Text('LOGGED IN!!!')),
      );
  }
}