import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailRandom.dart';
import 'package:thehorizonapps/Model/RandomModel.dart';


class DetailRandom extends StatefulWidget {
  const DetailRandom({Key? key}) : super(key: key);

  @override
  State<DetailRandom> createState() => _DetailRandomState();
}

class _DetailRandomState extends State<DetailRandom> {

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
        backgroundColor: Color(0xff042330),
        appBar: AppBar(
          backgroundColor: Color(0xff042330),
          title: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
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
          ),
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return ScaffoldMessenger(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<RandomModel>;
              //if card is finish then show finish page
              if (items.isEmpty) {
                return ScaffoldMessenger(child: Text("Finish"));
              } else {
                return Scaffold(
                  backgroundColor: Color(0xff042330),
                  body: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Column(
                                children:[
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Image.asset(
                                      'assets/random.png',
                                      fit: BoxFit.contain,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text('Artikel Acak', style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Divider(
                                      color: Color(0xff5FD068),
                                      thickness: 5,
                                      indent: 100,
                                      endIndent: 100,
                                    ),
                                  ),
                                ]
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: TinderSwapCard(
                            swipeUp: true,
                            swipeDown: true,
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: items.length,
                            stackNum: 2,
                            swipeEdge: 4.0,
                            maxWidth: MediaQuery.of(context).size.width * 1.1,
                            maxHeight: MediaQuery.of(context).size.width * 2.0,
                            minWidth: MediaQuery.of(context).size.width * 0.7,
                            minHeight: MediaQuery.of(context).size.width * 1.5,
                            cardBuilder: (context, index) => Card(
                                color: Color(0xff042330),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(color: Colors.white),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailArticleRandom(
                                              randomModel: items[index],
                                            )));
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //image radius
                                        Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: NetworkImage(items[index].image!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(items[index].title.toString(), style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                                              const Divider(
                                                color: Color(0xff5FD068),
                                                height: 20,
                                                thickness: 1,
                                                indent: 0,
                                                endIndent: 200,
                                              ),
                                              Text(items[index].description.toString(), style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            cardController: controller = CardController(),
                            swipeUpdateCallback:
                                (DragUpdateDetails details, Alignment align) {
                              /// Get swiping card's alignment
                              if (align.x < 0) {
                                //Card is LEFT swiping
                              } else if (align.x > 0) {
                                //Card is RIGHT swiping
                              }
                            },
                            swipeCompleteCallback:
                                (CardSwipeOrientation orientation, int index) {
                              /// Get orientation & index of swiped card!
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: Image.asset('assets/loading-plane.gif', width: 200, height: 200, fit: BoxFit.cover,),
              );
            }
          },
        ));
  }

  Future<List<RandomModel>> ReadJsonData() async {
    final jsondata =
    await rootBundle.rootBundle.loadString('assets/randomArticle.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => RandomModel.fromJson(e)).toList();
  }
}

