import 'package:flutter/material.dart';
import 'dart:async';
import 'package:thehorizonapps/OnBoarding/onboarding_screen.dart';

class splashscreentwo extends StatefulWidget {
  const splashscreentwo({Key? key}) : super(key: key);

  @override
  State<splashscreentwo> createState() => _splashscreentwoState();
}

class _splashscreentwoState extends State<splashscreentwo> {

  startSplashScreentwo() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreentwo();
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
              "assets/logo_transparent.png",
              width: 400.0,
              height: 400.0,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
