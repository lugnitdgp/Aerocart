import 'package:amazon_clone/cloud_firestore_methods/cloud_firestore.dart';
import 'package:amazon_clone/models/models.dart';
import 'package:amazon_clone/pages/product_screen.dart';
import 'package:amazon_clone/services/context_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class UniServices {
  static String _code='';
  static String get code => _code;
  static bool get hasCode => _code.isNotEmpty;                                
  
  static void reset() => _code='';

  static init() async{
    try {
      final Uri? uri =await getInitialUri();
      uniHandler(uri);
        
    }on PlatformException   {
      print("Failed to recieve code");
    }on FormatException {
      print("Wrong format recieved");
    }

    uriLinkStream.listen((Uri? uri) async{
      uniHandler(uri);
    },onError: (error){
      print(error);
    });
  }

  static uniHandler(Uri? uri)async{
    if(uri==null||uri.queryParameters.isEmpty) return;

    Map<String,String> param = uri.queryParameters;

    String recieveCode=param['code'] ?? ''; 
    ProductModels product= await CloudFirestoreClass().getProduct(recieveCode);

    Navigator.push(ContextUtility.context!, MaterialPageRoute(builder: (_)=>ProductScreen(product: product)));
  }

}