import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heroes/components/employee_card.dart';
import 'package:heroes/network/firestore.dart';
import 'package:heroes/providers/employee_provider.dart';
import 'package:provider/provider.dart';

class AllHeroes extends StatefulWidget {
  const AllHeroes({Key? key}) : super(key: key);

  @override
  _AllHeroesState createState() => _AllHeroesState();
}

class _AllHeroesState extends State<AllHeroes> {
  final Stream<QuerySnapshot> collectionStream = FirebaseFirestore.instance.collection('heroes').snapshots();
  String dropdownvalue = 'name';
  var items =  ['name','powers'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [

          DropdownButton(
            value: dropdownvalue,
            icon: Icon(Icons.keyboard_arrow_down),
            items:items.map((String items) {
              return DropdownMenuItem(
                  value: items,
                  child: Text(items)
              );
            }
            ).toList(),
            onChanged: (value){
              Provider.of<EmployeeProvider>(context, listen: false).sortEmployees(value.toString());
            },
          ),
        ],
      ),
      body:
      FutureBuilder<dynamic>(
        future: FireStoreDB.fetchEmployees(),
        builder: (BuildContext context, snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<EmployeeProvider>(
                builder: (context, notifier, child){
                  notifier.setHeroesList(snapshot.data);
                  return ListView.builder(
                      itemCount: notifier.heroesList.length,
                      itemBuilder: (context, index) => EmployeeCard(hero: notifier.heroesList[index]));
                }
            );


          }

          return Text("loading");
        },
      )

    );
  }
}
