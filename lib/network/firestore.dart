import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heroes/models/employee_model.dart';


Stream collectionStream = FirebaseFirestore.instance.collection('heroes').snapshots();

class FireStoreDB {


  static Future fetchEmployees() async {
    List<Employee> _heroes = [];

    try {
      QuerySnapshot<Map<String, dynamic>> heroes =
      await FirebaseFirestore.instance.collection('employees').get();

      _heroes = [];

      heroes.docs.forEach((hero) {
        _heroes.add(Employee.fromJson(hero));
      });

      _heroes.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return _heroes;
    } catch (e) {
      return Exception(e);
    }
  }

}

