import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sampleproject/stat_data/chart_model.dart';
import 'package:sampleproject/stat_data/chart_data.dart';
import 'package:sampleproject/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


void main1(){
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
    body: Center(
      child: Text('')
    ),
  );
  runApp(Squat_Screen());
}
class Squat_Screen extends StatefulWidget {
  const Squat_Screen({Key? key}) : super(key: key);

  @override
  State<Squat_Screen> createState() => _Squat_ScreenState();
}

class _Squat_ScreenState extends State<Squat_Screen> {
  User? user = FirebaseAuth.instance.currentUser;
    UserModel loggedInUser = UserModel();
    
     
     

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    
  }
  @override
  Widget build(BuildContext context)  {
  final int SquatBar1 = int.parse("${loggedInUser.SquatDay1}"); 
  final int SquatBar2 = int.parse("${loggedInUser.SquatDay2}"); 
  final int SquatBar3 = int.parse("${loggedInUser.SquatDay3}"); 
  final int SquatBar4 = int.parse("${loggedInUser.SquatDay4}"); 
  final int SquatBar5 = int.parse("${loggedInUser.SquatDay5}"); 
  final int SquatBar6 = int.parse("${loggedInUser.SquatDay6}"); 
  final int SquatBar7 = int.parse("${loggedInUser.SquatDay7}"); 

  final List<UserStat> data = [
    
    UserStat(
      day: "Day1",
      excCount: SquatBar1,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day2",
      excCount: SquatBar2 ,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day3",
      excCount: SquatBar3,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day4",
      excCount: SquatBar4,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day5",
      excCount: SquatBar5,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day6",
      excCount: SquatBar6,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day7",
      excCount: SquatBar7,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  
  ];

  
   return Container(
    decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Dashboard 2.jpg'
          ),
          fit: BoxFit.cover)
        ),
     child: Scaffold(
        backgroundColor: Colors.transparent,
 
       body: Column(
        
         children:[
         SizedBox(height: 30),
          Text('  Hello ${loggedInUser.firstName}, these are your Weekly Squat   \n  Excercise Stats.  ',
          style: const TextStyle(color: Colors.white, fontSize: 18.0,
          fontWeight: FontWeight.bold,
           fontFamily: '',
           height: 1.4,
           backgroundColor: Color.fromARGB(31, 6, 10, 247), )),
          SizedBox(height: 20),
        StatChart( 
          data: data,
        ),
       
         
      ],),
    ), 
   );
  }
}


