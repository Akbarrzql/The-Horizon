import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/Kuis/data/questions_example.dart';
import 'package:thehorizonapps/Main/Kuis/screens/result_screen.dart';
import 'package:thehorizonapps/Main/Kuis/ui/shared/color.dart';


class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Selanjutnya";
  bool answered = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff042330),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              if (page == questions.length - 1) {
                setState(() {
                  btnText = "See Results";
                });
              }
              setState(() {
                answered = false;
              });
            },
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      "${index + 1}/10",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      // height: 200.0,
                      child: Text(
                        "${questions[index].question}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < questions[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      height: 60.0,
                      margin: EdgeInsets.only(
                          bottom: 10.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        padding: EdgeInsets.all(20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: btnPressed
                            ? questions[index].answers!.values.toList()[i]
                                ? Colors.green
                                : Colors.red
                            : Color(0xff042330),
                        onPressed: !answered
                            ? () {
                                if (questions[index]
                                    .answers!
                                    .values
                                    .toList()[i]) {
                                  score++;
                                  print("yes");
                                } else {
                                  print("no");
                                }
                                setState(() {
                                  btnPressed = true;
                                  answered = true;
                                });
                              }
                            : null,
                        child: Text(questions[index].answers!.keys.toList()[i],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                  GestureDetector(
                    onTap:(){
                      //if answer not selected then show alert
                      if(!answered) {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color(0xff2C3333),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            //width and height of alert dialog
                            title: Text("Jawaban belum terisi!", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16, color: Colors.red)), textAlign: TextAlign.center,),
                            content: Text("Silahkan Isi Jawaban Dengan baik dan benar", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14, color: Colors.white)),textAlign: TextAlign.center,),
                            actions: [
                              //elevated button in center
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff5FD068),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14, color: Colors.white)),),
                                ),
                              ),
                            ],
                          );
                        });
                      } else {
                        //if answer selected then move to next question
                        if (btnText == "See Results") {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(score,)));
                        } else {
                          _controller!.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeInExpo);
                          setState(() {
                            btnPressed = false;
                          });
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: answered ? Color(0xff5FD068) : Colors.grey),
                        color: answered ? Color(0xff5FD068) : Colors.grey,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //if answer not selected then button is disabled
                          Text(
                            btnText,
                            style: TextStyle(
                              color: answered ? Colors.white : Colors.white54,
                              fontSize: 16.0,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: answered ? Colors.white : Colors.white54,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            itemCount: questions.length,
          )),
    );
  }
}
