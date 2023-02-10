import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/Kuis/screens/quizz_screen.dart';
import 'package:thehorizonapps/Main//Kuis/ui/shared/color.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff042330),
          elevation: 0.5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/newlogosmall.png',
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 1), child: Text('TheHorizon', style: GoogleFonts.imFellGreatPrimerSc(color: Colors.white),)),
            ],
          ),
          //no back button
          automaticallyImplyLeading: false,
        ),
      backgroundColor: Color(0xff042330),
      body: Center(
        child: Container(
          child:Stack(
            children: [
              Center(
                child: Stack(
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Card(
                          elevation: 0,
                          color: Color(0xff042330),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Container(
                              margin: EdgeInsets.only(top: 80.0),
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mari belajar bersama di TheHorizon",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                    ]
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25.0, left: 60),
                  child: Image.asset(
                    'assets/astronaut.gif',
                    width: 250,
                    height: 250,
                  ),
              ),
              Container(
                margin: EdgeInsets.only(top: 370.0, left: 110),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff5FD068),
                    onPrimary: Colors.white,
                    //height and width
                    minimumSize: Size(150, 50),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizzScreen()));
                  },
                  child: Text("Mulai Kuis"),
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}
