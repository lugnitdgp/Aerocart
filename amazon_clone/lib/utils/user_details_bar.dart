import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;
  UserDetailsBar({
    super.key,
    required this.offset,
  });
  final List<Color> userdetailscolor = [
    Color.fromARGB(255, 127, 247, 247),
    Color.fromARGB(224, 169, 248, 220)
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userdetails;
    return Positioned(
      top: -offset / 4,
      child: Container(
        height: 40,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: userdetailscolor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.grey[800],
              ),
              SizedBox(
                width: width * 0.7,
                child: Text(
                  "Deliver to ${userDetailsModel.name}-${userDetailsModel.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
