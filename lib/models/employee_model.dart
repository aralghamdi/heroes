import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String name;
  final String image;
  final String description;
  final List powers;
  final int rate;

  Employee({
    required this.name,
    required this.image,
    required this.description,
    required this.powers,
    required this.rate
  });

  factory Employee.fromJson(DocumentSnapshot json) {
    return Employee(name: json['name'], image: json['image'], description: json['description'], powers: json['powers'], rate: json['rate']);
  }

}