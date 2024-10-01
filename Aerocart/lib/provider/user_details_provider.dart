import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:amazon_clone/cloud_firestore_methods/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider with ChangeNotifier{
  UserDetailsModel userdetails;

  UserDetailsProvider() : userdetails=UserDetailsModel(name: "loading", address: 'loading');

  Future getData() async{
    userdetails= await CloudFirestoreClass().getNameandAddress();
    notifyListeners();
  }
}