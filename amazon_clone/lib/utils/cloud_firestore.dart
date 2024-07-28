
import 'dart:typed_data';
import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:amazon_clone/utils/checkout_items.dart';
import 'package:amazon_clone/utils/home_items.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:amazon_clone/utils/review_model.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future getNameandAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserDetailsModel userModel =
        UserDetailsModel.getModelFromJson((snap.data()) as dynamic);
    return userModel;
  }

  Future<String> uploadProducttoDatabase(
      {required Uint8List? image,
      required String description,
      required String productName,
      required String cost,
      required String sellerName,
      required String sellerUid,
      required String category,
      }) async {
    productName.trim();
    description.trim();
    String output = "Something went wrong";

    if (image != null && productName != "" && cost != "" && description != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImagetoDatabase(image: image, uid: uid);
        ProductModels product = ProductModels(
            cost: double.parse(cost),
            productname: productName,
            sellername: sellerName,
            selleruid: sellerName,
            uid: uid,
            url: url,
            description: description,
            rating: null,
            category: category,
            quantity: null);
        firebaseFirestore.collection("products").doc(uid).set(product.getJson());
        output = "Success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all fields are filled ";
    }
    return output;
  }

  Future<String> uploadImagetoDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProducts() async{
    List<Widget> children=[];
    QuerySnapshot<Map<String?,dynamic>> snap = await firebaseFirestore.collection("products").get();
    for(int i=0;i<snap.docs.length;i++){
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModels models = ProductModels.getModelFromJson(json: (docSnap.data()) as dynamic);
      children.add(HomeItems(productModels: models));
    }
    return children;
  }
    Future<List<Widget>> searchProducts({required String name}) async{
    List<Widget> children=[];
    QuerySnapshot<Map<String?,dynamic>> snap = await firebaseFirestore.collection("products").get();
    for(int i=0;i<snap.docs.length;i++){
      DocumentSnapshot docSnap = snap.docs[i];
      if(docSnap['productName'].toLowerCase().startsWith(name.toLowerCase())||docSnap['category'].toLowerCase().startsWith(name.toLowerCase())||docSnap['category'].toLowerCase().contains(name.toLowerCase())||docSnap['productName'].toLowerCase().contains(name.toLowerCase())){
        ProductModels models = ProductModels.getModelFromJson(json: (docSnap.data()) as dynamic);
        children.add(HomeItems(productModels: models));
      }
      else {
        continue;
      }
    }
    return children;
  }
      Future<bool> isEmpty() async{
    QuerySnapshot<Map<String?,dynamic>> snap = await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart").get();
    if(snap.docs.isNotEmpty){
      return false;
    }
    else{
      return true;
    }
  }

    Future uploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
          await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  Future addProducttoCart({required ProductModels model})async{
    await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart").doc(model.uid).set(model.getJson());
    await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart").doc(model.uid).update({"quantity":1});
  }

  Future deleteFromCart({required String uid}) async{
    await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart").doc(uid).delete();
  }

   Future changeAverageRating(
      {required String productUid, required ReviewModel reviewModel}) async {
    int newRating;
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("products").doc(productUid).get();
    ProductModels model =
        ProductModels.getModelFromJson(json: (snapshot.data() as dynamic));
    if(model.rating!=null){
     int currentRating = model.rating!;
     newRating = ((currentRating + reviewModel.rating) ~/ 2).toInt();
    }
    else{
      newRating = reviewModel.rating;
    }
    
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .update({"rating": newRating});
  }

    Future<double> getTotalCost() async{
    double cost=0;
    QuerySnapshot<Map<String?,dynamic>> snap = await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart").get();
    for(int i=0;i<snap.docs.length;i++){
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModels models = ProductModels.getModelFromJson(json: (docSnap.data()) as dynamic);
      cost+=models.cost!*models.quantity!;
    }
    return cost;
  }

    Future<List<Widget>> checkoutProducts() async{
    List<Widget> children=[];
    QuerySnapshot<Map<String?,dynamic>> snap = await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart").get();
    for(int i=0;i<snap.docs.length;i++){
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModels models = ProductModels.getModelFromJson(json: (docSnap.data()) as dynamic);
      children.add(CheckoutItems(product: models));
    }
    return children;
  }
   Future buyAllItemsInCart({required UserDetailsModel userDetails}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModels model =
          ProductModels.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, userDetails: userDetails);
      await deleteFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders(
      {required ProductModels model,
      required UserDetailsModel userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await deleteFromCart(uid: model.uid);
  }
    Future<bool> isSeller() async{
    QuerySnapshot<Map<String?,dynamic>> snap = await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("seller").get();
    if(snap.docs.isEmpty) {return false;}
    else {return true;}
  }


}
