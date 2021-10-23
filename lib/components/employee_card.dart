import 'package:flutter/material.dart';
import 'package:heroes/models/employee_model.dart';

class EmployeeCard extends StatefulWidget {
  final Employee hero;
  const EmployeeCard({Key? key,required this.hero}) : super(key: key);

  @override
  _EmployeeCardState createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.hero.name),
      subtitle: Text(widget.hero.description),
    );
  }
}
