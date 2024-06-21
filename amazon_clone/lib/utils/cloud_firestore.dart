import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreClass{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future getNameandAddress() async{
    DocumentSnapshot snap= await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get();
    UserDetailsModel userModel =UserDetailsModel.getModelFromJson((snap.data()) as dynamic);
    return userModel;
    
  }
} 