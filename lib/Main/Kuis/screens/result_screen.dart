import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thehorizonapps/Main/Kuis/screens/quizz_screen.dart';
import 'package:thehorizonapps/Main/bottomnav.dart';

class ResultScreen extends StatefulWidget {
  int score;
  ResultScreen(this.score, {Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                              color: Color(0xff004A54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.only(top: 80.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Selamat! Kamu telah menyelesaikan kuis dari TheHorizon",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          "Hasil kuis yang benar: ${widget.score}",
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100, left: 50),
                    child: Image.asset(
                      'assets/robot.gif',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 470.0, left: 85),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            //height and width
                            minimumSize: Size(50, 50),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainNav()));
                          },
                          child: Text("Selesai"),
                        ),
                        SizedBox(width: 20,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            //height and width
                            minimumSize: Size(100, 50),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => QuizzScreen()));
                          },
                          child: Text("Coba Lagi"),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}
