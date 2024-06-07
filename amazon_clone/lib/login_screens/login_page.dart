
import 'package:amazon_clone/auth/auth_page.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/login_screens/forgot_pw_page.dart';
import 'package:amazon_clone/utils/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email=TextEditingController();
  final password=TextEditingController();

  void signinwithGoogle() async{
    //interctive signin process
    final GoogleSignInAccount? gUser= await GoogleSignIn().signIn();
    //obtain details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create a new credential for user
    final credential =GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //sign in
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
         context,
          MaterialPageRoute(builder: (context){
            return AuthPage();
      },), (route)=>false
      );
    }on FirebaseAuthException catch (e) {
      showErrorMsg(e.toString());
    }
  }


  void signUserIn() async{
    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text, 
      password: password.text);Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
         context,
          MaterialPageRoute(builder: (context){
            return AuthPage();
      },), (route)=>false
    );
    }on FirebaseAuthException catch (e){
      Navigator.pop(context);
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
          Text(message.trim(),style: const TextStyle(fontSize: 20),)
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
          child: Column(
            children: [
              Image.asset('lib/images/amazon.png',height: 35,),
            ],
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
                padding: const EdgeInsets.all(16),
                child: Text('Welcome Back you\'ve been missed', 
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
            //forgot password
             Padding(
              padding: EdgeInsets.fromLTRB(0,5,25,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context){
                          return ForgotPasswordPS();
                        },
                        ),                        
                      );
                    },
                    child: Text('Forgot Password?')),
                ],
              ),
            ),
            //sign-in
            MyButton (
              text: 'Sign-in',
              ontap: signUserIn,                                            
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
              onPressed:signinwithGoogle),        
            
            //new to amazon register here
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New to Amazon?'),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Register now', 
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