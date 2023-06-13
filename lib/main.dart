import 'package:flutter/material.dart';
import 'package:fyp_bees/hive_data.dart';
import 'package:fyp_bees/locate.dart';
import 'package:fyp_bees/main_page.dart';
import 'package:fyp_bees/profile.dart';
import 'package:fyp_bees/signup.dart';
import 'package:fyp_bees/notification.dart';

bool Registration = true;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      //home: HiveData(index: 1),
      //home: location(),
      //home: ProfileScreen(Uid: 1),
      home: SignUP(),
      //home: CardWidget(),
      //home:MyHomePage(),
      //home: park(),
      // home: Registration
      //     ? MyHomePage(value: 2)
      //     : location(), //if variable 'Registration' is true then it call MyHomePage() otherwise it call GetCurruntlocationScreen()
    );
  }
}
