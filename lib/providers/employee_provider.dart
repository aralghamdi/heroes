import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:heroes/models/employee_model.dart';


class EmployeeProvider extends  ChangeNotifier{
  List<Employee> _heroes = [];
  List<Employee> get heroesList => _heroes;

  setHeroesList(var list){
    _heroes = list;
  }


  sortEmployees(String sortBy){
    switch (sortBy){
      case 'name':
        _heroes.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case 'power':
        _heroes.sort((a, b) => b.powers.length.compareTo(a.powers.length));
        break;
      default:
        _heroes.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
    }
    notifyListeners();
  }






}