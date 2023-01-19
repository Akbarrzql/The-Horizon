import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/image.dart' as image;
import 'package:flutter/services.dart' as rootBundle;
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailFeed.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailOtd.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailRandom.dart';
import 'package:thehorizonapps/Detail/DetailEditionHistory/HistoryEdition.dart';
import 'package:thehorizonapps/Detail/DetailHome/DetailFeed.dart';
import 'package:thehorizonapps/Detail/DetailHome/DetailRandom.dart';
import 'package:thehorizonapps/Detail/DetailHome/detailOtd.dart';
import 'package:thehorizonapps/Model/FeedModel.dart';
import 'package:thehorizonapps/Model/HistoryModel.dart';
import 'package:thehorizonapps/Model/OnThisDayModel.dart';
import 'package:thehorizonapps/Search/SearchPage.dart';
import 'package:thehorizonapps/Model/RandomModel.dart';
import 'package:thehorizonapps/controller/Controller.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Model and variable
  FeedModel? feedModel;
  OnThisDayModel? onThisDayModel;
  var loading = true.obs;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  String year = DateTime.now().year.toString();
  String mount = DateTime.now().month.toString().padLeft(2, '0');
  String day = DateTime.now().day.toString().padLeft(2, '0');



  //get data
  getFeed() async {
    setState(() {
      loading(true);
    });

    final responseOtd = await http.get(Uri.parse('https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/${mount}/${day}'));
    print("Response status: ${responseOtd.statusCode}");
    onThisDayModel = OnThisDayModel.fromJson(jsonDecode(responseOtd.body.toString()));
    print("Response body: ${onThisDayModel?.events![0].text}");

    final response = await http.get(Uri.parse('https://api.wikimedia.org/feed/v1/wikipedia/id/featured/${year}/${mount}/${day}'));
    print("Response status: ${response.statusCode}");
    feedModel = FeedModel.fromJson(jsonDecode(response.body.toString()));



    setState(() {
      loading(false);
    });
  }


  Future<dynamic> _refresh() {
    return getFeed();
  }

  //randomArticle Json
  Future<List<RandomModel>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('assets/randomArticle.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => RandomModel.fromJson(e)).toList();
  }

  //HistoryEdition Json
  Future<List<HistoryModel>> ReadJsonHistoryData() async {
    final jsondata = await rootBundle.rootBundle.loadString('assets/HistoryEdition.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => HistoryModel.fromJson(e)).toList();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeed();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState!.show());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SearchPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.1, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff042330),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          child: Column(
            children: <Widget>[
              Container(
                //search on tap
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_createRoute());
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff042330),
                      borderRadius: BorderRadius.circular(10),
                      //side border
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        Text(
                          'Cari artikel, Sejarah atau hal lainnya',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 15),
                child: Column(
                  children: [
                    Row(
                        children: <Widget>[
                          Text("Hari ini di TheHorizon", style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                        ]
                    ),
                    Divider(
                      color: Color(0xff5FD068),
                      thickness: 5,
                      height: 5,
                      endIndent: 250,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top:20, left: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child:  Text("Hari ini", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child:  Text("Sejarah Hari Ini", style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),),
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 5, top: 10),
                              width: 40,
                              height: 40,
                              child: Lottie.asset('assets/circle.json', width: 300, height: 300, fit: BoxFit.cover,),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${onThisDayModel?.events![0].year ?? "Kesahalan pada server"}", style: GoogleFonts.poppins(color: Color(0xff5FD068), fontSize: 20, fontWeight: FontWeight.w600),),
                                ],
                              ),
                            )
                          ]
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: EdgeInsets.only(left: 17, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                VerticalDivider(
                                  color: Color(0xffCBCBCB),
                                  thickness: 1,
                                ),
                                Container(
                                  width: 320,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${onThisDayModel?.events![0].text ?? "Kesahalan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOnthisday(
                                                  pages: onThisDayModel!.events![0].pages![0],
                                                )));
                                              },
                                              child: Card(
                                                color: Color(0xff042330),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  side: BorderSide(color: Colors.white, width: 0.5),
                                                ),
                                                child: Container(
                                                  width: 330,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: const EdgeInsets.only(bottom: 10),
                                                        //image radius
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                            child: widgets.Image.network("${onThisDayModel?.events![0].pages![0].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"}", width: 330, height: 230, fit: BoxFit.cover,)
                                                        ),
                                                      ),
                                                      Container(
                                                        color: Color(0xff042330),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                                                width: 300,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("${onThisDayModel?.events![0].pages![0].normalizedtitle ?? "Kesahalan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),),
                                                                    Divider(
                                                                      color: Colors.white,
                                                                      height: 20,
                                                                      thickness: 1,
                                                                      indent: 0,
                                                                      endIndent: 200,
                                                                    ),
                                                                    Text("${onThisDayModel?.events![0].pages![0].description ?? "Kesahalan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                                                                  ],
                                                                )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOtd()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                              children: <Widget>[
                                Text("Lebih banyak sejarah pada hari ini", style: GoogleFonts.poppins(color: Color(0xff5FD068), textStyle: TextStyle(fontSize: 16), fontWeight: FontWeight.w600),),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Icon(Icons.arrow_forward, color: Color(0xff5FD068), size: 20,),
                                )
                              ]
                          ),
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 50, left: 15),
                  child: Column(
                    children: [
                      Row(
                          children: <Widget>[
                            Text("Bacaan Teratas", style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),),
                          ]
                      ),
                    ],
                  )
              ),
              Container(
                child: SizedBox(
                  width: 350,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0xffCBCBCB), width: 0.5),
                    ),
                    color: Color(0xff042330),
                    child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                                articles: feedModel!.mostread!.articles![0],
                              )));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                          //text circle avatar
                                          child: widgets.Image.asset("assets/number-1.png", width: 24, height: 24,),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: 200,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${feedModel?.mostread!.articles![0].normalizedtitle.toString() ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                                                      Text("${feedModel?.mostread!.articles![0].description.toString() ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                                                    ],
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20), // Image border
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(30), // Image radius
                                                child: widgets.Image.network("${feedModel?.mostread!.articles![0].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"}", fit: BoxFit.cover, width: 30, height: 30,),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffCBCBCB),
                                    thickness: 0.5,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                                articles: feedModel!.mostread!.articles![1],
                              )));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                          //text circle avatar
                                          child: widgets.Image.asset(
                                            'assets/number-2.png',
                                            height: 32,
                                            width: 32,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: 200,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${feedModel?.mostread!.articles![1].normalizedtitle ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),
                                                      Text("${feedModel?.mostread!.articles![1].description ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                                                    ],
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20), // Image border
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(30), // Image radius
                                                child: widgets.Image.network('${feedModel?.mostread!.articles![1].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"}', fit: BoxFit.cover, width: 30, height: 30,),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffCBCBCB),
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                                articles: feedModel!.mostread!.articles![2],
                              )));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                          //text circle avatar
                                          child: widgets.Image.asset(
                                            'assets/number-3.png',
                                            height: 32,
                                            width: 32,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: 200,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${feedModel?.mostread!.articles![2].normalizedtitle ?? "Kesalahan pada server" }", style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),
                                                      Text("${feedModel?.mostread!.articles![2].description ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                                                    ],
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20), // Image border
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(30), // Image radius
                                                child: widgets.Image.network("${feedModel?.mostread!.articles![2].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"}", fit: BoxFit.cover, width: 30, height: 30,),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffCBCBCB),
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                                articles: feedModel!.mostread!.articles![3],
                              )));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                          //text circle avatar
                                          child: widgets.Image.asset(
                                            'assets/number-4.png',
                                            height: 32,
                                            width: 32,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: 200,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${feedModel?.mostread!.articles![3].normalizedtitle ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),
                                                      Text("${feedModel?.mostread!.articles![3].description ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                                                    ],
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20), // Image border
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(30), // Image radius
                                                child: widgets.Image.network('${feedModel?.mostread!.articles![3].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"}', fit: BoxFit.cover, width: 30, height: 30,),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffCBCBCB),
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                                articles: feedModel!.mostread!.articles![4],
                              )));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                          //text circle avatar
                                          child: widgets.Image.asset(
                                            'assets/number-5.png',
                                            height: 32,
                                            width: 32,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: 200,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${feedModel?.mostread!.articles![4].normalizedtitle ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),
                                                      Text("${feedModel?.mostread!.articles![4].description ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                                                    ],
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20), // Image border
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(30), // Image radius
                                                child: widgets.Image.network('${feedModel?.mostread!.articles![4].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"}', fit: BoxFit.cover, width: 30, height: 30,),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailFeed()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                              children: <Widget>[
                                Text("Lebih banyak bacaan tertas", style: GoogleFonts.poppins(color: Color(0xff5FD068), textStyle: TextStyle(fontSize: 18), fontWeight: FontWeight.w600),),
                                Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Icon(Icons.arrow_forward, color: Color(0xff5FD068), size: 20,)
                                )
                              ]
                          ),
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top:50, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Edisi Sejarah", style: GoogleFonts.poppins(color: Colors.white, textStyle: TextStyle(fontSize: 24), fontWeight: FontWeight.w600),),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Kami pikir Anda akan menyukai", style: GoogleFonts.poppins(color: Color(0xffCBCBCB), textStyle: TextStyle(fontSize: 14), fontWeight: FontWeight.w400),),
                      ]
                    )
                  ],
                ),
              ),
              //Edisi Sejarah
              FutureBuilder(
                future: ReadJsonHistoryData(),
                builder: (context, data) {
                  if (data.hasError) {
                    return ScaffoldMessenger(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var items = data.data as List<HistoryModel>;
                    //if card is finish then show finish page
                    if (items.isEmpty) {
                      return ScaffoldMessenger(child: Text("Finish"));
                    } else {
                      return SizedBox(
                        height: 310,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailHistoryEdition(
                                      historyModel: items[index],
                                    )));
                                  },
                                  //ui blinkist
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              width: 200,
                                              child: Card(
                                                margin: EdgeInsets.only(top: 90),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(100),
                                                      topRight: Radius.circular(100),
                                                      bottomLeft: Radius.circular(5),
                                                      bottomRight: Radius.circular(5)
                                                  ),
                                                ),
                                                color: Color(0xff5FD068),
                                              ),
                                            ),
                                            Container(
                                              child: Container(
                                                width: 130,
                                                height: 170,
                                                margin: const EdgeInsets.only(top: 10, left: 35),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5), // Image border
                                                  child: SizedBox.fromSize(
                                                    size: Size.fromRadius(30), // Image radius
                                                    child: widgets.Image.network('${items[index].image}', fit: BoxFit.cover, width: 30, height: 30,),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 200,
                                          margin: const EdgeInsets.only(top: 10),
                                          child: Text("${items[index].namaSejarah}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                                        ),
                                        Container(
                                          width: 200,
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Text("${items[index].author}", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal),),
                                        ),
                                      ],
                                    ),
                                  )
                              );
                            },
                          ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(top:25, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Artikel Acak", style: GoogleFonts.poppins(color: Colors.white, textStyle: TextStyle(fontSize: 24), fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
              FutureBuilder(
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
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailArticleRandom(
                            randomModel: items[0],
                          )));
                        },
                        child: Card(
                          color: Color(0xff042330),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white, width: 0.5),
                          ),
                          child: Container(
                            width: 330,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  //image radius
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                    child: widgets.Image.network(items[0].image.toString(), fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                          width: 300,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(items[0].title.toString(), style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
                                              Divider(
                                                color: Colors.white,
                                                height: 20,
                                                thickness: 1,
                                                indent: 0,
                                                endIndent: 200,
                                              ),
                                              Text(items[0].description.toString(), style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Container(
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailRandom()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Row(
                              children: <Widget>[
                                Text("Artikel acak lebih banyak", style: GoogleFonts.poppins(color: Color(0xff5FD068), textStyle: TextStyle(fontSize: 18), fontWeight: FontWeight.w600),),
                                Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Icon(Icons.arrow_forward, color: Color(0xff5FD068), size: 20,)
                                )
                              ]
                          ),
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}