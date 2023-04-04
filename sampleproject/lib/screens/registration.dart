import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sampleproject/model/user_model.dart';
import 'package:sampleproject/screens/bottom_nav_screen.dart';


import 'LoginScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth =FirebaseAuth.instance;
  //our form key
  final _formKey = GlobalKey<FormState>();
  //editing Controller
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.text,
      //validator: () {},
      onSaved: (value) 
      {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          )
      )
    );

  //last name field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.text,
      //validator: () {},
      onSaved: (value) 
      {
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Last Name",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          )
      )
    );

      //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty)
        {
          return("Please Enter your Email");
        }
        // reg exp for email veri
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]").hasMatch(value))
        {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) 
      {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          )
      )
    );

      //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty)
        {
          return("Password is Required");
        }
        if(!regex.hasMatch(value))
        {
          return("Please Enter Valid Password (Min 6 char)");
        }
      },
      onSaved: (value) 
      {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          )
      )
    );

        //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      
      validator: (value) {
        if(confirmPasswordEditingController.text != passwordEditingController.text)
        {
          return("Password dont Match");
        }
      },
      onSaved: (value) 
      {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          )
      )
    );

        //sign up button
    final signUpButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.green,
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        signUp(emailEditingController.text , passwordEditingController.text);
      },
      child: Text(
        "Sign Up",
        textAlign: TextAlign.center,
        style: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      )), 
      );

  

   return Container(
    decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Sign up.jpg'
          ),
          fit: BoxFit.cover)
        ),
     child: Scaffold( backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    
                    SizedBox(height: 200,),
                    
                  SizedBox(height: 45),

                  firstNameField,
                  SizedBox(height: 20),

                  lastNameField,
                  SizedBox(height: 20),

                  emailField,
                  SizedBox(height: 20),

                  passwordField,
                  SizedBox(height: 20),

                  confirmPasswordField,
                  SizedBox(height: 20),
                  
                  signUpButton,
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account? "),
                      GestureDetector(onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()
                        ));
                      },
                      child: Text(" Sign In", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      )
                    ])


                  

                  ],
                  ),
                ),
            ),
            ),
        ),
      ),
    )
   );
  }


  void signUp(String email, String password) async
  {
    if (_formKey.currentState!.validate())
    {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailsToFirestore()

      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our Firebase
    // calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writin all values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.lastName = lastNameEditingController.text;

    await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    
   
  Fluttertoast.showToast(msg: "Account created Successfully !");
  final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid);
 docUser.update(
                    {
                      'dayno': '0',
                      'SquatDay1': '0',
                      'SquatDay2': '0',
                      'SquatDay3': '0',
                      'SquatDay4': '0',
                      'SquatDay5': '0',
                      'SquatDay6': '0',
                      'SquatDay7': '0',
                      'CrunchDay1': '0',
                      'CrunchDay2': '0',
                      'CrunchDay3': '0',
                      'CrunchDay4': '0',
                      'CrunchDay5': '0',
                      'CrunchDay6': '0',
                      'CrunchDay7': '0',                     
                      'CurlDay1': '0',
                      'CurlDay2': '0',
                      'CurlDay3': '0',
                      'CurlDay4': '0',
                      'CurlDay5': '0',
                      'CurlDay6': '0',
                      'CurlDay7': '0',
                      'DateTime': '0',
                      
                    }
                  );
  Navigator.pushAndRemoveUntil(
  (context),
  MaterialPageRoute(builder: (context) => BottomNavScreen()),
  (route) => false); 
  }

}

