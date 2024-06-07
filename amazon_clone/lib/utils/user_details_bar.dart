import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:flutter/material.dart';

class UserDetailsBar extends StatelessWidget {
  final UserDetailsModel userDetailsModel;
  final double offset;
  UserDetailsBar({super.key,required this.offset,required this.userDetailsModel});
  final List<Color> userdetailscolor = [
    Color.fromARGB(255, 127, 247, 247),Color.fromARGB(224, 169, 248, 220)
  ];

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Positioned(
      top: -offset/4,
      child: Container(
        height: 40,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: userdetailscolor,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          ),        
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,color: Colors.grey[800],),
              SizedBox(
                width:width*0.7,
                child: Text("Deliver to ${userDetailsModel.name}-${userDetailsModel.address}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:TextStyle(color: Colors.grey[800]),),
              ),
              
            ],
            
          ),
        ),
        
      ),
    );
    
  }
}