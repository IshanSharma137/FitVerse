import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sampleproject/stat_data/chart_model.dart';
import 'package:sampleproject/stat_data/chart_data.dart';
import 'package:sampleproject/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampleproject/stat_data/CurlStat.dart';
import 'package:sampleproject/stat_data/SquatStat.dart';
import 'package:sampleproject/stat_data/CrunchStat.dart';

void main(){
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
    body: Center(
      child: Text('')
    ),
  );
  runApp(Stat_Screen());
}


class Stat_Screen extends StatefulWidget {
  const Stat_Screen({Key? key}) : super(key: key);

  @override
  State<Stat_Screen> createState() => _Stat_ScreenState();
}

class _Stat_ScreenState extends State<Stat_Screen> {
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
  Widget build(BuildContext context) => DefaultTabController(length: 3,
   child: Scaffold(
    
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 48, 133, 223),
        title: Text("FITVERSE",style: TextStyle( 
                     fontSize: 18,
                     height: 2, 
                     color: Color.fromRGBO(255, 255, 255, 1), 
                     letterSpacing: 5,
                     

                  ),),
        centerTitle: true,
        bottom:   TabBar(
          tabs:[
            Tab(text: 'Curl',) ,
            Tab(text: 'Crunch'),
            Tab(text: 'Squat'),
          ]
        ),
      ),
      body: TabBarView(
        
        children: [
          
          Curl_Screen(),
          Crunch_Screen(),
          Squat_Screen(),
        ],

       
      ),
    )
  );
}










