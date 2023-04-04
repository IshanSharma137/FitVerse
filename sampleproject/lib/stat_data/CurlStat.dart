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
  runApp(Curl_Screen());
}

class Curl_Screen extends StatefulWidget {
  const Curl_Screen({Key? key}) : super(key: key);

  @override
  State<Curl_Screen> createState() => _Curl_ScreenState();
}

class _Curl_ScreenState extends State<Curl_Screen> {
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
  final int curlBar1 = int.parse("${loggedInUser.CurlDay1}"); 
  final int curlBar2 = int.parse("${loggedInUser.CurlDay2}"); 
  final int curlBar3 = int.parse("${loggedInUser.CurlDay3}"); 
  final int curlBar4 = int.parse("${loggedInUser.CurlDay4}"); 
  final int curlBar5 = int.parse("${loggedInUser.CurlDay5}"); 
  final int curlBar6 = int.parse("${loggedInUser.CurlDay6}"); 
  final int curlBar7 = int.parse("${loggedInUser.CurlDay7}"); 

  final List<UserStat> data = [
    
    UserStat(
      day: "Day1",
      excCount: curlBar1,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day2",
      excCount: curlBar2 ,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day3",
      excCount: curlBar3,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day4",
      excCount: curlBar4,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day5",
      excCount: curlBar5,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day6",
      excCount: curlBar6,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    UserStat(
      day: "Day7",
      excCount: curlBar7,
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
          Text('  Hello ${loggedInUser.firstName}, these are your Weekly Curl    \n  Excercise Stats.  ',
          style: const TextStyle(color: Colors.white, fontSize: 18.0,
          fontWeight: FontWeight.bold,
           fontFamily: '',
           height: 1.4,
           backgroundColor: Color.fromARGB(31, 247, 6, 199), )),
          SizedBox(height: 20),

        StatChart( 
          data: data,
        ),
       
         
      ],),
    ), 
   );
  }
}










