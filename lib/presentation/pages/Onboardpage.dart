import 'package:carrentalapp/firebase_options.dart';
import 'package:carrentalapp/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Onboardpage extends StatefulWidget {
  const Onboardpage({super.key});

  @override
  State<Onboardpage> createState() => _OnboardpageState();
}

class _OnboardpageState extends State<Onboardpage> {
  bool changebutton= false;
  moveToLogin(BuildContext context) async {
  setState(() {
    changebutton = true;
  });

  await Future.delayed(Duration(seconds: 1));
  await Navigator.pushNamed(context, MyRoutes.loginRoute);

  setState(() {
    changebutton = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C2B34),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login.png'),
                  fit: BoxFit.cover,
                 )
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Premium cars, \nEnjoy the luxury',
                   style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                   ),
                   SizedBox(height: 10),
                   Text('Premium and prestigious car daily rental, \nExperience the thrill at a lower price'
                   , style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.normal)
                   ),
                   SizedBox(height: 20,),
                   SizedBox(
                    width: 320,
                    height: 54,
                     child: ElevatedButton(onPressed: (){
                      moveToLogin(context);
                     },
                     style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                     ),
                     child: Text('Let\'s Go', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                     ),
                   )
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}