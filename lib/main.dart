import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/employee_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<EmployeeProvider>(create: (context) => EmployeeProvider())
      ],
          child:const HeroesApp()));

}

class HeroesApp extends StatelessWidget {
  const HeroesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heroes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}
