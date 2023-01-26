import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thehorizonapps/Login/login.dart';
import 'package:thehorizonapps/Main/article_users/view_article_page.dart';
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
          MaterialPageRoute(builder: (context) => const view_aritcle()),
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
      backgroundColor: Color(0xff042330),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/newlogoupdate.png",
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