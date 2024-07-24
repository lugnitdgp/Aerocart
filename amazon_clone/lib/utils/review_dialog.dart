import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/utils/cloud_firestore.dart';
import 'package:amazon_clone/utils/review_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({super.key,required this.productUid});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(

      title: const Text(
        'Type a review for this product',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),


      submitButtonText: 'Submit',
      commentHint: 'Type here',
      onSubmitted: (RatingDialogResponse res) async{
        CloudFirestoreClass().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                senderName:
                    Provider.of<UserDetailsProvider>(context, listen: false).userdetails.name,
                description: res.comment,
                rating: res.rating.toInt()));
        
      },
    );

    
  }
}