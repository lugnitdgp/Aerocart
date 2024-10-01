import 'package:amazon_clone/auth/auth_page.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/utils/text_field.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerDetailsScreen extends StatefulWidget {
  const SellerDetailsScreen({super.key});

  @override
  State<SellerDetailsScreen> createState() => _SellerDetailsScreenState();
}

class _SellerDetailsScreenState extends State<SellerDetailsScreen> {
  TextEditingController gst=TextEditingController();
  TextEditingController aadhar=TextEditingController();
  TextEditingController shop=TextEditingController();
  TextEditingController address=TextEditingController();

    void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("seller")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({"shop name ": shop.text, "address": address.text});   
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
                  'Update your name and address',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Textfield(
                  controller: shop,
                  hintText: 'Enter Shop name',
                  obstext: false),
              const SizedBox(
                height: 5,
              ),

              //address
              Textfield(
                  controller: address ,
                  hintText: 'Enter Shop Address',
                  obstext: false),
              const SizedBox(
                height: 5,
              ),
              Textfield(
                  controller: gst ,
                  hintText: 'Enter GST no.',
                  obstext: false),
              const SizedBox(
                height: 5,
              ),
              Textfield(
                  controller: aadhar,
                  hintText: 'Enter Aadhar no.',
                  obstext: false),
              const SizedBox(
                height: 5,
              ),
             

              //sign-up
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20),
                child: MyButton(text: 'Continue', ontap: () {
                  if(gst.text==""||shop.text==""||address.text==""||aadhar.text==""){
                    Utils().showSnackBar(context: context, content: "Please fill all the fields");
                  }
                  else{
                    signUserUp();
                  }
                },),
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }
}