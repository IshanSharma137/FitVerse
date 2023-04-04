import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VR_Menu extends StatefulWidget {
  const VR_Menu({Key? key}) : super(key: key);

  @override
  State<VR_Menu> createState() => _VR_MenuState();
}

class _VR_MenuState extends State<VR_Menu> {

 
  @override
  Widget build(BuildContext context) {
   final screenHeight = MediaQuery.of(context).size.height;
    return Container(
    decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/vrBg.jpg'
          ),
          fit: BoxFit.cover)
        ),
     child: Scaffold(
        backgroundColor: Colors.transparent,
        
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("FITVERSE VR ARENA",style: TextStyle( 
                     fontSize: 18,
                     height: 2, 
                     color: Color.fromRGBO(255, 255, 255, 1),
                     fontWeight: FontWeight.w800,
                     letterSpacing: 3, 
                     
                     

                  ),),
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[

          _buildHeaderVR(screenHeight),
          _buildbuttons(screenHeight),

        ],

        )
    ), );
  }

  SliverToBoxAdapter _buildHeaderVR(double screenHeight)
{
  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.all(1.0),
      
      ),
      
  );
}

  SliverToBoxAdapter _buildbuttons (double screenHeight) {
     launchURL(String url) async{
    await launch(url);
  }
  return SliverToBoxAdapter(
   
    
    child: Container(

      padding: const EdgeInsets.all(20.0),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            
        const SizedBox(height: 20.0),
        Row(
        children: <Widget>[
           IconButton(
            icon: Image.asset('assets/vrMed.png'),
            iconSize: 150,
            onPressed: () {
               const url = 'https://youtu.be/TZD1Bjq0tIU';
               launchURL(url);
            },
          ),
           Text(" <- VR Meditation",style: TextStyle( 
                     fontSize: 18,
                     height: 2, 
                     color: Colors.purple, 
                     fontWeight: FontWeight.w800,
                     letterSpacing: 2, ))  
            
          
        ],
        ),
        Row(children: <Widget>[
  IconButton(
  icon: Image.asset('assets/vrWork.png'),
  iconSize: 150,
  onPressed: () {
    const url = 'https://youtu.be/qbd4It8DITU';
    launchURL(url);
  },
),
Text(" <- VR Workout",style: TextStyle( 
                     fontSize: 18,
                     height: 2, 
                     color: Colors.purple, 
                     fontWeight: FontWeight.w800,
                     letterSpacing: 2, ))  
                   
                    
         ]
         ),
         Row(children: <Widget>[
         
IconButton(
  icon: Image.asset('assets/vrCycle.png'),
  iconSize: 150,
  onPressed: () {
     const url = 'https://youtu.be/gq-1JWrp80w';
    launchURL(url);
  },
),
Text(" <- VR Cycling",style: TextStyle( 
                     fontSize: 18,
                     height: 2, 
                     color: Colors.purple, 
                     fontWeight: FontWeight.w800,
                     letterSpacing: 2, ))  
             
         
         ],)]
         )
         )
  );
}
  }
