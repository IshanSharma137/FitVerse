import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/screens/startup.dart';


Future<void> main() async {
   ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
    body: Center(
      child: Text('')
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGIN',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
   
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Start_Up(),
    );
  }
}
