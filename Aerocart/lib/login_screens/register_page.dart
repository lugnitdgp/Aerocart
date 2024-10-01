import 'package:amazon_clone/auth/auth_page.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/utils/text_field.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
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

  void signinwithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //sign in
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const AuthPage();
        },
      ), (route) => false);
    } on FirebaseAuthException catch (e) {
      showErrorMsg(e.toString());
    }
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
      if (password.text == confirmPassword.text && password.text != "") {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
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
      } else if (password.text == "" ||
          confirmPassword.text == "" ||
          address.text == "" ||
          email.text == "" ||
          username.text == "") {
        Navigator.pop(context);
        Utils().showSnackBar(
            context: context, content: "Please fill all the fields");
      }else if(password.text.length<6){
        Utils().showSnackBar(context: context, content: "The password should contain atleast 6 letters");
      }
       else {
        Navigator.pop(context);
        Utils().showSnackBar(context: context, content: "Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Utils().showSnackBar(context: context, content: e.message.toString());
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
                  'Let\'s create an account for you',
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
              //enter password
              Textfield(
                  controller: confirmPassword,
                  hintText: 'Confirm Password',
                  obstext: true),

              //sign-up
              MyButton(text: 'Sign-up', ontap: signUserUp),
              //other option
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Or continue with',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Divider(
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
              SignInButton(Buttons.google, onPressed: signinwithGoogle),

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
                          color: Colors.blue[700], fontWeight: FontWeight.bold),
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
