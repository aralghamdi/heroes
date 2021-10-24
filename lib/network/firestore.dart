import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heroes/models/employee_model.dart';


/// declare Employees Collection reference in FireStore DB
var employeeCollection = FirebaseFirestore.instance.collection('employees');

class FireStoreDB {

  static Future fetchEmployees() async {
    List<Employee> _employees = [];

    try {
      /// Get the employees list from FireStore DB
      QuerySnapshot<Map<String, dynamic>> heroes = await employeeCollection.get();

      /// add the data to temp employee list
      for (var hero in heroes.docs) {
        _employees.add(Employee.fromJson(hero));
      }

      /// sort the list alphabetically
      _employees.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return _employees;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> updateEmployeeRate({required String employeeID, required int rate}) {
    /// update employee rating in FireStore DB using employee ID
    return employeeCollection.doc(employeeID).update({'rate': rate});
  }

}

