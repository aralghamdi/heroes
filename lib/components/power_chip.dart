import 'package:flutter/material.dart';


///
/// This widget will be used in All Hero Screen & Hero profile Screen,
/// it will display the power of the hero as chip shape
///

class PowerChip extends StatelessWidget {
  final String power;
  const PowerChip({Key? key, required this.power}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xff5B628F),
      ),
      child: Text(power,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),),
    );
  }
}
