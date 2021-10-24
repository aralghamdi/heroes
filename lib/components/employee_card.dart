import 'package:flutter/material.dart';
import 'package:heroes/components/power_chip.dart';
import 'package:heroes/components/size_config.dart';
import 'package:heroes/models/employee_model.dart';
import 'package:heroes/screens/hero_profile_screen.dart';


///
/// This widget will be used in All Hero Screen,
/// it will display the Hero info (image, name, description, and rate)
///


class EmployeeCard extends StatefulWidget {
  final Employee employee;
  const EmployeeCard({Key? key, required this.employee}) : super(key: key);

  @override
  _EmployeeCardState createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HeroProfile(employee: widget.employee)));
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.network(
                    widget.employee.image,
                    width: SizeConfig.blockSizeHorizontal! * 15,
                    height: SizeConfig.blockSizeHorizontal! * 15,
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.employee.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 8,),
                        Text(widget.employee.description,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    const Icon(Icons.star_border, color: Colors.amber,),
                    Text(widget.employee.rate.toString()),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8,),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: widget.employee.powers.map((value){
                return PowerChip(power: value,);
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
