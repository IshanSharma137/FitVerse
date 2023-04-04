import 'package:flutter/material.dart';
import 'dart:core';
import 'package:sampleproject/screens/LoginScreen.dart';

class Start_Up extends StatefulWidget {
  const Start_Up({Key? key}) : super(key: key);

  @override
  State<Start_Up> createState() => _Start_UpState();
}

class _Start_UpState extends State<Start_Up> {
  @override
  Widget build(BuildContext context) {


    final letsgobutton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.green,
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        letsgo();
      },
      child: Text(
        "LETS BEGIN",
        textAlign: TextAlign.center,
        style: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      )), 
      );

    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/getstart.jpg'), fit: BoxFit.cover),),
      child: Scaffold(backgroundColor: Colors.transparent,
     
      body: Center(
      child: Padding(
      padding: const EdgeInsets.all(36.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height:600),
        letsgobutton,
        ])
      ),),),
      
    );
  }
  void letsgo(){
    Navigator.pushAndRemoveUntil(
  (context),
  MaterialPageRoute(builder: (context) => LoginScreen()),
  (route) => false); 
  }
  
}