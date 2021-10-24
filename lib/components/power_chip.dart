import 'package:flutter/material.dart';

class PowerChip extends StatelessWidget {
  final String power;
  double fontSize;
  PowerChip({Key? key, required this.power, this.fontSize = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xff5B628F),
      ),
      child: Text(power,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w300, color: Colors.white),),
    );
  }
}
