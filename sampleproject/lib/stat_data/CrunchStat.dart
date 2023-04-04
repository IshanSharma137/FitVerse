import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/rendering.dart';
import 'package:sampleproject/stat_data/chart_model.dart';
import 'package:sampleproject/stat_data/chart_data.dart';
import 'package:sampleproject/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main(){
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
    body: Center(
      child: Text('')
    ),
  );
  runApp(Crunch_Screen());
}


class Crunch_Screen extends StatefulWidget {
  const Crunch_Screen({Key? key}) : super(key: key);

  @override
  State<Crunch_Screen> createState() => _Crunch_ScreenState();
}

class _Crunch_ScreenState extends State<Crunch_Screen> {
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
  final int CrunchBar1 = int.parse("${loggedInUser.CrunchDay1}"); 
  final int CrunchBar2 = int.parse("${loggedInUser.CrunchDay2}"); 
  final int CrunchBar3 = int.parse("${loggedInUser.CrunchDay3}"); 
  final int CrunchBar4 = int.parse("${loggedInUser.CrunchDay4}"); 
  final int CrunchBar5 = int.parse("${loggedInUser.CrunchDay5}"); 
  final int CrunchBar6 = int.parse("${loggedInUser.CrunchDay6}"); 
  final int CrunchBar7 = int.parse("${loggedInUser.CrunchDay7}"); 

  final List<UserStat> data = [
    
    UserStat(
      day: "Day1",
      excCount: CrunchBar1,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day2",
      excCount: CrunchBar2 ,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day3",
      excCount: CrunchBar3,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day4",
      excCount: CrunchBar4,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day5",
      excCount: CrunchBar5,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day6",
      excCount: CrunchBar6,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day7",
      excCount: CrunchBar7,
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
          Text('  Hello ${loggedInUser.firstName}, these are your Weekly Crunch    \n  Excercise Stats.  ',
          style: const TextStyle(color: Colors.white, fontSize: 18.0,
          fontWeight: FontWeight.bold,
           fontFamily: '',
           height: 1.4,
           backgroundColor: Color.fromARGB(31, 175, 247, 6), )),
          SizedBox(height: 20),
        StatChart( 
          
          data: data, 
        ),
       
         
      ],),
    ), );
  }
}










