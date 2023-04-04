import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/config/palette.dart';
import 'package:sampleproject/config/styles.dart';
import 'package:sampleproject/model/user_model.dart';
import 'package:sampleproject/screens/LoginScreen.dart';
import 'package:sampleproject/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String curltracker = '';
  String crunchtracker = '';
  String squattracker = '';
  String str_tot_curl = '';
  String str_tot_crunch = '';
  String str_tot_squat = '';
  String sess_dur = '';

  String cg = '';
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
  final curlgoaleditcontroller = new  TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CurlGoal  = TextFormField(
      autofocus: false,
      controller: curlgoaleditcontroller,
      keyboardType: TextInputType.text,
      //validator: () {},
      onSaved: (value) 
      {
        curlgoaleditcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          )
      )
    );


    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
    decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/imgBG.jpg'
          ),
          fit: BoxFit.cover)
        ),
     child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[

          
          _buildHeader(screenHeight),
          _buildBody(screenHeight),
          _buildDisplayCount(screenHeight),
        
          
        ],
        

        
        )
        
    ), );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight)
{
  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            
            colors: [Palette.primaryColor,Palette.primaryColor],
            ),
      borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(40.0),
      bottomRight: Radius.circular(40.0),
      ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          SizedBox(
            height: 90,
            
            child: Image.asset("assets/vrex.png", fit: BoxFit.contain), 
            
          ),
            
          Row(
          
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: <Widget>[
            
            Text('\nWelcome ${loggedInUser.firstName} !', style: const TextStyle(color: Colors.white, fontSize: 25.0,
             fontWeight: FontWeight.bold,
           fontFamily: 'ComicSansMS',
           letterSpacing: 2 ),
           
            ),
        
          ],

          ),
          SizedBox(height: screenHeight*0.03),
          
        ],
      ),
      ),
      
  );
}

  SliverToBoxAdapter _buildBody (double screenHeight) {
  return SliverToBoxAdapter(
   
    
    child: Container(

      padding: const EdgeInsets.all(20.0),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            Text(
              'TODAY: ',
              style: const TextStyle(color: Color.fromARGB(255, 3, 92, 3),
                fontSize: 25.0,
                fontWeight: FontWeight.w800, 
                decoration: TextDecoration.underline,
                
              ),
            ),
        const SizedBox(height: 20.0),
        Row(
        children: <Widget>[
           
             TextButton.icon(
              style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
            ),
                      
                      onPressed: () async{//async function to perform http get

                  DateFormat dateFormat = DateFormat("dd-MM-YYYY HH:mm:ss");
                  dynamic currentTime = DateFormat.jm().format(DateTime.now());
                  DateTime now = DateTime.now();
                  DateTime date = new DateTime(now.year, now.month, now.day);
                  String strDt = "${date.day}";

                  int intDt = int.parse(strDt);
                  int intNewDt = int.parse("${loggedInUser.DateTime}");
                  
                 
                  final Uri url = Uri.parse('http://192.168.130.219:5000');
                  final response = await http.get(url); //getting the response from our backend server script

                  final decoded = json.decode(response.body) as Map<String, dynamic>; //converting it from json to key value pair 

                  setState(() {
                    curltracker = decoded['curltracker']; //changing the state of our widget on data update
                  });

                  final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc("${loggedInUser.uid}");
                  int ctr=0;

                
                if (intDt >= intNewDt || intDt == 1){
                  
                  ctr = int.parse("${loggedInUser.dayno}");

                if (intDt - intNewDt > 1 || intDt - intNewDt < 0){
                  ctr = ctr + 1;
                }
                else{
                  ctr=ctr+(intDt-intNewDt);
                }

                if (ctr>7){
                    ctr=1;
                     docUser.update(
                    {
                      'CurlDay2': '0',
                      'CurlDay3': '0',
                      'CurlDay4': '0',
                      'CurlDay5': '0',
                      'CurlDay6': '0',
                      'CurlDay7': '0',

                      
                    }
                  );
                  }                  
                int tot_day_curl = 0;
                int crl1 = int.parse("${loggedInUser.CurlDay1}");
                int crl2 = int.parse("${loggedInUser.CurlDay2}");
                int crl3 = int.parse("${loggedInUser.CurlDay3}");
                int crl4 = int.parse("${loggedInUser.CurlDay4}");
                int crl5 = int.parse("${loggedInUser.CurlDay5}");
                int crl6 = int.parse("${loggedInUser.CurlDay6}");
                int crl7 = int.parse("${loggedInUser.CurlDay7}");
                int crltrck = int.parse("${curltracker}");
                String strctr = "${ctr}";

                if (intDt == intNewDt){
                  if (ctr == 1){tot_day_curl = crl1 + crltrck; }
                  else if (ctr == 2){tot_day_curl = crltrck+crl2; }
                  else if (ctr == 3){tot_day_curl = crltrck+crl3; }
                  else if (ctr == 4){tot_day_curl = crltrck+crl4; }
                  else if (ctr == 5){tot_day_curl = crltrck+crl5; }
                  else if (ctr == 6){tot_day_curl = crltrck+crl6; }
                  else if (ctr == 7){tot_day_curl = crltrck+crl7; }
                  
                }
                
                
                str_tot_curl = "${tot_day_curl}";

                  docUser.update(
                    {
                      'dayno': strctr,
                      'CurlDay${strctr}':str_tot_curl ,
                      'DateTime': strDt,
                      
                    }
                  );
 
                }
                      },
                     
                      
                      icon: const Icon(
                        Icons.sports_gymnastics,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Curl',
                        style: Styles.buttonTextStyle,
                      ),
                     
                    ),
                    Text("                     ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                     SizedBox(
            height: 65,
            
            child: Image.asset("assets/curlimg.png", fit: BoxFit.contain), 
            
          ),
          
        ],
        ),
        Row(children: <Widget>[

                    Text("", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                    TextButton.icon(
                      style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.pink,
            ),
                      
                      onPressed: () async{
                        //async function to perform http get

                  DateFormat dateFormat = DateFormat("dd-MM-YYYY HH:mm:ss");
                  dynamic currentTime = DateFormat.jm().format(DateTime.now());
                  DateTime now = DateTime.now();
                  DateTime date = new DateTime(now.year, now.month, now.day);
              
                  String strDt = "${date.day}";
                  int intDt = int.parse(strDt);
                  
                  int intNewDt = int.parse("${loggedInUser.DateTime}");

                  final Uri url = Uri.parse('http://192.168.130.219:5000/crunch');
                  final response = await http.get(url); //getting the response from our backend server script

                  final decoded = json.decode(response.body) as Map<String, dynamic>; //converting it from json to key value pair 

                  setState(() {
                    crunchtracker = decoded['crunchtracker']; //changing the state of our widget on data update
                  });

                  final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc("${loggedInUser.uid}");
                  int ctr=0;
               
                
                
                if (intDt >= intNewDt || intDt == 1){
          
                  ctr = int.parse("${loggedInUser.dayno}");

                if (intDt - intNewDt > 1 || intDt - intNewDt < 0){
                  ctr = ctr + 1;
                }
                else{
                  ctr=ctr+(intDt-intNewDt);
                }
                  if (ctr>7){
                    ctr=1;
                     docUser.update(
                    {
                      'CrunchDay2': '0',
                      'CrunchDay3': '0',
                      'CrunchDay4': '0',
                      'CrunchDay5': '0',
                      'CrunchDay6': '0',
                      'CrunchDay7': '0',

                      
                    }
                  );
                  }                  
                int tot_day_crunch = 0;
                int crch1 = int.parse("${loggedInUser.CrunchDay1}");
                int crch2 = int.parse("${loggedInUser.CrunchDay2}");
                int crch3 = int.parse("${loggedInUser.CrunchDay3}");
                int crch4 = int.parse("${loggedInUser.CrunchDay4}");
                int crch5 = int.parse("${loggedInUser.CrunchDay5}");
                int crch6 = int.parse("${loggedInUser.CrunchDay6}");
                int crch7 = int.parse("${loggedInUser.CrunchDay7}");
                int crchtrck = int.parse("${crunchtracker}");
                String strctr = "${ctr}";

                if (intDt == intNewDt){
                  if (ctr == 1){tot_day_crunch = crch1 + crchtrck; }
                  else if (ctr == 2){tot_day_crunch = crchtrck+crch2; }
                  else if (ctr == 3){tot_day_crunch = crchtrck+crch3; }
                  else if (ctr == 4){tot_day_crunch = crchtrck+crch4; }
                  else if (ctr == 5){tot_day_crunch = crchtrck+crch5; }
                  else if (ctr == 6){tot_day_crunch = crchtrck+crch6; }
                  else if (ctr == 7){tot_day_crunch = crchtrck+crch7; }
                  
                }

               
                
                str_tot_crunch = "${tot_day_crunch}";


                  docUser.update(
                    {
                      'dayno': strctr,
                      'CrunchDay${strctr}': str_tot_crunch,
                      'DateTime': strDt,
                      
                    }
                  );
                  
                }
                      },
                      
                      icon: const Icon(
                        Icons.sports_gymnastics,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Crunch',
                        style: Styles.buttonTextStyle,
                      ),
                      
                    ),
                    Text("              ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                     SizedBox(
            height: 55,
            
            child: Image.asset("assets/crunchimg.png", fit: BoxFit.contain), 
            
          ),
                    
         ]
         ),
         Row(children: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.orange,
            ),
                     
                      onPressed: () async{//async function to perform http get

                  DateFormat dateFormat = DateFormat("dd-MM-YYYY HH:mm:ss");
                  dynamic currentTime = DateFormat.jm().format(DateTime.now());
                  DateTime now = DateTime.now();
                  DateTime date = new DateTime(now.year, now.month, now.day);
                  print(date.day);
                  String strDt = "${date.day}";

                  int intDt = int.parse(strDt);
                  int intNewDt = int.parse("${loggedInUser.DateTime}");
                  final Uri url = Uri.parse('http://192.168.130.219:5000/squat');
                  final response = await http.get(url); //getting the response from our backend server script

                  final decoded = json.decode(response.body) as Map<String, dynamic>; //converting it from json to key value pair 

                  setState(() {
                    squattracker = decoded['squattracker']; //changing the state of our widget on data update
                  });

                  
                  final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc("${loggedInUser.uid}");
                  int ctr=0;
               
                 
                
                if (intDt >= intNewDt || intDt == 1){
          
                  ctr = int.parse("${loggedInUser.dayno}");

                if (intDt - intNewDt > 1 || intDt - intNewDt < 0){
                  ctr = ctr + 1;
                }
                else{
                  ctr=ctr+(intDt-intNewDt);
                }
                  

                    if (ctr>7){
                    ctr=1;
                     docUser.update(
                    {
                      'SquatDay2': '0',
                      'SquatDay3': '0',
                      'SquatDay4': '0',
                      'SquatDay5': '0',
                      'SquatDay6': '0',
                      'SquatDay7': '0',

                      
                    }
                  );
                  }                  
                
		            int tot_day_squat = 0;
                int sqt1 = int.parse("${loggedInUser.SquatDay1}");
                int sqt2 = int.parse("${loggedInUser.SquatDay2}");
                int sqt3 = int.parse("${loggedInUser.SquatDay3}");
                int sqt4 = int.parse("${loggedInUser.SquatDay4}");
                int sqt5 = int.parse("${loggedInUser.SquatDay5}");
                int sqt6 = int.parse("${loggedInUser.SquatDay6}");
                int sqt7 = int.parse("${loggedInUser.SquatDay7}");
                int sqttrck = int.parse("${squattracker}");
                String strctr = "${ctr}";

                if (intDt == intNewDt){
                  if (ctr == 1){tot_day_squat = sqt1 + sqttrck; }
                  else if (ctr == 2){tot_day_squat = sqttrck+sqt2; }
                  else if (ctr == 3){tot_day_squat = sqttrck+sqt3; }
                  else if (ctr == 4){tot_day_squat = sqttrck+sqt4; }
                  else if (ctr == 5){tot_day_squat = sqttrck+sqt5; }
                  else if (ctr == 6){tot_day_squat = sqttrck+sqt6; }
                  else if (ctr == 7){tot_day_squat = sqttrck+sqt7; }
                  
                }
                
                str_tot_squat = "${tot_day_squat}";

                  docUser.update(
                    {
                      'dayno': strctr,
                      'SquatDay${strctr}': str_tot_squat,
                      'DateTime': strDt,
                      
                    }
                  );
                  
                }

                      },
                     
                      icon: const Icon(
                        Icons.sports_gymnastics_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Squats',
                        style: Styles.buttonTextStyle,
                      ),
                      
                    ),

                  Text("                 ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                     SizedBox(
            height: 55,
            
            child: Image.asset("assets/squatimg.png", fit: BoxFit.contain), 
            
          ),

         
         ],)]
         )
         )
  );
}


 SliverToBoxAdapter _buildDisplayCount(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.22,
        decoration: BoxDecoration(
          image:  DecorationImage(image: AssetImage('assets/img.png'
          ),
          
          fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'SESSION Duration: ',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 3, 122, 31),
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                SizedBox(height: screenHeight * 0.01),
                Text("Curl: "+str_tot_curl, style: TextStyle(color: Colors.blue, fontSize: 19, fontWeight: FontWeight.bold),),
                SizedBox(height: screenHeight * 0.01),
                Text("Crunch: "+str_tot_crunch, style: TextStyle(color: Colors.pink, fontSize: 19, fontWeight: FontWeight.bold),),
                SizedBox(height: screenHeight * 0.01),
                Text("Squats: "+str_tot_squat, style: TextStyle(color: Colors.orange, fontSize: 19, fontWeight: FontWeight.bold),),
                
                
              ],
            ),
          ],
        ),
      ),
    );


  }
}




