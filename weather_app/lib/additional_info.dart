import 'package:flutter/material.dart';


class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32,),
        const SizedBox(height: 8,),
        Text(label, style: const TextStyle(fontSize: 19),),
        const SizedBox(height: 6,),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
      ],
    );
  }
}

