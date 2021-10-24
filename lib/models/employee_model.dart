import 'package:cloud_firestore/cloud_firestore.dart';

///
/// This is Employee model class,
/// the Employee.fromJson deserializer will convert the Json from the FireStore DB to an Employee object.
///

class Employee {
   String id;
   String name;
   String image;
   String description;
   List powers;
   int rate;

  Employee({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.powers,
    required this.rate
  });

  factory Employee.fromJson(DocumentSnapshot json) {
    return Employee(id: json['id'], name: json['name'], image: json['image'], description: json['description'], powers: json['powers'], rate: json['rate']);
  }

}