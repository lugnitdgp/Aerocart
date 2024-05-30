import 'package:amazon_clone/utils/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPasswordPS extends StatefulWidget {
  const ForgotPasswordPS({super.key});

  @override
  State<ForgotPasswordPS> createState() => _LoginPageState();
}

class _LoginPageState extends State<ForgotPasswordPS> {
  final email=TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  Future passwordreset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
      showErrorMsg('Password reset link sent!!');
    } on FirebaseAuthException catch(e){
      showErrorMsg(e.message.toString());
    }
  }

 void showErrorMsg(String message){
     showDialog(
      context: context, 
      builder: (context){
       return  AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        actions: [
          Text(message,style: const TextStyle(fontSize: 20),)
        ],
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,0,55,0),
            child: Column(
              children: [
                Image.asset('lib/images/amazon.png',height: 35,),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        
      ),
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            children: [     
                const SizedBox(
                  height: 16,
                ),
              //welcome back
                Padding(
                  padding: const EdgeInsets.fromLTRB(22,16,0,5),
                  child: Text('Enter a registered gmail to recieve password reset link', 
                  style: TextStyle(
                    fontSize:17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                    ),
                    ),
                ),
              //enter gmail
              Textfield(
                controller: email,
                hintText: 'Enter Gmail', 
                obstext: false),
              const SizedBox(
                height: 5,
              ),  
              //button
              MaterialButton(
                onPressed: passwordreset,
                elevation: 1,              
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Text('Reset Password', style: TextStyle(fontSize: 16),),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}