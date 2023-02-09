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
        backgroundColor: Color(0xff042330),
        body: Center(
            child: SingleChildScrollView(
          child: Container(
              child: Stack(
            children: [
              Center(
                child: Stack(children: [
                  SizedBox(
                    // width: 300,
                    // height: 300,
                    child: Card(
                      elevation: 0,
                      color: Color(0xff042330),
                      shape: RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(50.0),
                          ),
                      child: Container(
                          // margin: EdgeInsets.only(top: 80.0),
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
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
                            // margin: EdgeInsets.only(top: 100, left: 50),
                            child: Image.asset(
                              'assets/robot.gif',
                              width: 220,
                              // height: 220,
                            ),
                          ),
                          Container(
                            width: 250,
                            margin:
                                EdgeInsets.only(top: 5, left: 20, right: 20),
                            child: Text(
                              "Bagaimana kuisnya seru ngga? tentunya seru dong",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Hasil kuis yang benar: ${widget.score}",
                              style: TextStyle(
                                color: Color(0xff5FD068),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff5FD068),
                                    onPrimary: Colors.white,
                                    //height and width
                                    minimumSize: Size(50, 50),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainNav()));
                                  },
                                  child: Text(
                                    "Selesai",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                    //height and width
                                    minimumSize: Size(100, 50),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QuizzScreen()));
                                  },
                                  child: Text(
                                    "Coba Lagi",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                ]),
              ),
            ],
          )),
        )));
  }
}
