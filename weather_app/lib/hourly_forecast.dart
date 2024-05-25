import 'package:flutter/material.dart';




class HourlyForecast extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temp;
  const HourlyForecast({
    super.key,
    required this.icon,
    required this.time,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          child: Card(
            elevation: 8,
            child: Container(
              width: 115,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
              ),
              child:  Column(
                children: [
                  Text(time,style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 6,),
                  Icon(icon,size: 40,),
                  const SizedBox(height: 7,),
                  Text('$temp°C', style: const TextStyle(fontSize: 16),),
              ],),
          ),
        ),
      );
  }
}