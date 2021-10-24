import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroes/components/employee_card.dart';
import 'package:heroes/components/size_config.dart';
import 'package:heroes/network/firestore.dart';
import 'package:heroes/providers/employee_provider.dart';
import 'package:provider/provider.dart';

///
/// This is All hero screen,
/// It will display a list of all the employees,
/// the list is built using a Future builder.
///
/// The list can be sorted by names or by the number of powers using the Sort button
///

class AllHeroes extends StatefulWidget {
  const AllHeroes({Key? key}) : super(key: key);

  @override
  _AllHeroesState createState() => _AllHeroesState();
}

class _AllHeroesState extends State<AllHeroes>
    with AutomaticKeepAliveClientMixin {
  var items = ['name', 'power'];

  Widget loadingWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CupertinoActivityIndicator(
          radius: 12,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Loading...")
      ],
    );
  }

  Widget errorWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.error_outline),
        SizedBox(
          height: 10,
        ),
        Text("Something went wrong, please try again later")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffE9F0FB),
          body: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 5),
                child: Image(
                  image: const AssetImage('assets/images/unishf-logo.png'),
                  width: SizeConfig.blockSizeHorizontal! * 35,
                ),
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
                      icon: const Icon(
                        Icons.sort,
                        color: Colors.black,
                      ),
                      items: items.map((String item) {
                        return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 12),
                            ));
                      }).toList(),
                      onChanged: (value) {
                        Provider.of<EmployeeProvider>(context, listen: false)
                            .sortEmployees(value.toString());
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder<dynamic>(
                  future: FireStoreDB.fetchEmployees(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return errorWidget();
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      return Consumer<EmployeeProvider>(
                          builder: (context, notifier, child) {
                        notifier.setHeroesList(snapshot.data);
                        return ListView.builder(
                            itemCount: notifier.employeesList.length,
                            itemBuilder: (context, index) => EmployeeCard(
                                employee: notifier.employeesList[index]));
                      });
                    }

                    return loadingWidget();
                  },
                ),
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
