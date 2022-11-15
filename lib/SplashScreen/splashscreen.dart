import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thehorizonapps/Main/bottomnav.dart';
import 'package:thehorizonapps/Main/PageJelajahi/home.dart';
import 'package:thehorizonapps/OnBoarding/onboarding_screen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainNav()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logonew1.png",
              width: 300.0,
              height: 300.0,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
