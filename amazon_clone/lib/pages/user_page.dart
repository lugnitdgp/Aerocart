import 'package:amazon_clone/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  void signout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
          MaterialPageRoute(builder: (context){
            return AuthPage();
      },), (route)=>false
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
          preferredSize: const Size(double.infinity,55),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.cyanAccent,
                    Colors.greenAccent
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,0,10),
                    child: Image.asset('lib/images/amazon.png',height: 35,),
                    ),
                    
                  ]
                ),
              ]
            ),
          ),
       ),
      body: Center(child: IconButton(onPressed:signout,icon:Icon(Icons.logout))),
    );
  }
}