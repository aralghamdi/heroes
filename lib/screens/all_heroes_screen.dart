import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heroes/components/employee_card.dart';
import 'package:heroes/components/size_config.dart';
import 'package:heroes/network/firestore.dart';
import 'package:heroes/providers/employee_provider.dart';
import 'package:provider/provider.dart';

class AllHeroes extends StatefulWidget {
  const AllHeroes({Key? key}) : super(key: key);

  @override
  _AllHeroesState createState() => _AllHeroesState();
}

class _AllHeroesState extends State<AllHeroes> {
  var employeesProvider;
  String dropdownvalue = 'name';
  var items =  ['name','power'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //var employeesProvider =   Provider.of<EmployeeProvider>(context);
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9F0FB),

        body: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 5),
              child: Image(
                image: const AssetImage('assets/images/unishf-logo.png'),
                width: SizeConfig.blockSizeHorizontal! * 35,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),

                        icon: const Icon(Icons.sort, color: Colors.black,),
                        items:items.map((String item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(item, style: const TextStyle(fontSize: 12),)
                          );
                        }
                        ).toList(),
                        onChanged: (value){
                          Provider.of<EmployeeProvider>(context, listen: false).sortEmployees(value.toString());
                        },
                      ),
                    ),
                // PopupMenuButton(
                //   icon: const Icon(Icons.sort, color: Colors.black,),
                //     shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(12.0),
                //       ),
                //     ),
                //     offset: const Offset(0, 10),
                //     onSelected: (value){
                //     print(value);
                //     //employeesProvider.sortEmployees(value.toString());
                //     },
                //     itemBuilder: (context) => [
                //       const PopupMenuItem(
                //         child: Text("Name", style: TextStyle(fontSize: 12),),
                //         value: 'name',
                //       ),
                //       const PopupMenuItem(
                //         child: Text("Power", style: TextStyle(fontSize: 12),),
                //         value: 'power',
                //       )
                //     ]),
              ],
            ),
            Expanded(
              child: FutureBuilder<dynamic>(
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
                              itemBuilder: (context, index) => EmployeeCard(employee: notifier.heroesList[index]));
                        }
                    );


                  }

                  return Text("loading");
                },
              ),
            ),
          ],
        )

      ),
    );
  }
}
