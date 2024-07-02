import 'package:amazon_clone/auth/auth_page.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/utils/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {  
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _LoginPageState();
}

class _LoginPageState extends State<UserDetails> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final username = TextEditingController();
  final address = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    username.dispose();
    address.dispose();
    super.dispose();
  }



  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      
        await firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({"name": username.text, "address": address.text});   
        Navigator.pop(context);     
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const AuthPage();
          },
        ), (route) => false);
        
      
    }catch (e) {
      showErrorMsg(e.toString());
    }
  }

  void showErrorMsg(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Text(
                message,
                style: const TextStyle(fontSize: 20),
              )
            ],
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 3,
        title: Center(
          child: Column(
            children: [
              Image.asset(
                'lib/images/amazon.png',
                height: 35,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 60,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              //welcome back
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Update your address',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              //username
              Textfield(
                  controller: username,
                  hintText: 'Enter Username',
                  obstext: false),
              const SizedBox(
                height: 5,
              ),
              //address
              Textfield(
                  controller: address,
                  hintText: 'Enter address',
                  obstext: false),
              const SizedBox(
                height: 5,
              ),
              // enter gmail
              Textfield(
                  controller: email, hintText: 'Enter Gmail', obstext: false),
              const SizedBox(
                height: 5,
              ),
              //enter password
              Textfield(
                  controller: password,
                  hintText: 'Enter Password',
                  obstext: true),
              //condirm password
              const SizedBox(
                height: 5,
              ),

              //sign-up
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20),
                child: MyButton(text: 'Continue', ontap: signUserUp),
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }
}
