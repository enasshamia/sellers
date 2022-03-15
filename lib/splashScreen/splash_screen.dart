import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lhad_elbeit_selleres/authenctication/auth_screen.dart';
import 'package:lhad_elbeit_selleres/global/global.dart';
import 'package:lhad_elbeit_selleres/mainScreens/home_screen.dart';
class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){


    Timer(const Duration(seconds: 2),() async {

      // if seller logedin
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context,MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      else{
        Navigator.push(context,MaterialPageRoute(builder: (c)=> const AuthScreen()));

      }

    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/d.png"),
              const SizedBox(height: 10,),
              const Padding(
                  padding:  EdgeInsets.all(18.0),
                  child: Text(
                    "Sell Food Online",
                    textAlign:TextAlign.center ,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 40,
                      letterSpacing: 3,

                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
