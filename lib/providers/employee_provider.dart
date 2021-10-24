import 'package:flutter/foundation.dart';
import 'package:heroes/models/employee_model.dart';
import 'package:heroes/network/firestore.dart';

///
/// This is the Employee provider,
/// It is used to mange All Hero Screen state if the user changes the sorting option.
/// And, it is used to update the Employee rating in Hero Profile Screen
///

class EmployeeProvider extends  ChangeNotifier{
  List<Employee> _employees = [];
  List<Employee> get employeesList => _employees;

  /// setter for the _employees list
  setHeroesList(var list){
    _employees = list;
  }

  sortEmployees(String sortBy){
    switch (sortBy){
      /// Sort the employees list by name
      case 'name':
        _employees.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;

      /// Sort the employees  by the number on powers
      case 'power':
        _employees.sort((a, b) => b.powers.length.compareTo(a.powers.length));
        break;

     /// default Case
      default:
        _employees.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
    }
    notifyListeners();
  }

  rateEmployee({required String employeeID, required int rate}) async {
    /// Update the employee rating locally
     int index = _employees.indexWhere((employee) => employee.id == employeeID);
     _employees[index].rate = rate;

     /// Update the employee rating at FireStore DB
     FireStoreDB.updateEmployeeRate(employeeID: employeeID, rate: rate);
     notifyListeners();
  }
}