import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:heroes/components/power_chip.dart';
import 'package:heroes/components/size_config.dart';
import 'package:heroes/models/employee_model.dart';
import 'package:heroes/providers/employee_provider.dart';
import 'package:provider/provider.dart';

///
/// This is Hero Profile screen,
/// It will display the hero information,
///
/// The user can change the employee rate by tapping a star in the rate bar.
///
/// Note: ideally the rate should change based on how many people rate the employee,
///       but for the demonstration purposes it will change directly.
///


class HeroProfile extends StatefulWidget {
  final Employee employee;
  const HeroProfile({Key? key, required this.employee}) : super(key: key);

  @override
  _HeroProfileState createState() => _HeroProfileState();
}


class _HeroProfileState extends State<HeroProfile> {



  @override
  Widget build(BuildContext context) {
    var employeeProvider = Provider.of<EmployeeProvider>(context);

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xffE9F0FB),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff5B628F),
            )),
        title: const Text(
          'Hero Profile',
          style: TextStyle(
            color: Color(0xff5B628F),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffE9F0FB),
        elevation: 0.0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.network(
                  widget.employee.image,
                  width: SizeConfig.blockSizeHorizontal! * 40,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hero Name: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text(widget.employee.name)),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.employee.description),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Powers: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: widget.employee.powers.map((value) {
                          return PowerChip(
                            power: value,
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rate: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: RatingBar(
                          initialRating: widget.employee.rate.toDouble(),
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 25,
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.amber),
                            half: const Icon(Icons.star_half, color: Colors.amber),
                            empty:
                                const Icon(Icons.star_border, color: Colors.amber),
                          ),
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (rating) {
                            employeeProvider.rateEmployee(employeeID: widget.employee.id, rate: rating.toInt());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
