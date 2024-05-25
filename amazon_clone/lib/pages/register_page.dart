
import 'package:amazon_clone/pages/auth_service.dart';
import 'package:amazon_clone/pages/button.dart';
import 'package:amazon_clone/pages/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final email=TextEditingController();
  final password=TextEditingController();
  final confirmPassword=TextEditingController();

  void signUserUp() async{
    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      );
    try{
      if(password.text==confirmPassword.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, 
        password: password.text);     
        Navigator.pop(context); 
      }
      else{
        showErrorMsg("Passwords don't match");
      }
    }on FirebaseAuthException catch (e){

      showErrorMsg(e.code);
    }      
  }

  void showErrorMsg(String message){
     showDialog(
      context: context, 
      builder: (context){
       return  AlertDialog(
        actions: [
          Text(message,style: const TextStyle(fontSize: 20),)
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
              Image.asset('lib/images/amazon.png',height: 35,),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        
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
                padding: const EdgeInsets.all(16),
                child: Text('Let\'s create an account for you', 
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
            //enter password
             Textfield(
              controller: password,
              hintText: 'Enter Password', 
              obstext: true),
            //condirm password
            const SizedBox(
              height: 5,
            ),
            //enter password
             Textfield(
              controller: confirmPassword,
              hintText: 'Confirm Password', 
              obstext: true),
            
            //sign-up
            MyButton(
              text: 'Sign-up',
              ontap: signUserUp
              ),
            //other option
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(child:
                    Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  Text('Or continue with',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),            
                  Expanded(child:
                    Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            //google
            const SizedBox(
              height: 4,
            ),
            SignInButton(
              Buttons.google,
              onPressed: () => AuthService().signinwithGoogle()),
        
            //new to amazon register here
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Login now', 
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            
            ],
          ),
        ),
      ),
    );
  }
}