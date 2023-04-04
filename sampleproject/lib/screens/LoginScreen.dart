import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sampleproject/screens/bottom_nav_screen.dart';
import 'package:sampleproject/screens/registration.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() =>  _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  //editting controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    //email field 
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
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
        emailController.text = value!;
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
      controller: passwordController,
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
        emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
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

  final loginButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.green,
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        signIn(emailController.text, passwordController.text);
      },
      child: Text(
        "Login",
        textAlign: TextAlign.center,
        style: TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      )), 
      );

  

 return Container(
    decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Sign in.jpg'
          ),
          fit: BoxFit.cover)
        ),
     child: Scaffold(
    
    backgroundColor: Colors.transparent,
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

                  SizedBox(height: 500),

                  emailField,
                  SizedBox(height: 30),

                  passwordField,
                  SizedBox(height: 40),
                  
                  loginButton,
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? "),
                      GestureDetector(onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()
                        ));
                      },
                      child: Text(" Sign Up", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 15),
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


 void signIn(String email, String password) async
 {
  if (_formKey.currentState!.validate())
  {
    await _auth
    .signInWithEmailAndPassword(email: email, password: password).then((uid) => {
      Fluttertoast.showToast(msg: "Login Successful!"),
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavScreen())),

    }).catchError((e)
    {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
 }
}
 
