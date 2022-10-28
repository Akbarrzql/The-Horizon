import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/image.dart' as image;
import 'package:image_downloader/image_downloader.dart';
import 'package:share/share.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailFeed.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailOtd.dart';
import 'package:thehorizonapps/Detail/DetailHome/DetailFeed.dart';
import 'package:thehorizonapps/Detail/DetailHome/detailOtd.dart';
import 'package:thehorizonapps/Model/FeedModel.dart';
import 'package:thehorizonapps/Model/OnThisDayModel.dart';
import 'package:thehorizonapps/Search/SearchPage.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Model and variable
  FeedModel? feedModel;
  OnThisDayModel? onThisDayModel;
  bool loading = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  String year = DateTime.now().year.toString();
  String mount = DateTime.now().month.toString();
  String day = DateTime.now().day.toString();


  //get data
  getFeed() async {
    setState(() {
      loading = false;
    });

    final responseOtd = await http.get(Uri.parse('https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/${mount}/${day}'));
    print("Response status: ${responseOtd.statusCode}");
    onThisDayModel = OnThisDayModel.fromJson(jsonDecode(responseOtd.body.toString()));
    print("Response body: ${onThisDayModel?.events![0].text}");

    final response = await http.get(Uri.parse('https://api.wikimedia.org/feed/v1/wikipedia/id/featured/${year}/${mount}/${day}'));
    print("Response status: ${response.statusCode}");
    feedModel = FeedModel.fromJson(jsonDecode(response.body.toString()));
    print("Response body: ${feedModel?.mostread!.articles![0].normalizedtitle}");



    setState(() {
      loading = true;
    });
  }


  Future<dynamic> _refresh() {
    return getFeed();
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeed();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState!.show());
  }

  @override
  Widget build(BuildContext context) {

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

    return Scaffold(
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
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  //side border
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                    Text(
                      'Cari artikel, Sejarah atau hal lainnya',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
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
        child: Row(
            children: <Widget>[
              Text("Hari ini di TheHorizon", style: GoogleFonts.poppins(color: Color(0xff004A54), fontSize: 24, fontWeight: FontWeight.bold),),
            ]
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
                      child:  Text("Hari ini", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child:  Text("Sejarah Hari Ini", style: GoogleFonts.poppins(color: Color(0xff004A54), fontSize: 24, fontWeight: FontWeight.w600),),
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
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/circle.gif'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${onThisDayModel?.events![0].year ?? "Kesahalan pada server"}", style: GoogleFonts.poppins(color: Color(0xff004A54), fontSize: 20, fontWeight: FontWeight.w600),),
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
                                    Text("${onThisDayModel?.events![0].text ?? "Kesahalan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOnthisday(
                                          pages: onThisDayModel!.events![0].pages![0],
                                        )));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: 330,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.only(bottom: 10),
                                                child: widgets.Image.network("${onThisDayModel?.events![0].pages![0].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"}", width: 330, height: 230, fit: BoxFit.cover,),
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
                                                            Text("${onThisDayModel?.events![0].pages![0].normalizedtitle ?? "Kesahalan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
                                                            Divider(
                                                              color: Colors.grey,
                                                              height: 20,
                                                              thickness: 1,
                                                              indent: 0,
                                                              endIndent: 200,
                                                            ),
                                                            Text("${onThisDayModel?.events![0].pages![0].description ?? "Kesahalan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
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
                        Text("Lebih banyak sejarah pada hari ini", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 16), fontWeight: FontWeight.w600),),
                        Icon(Icons.arrow_forward, color: Color(0xff004A54),)
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
                    Text("Bacaan Teratas", style: GoogleFonts.poppins(color: Color(0xff004A54), fontSize: 24, fontWeight: FontWeight.w600),),
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
            color: Colors.white,
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
                                  margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                  //text circle avatar
                                  child: widgets.Image.asset("assets/one.png", width: 32, height: 32,),
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
                                              Text("${feedModel?.mostread!.articles![0].normalizedtitle.toString() ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),
                                              Text("${feedModel?.mostread!.articles![0].description.toString() ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
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
                                    'assets/two.png',
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
                                              Text("${feedModel?.mostread!.articles![1].normalizedtitle ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
                                              Text("${feedModel?.mostread!.articles![1].description ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
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
                                    'assets/three.png',
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
                                              Text("${feedModel?.mostread!.articles![2].normalizedtitle ?? "Kesalahan pada server" }", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
                                              Text("${feedModel?.mostread!.articles![2].description ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
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
                                    'assets/four.png',
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
                                              Text("${feedModel?.mostread!.articles![3].normalizedtitle ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
                                              Text("${feedModel?.mostread!.articles![3].description ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
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
                                    'assets/five.png',
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
                                              Text("${feedModel?.mostread!.articles![4].normalizedtitle ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
                                              Text("${feedModel?.mostread!.articles![4].description ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
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
                        Text("Lebih banyak bacaan tertas", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 18), fontWeight: FontWeight.w600),),
                        Icon(Icons.arrow_forward, color: Color(0xff004A54),)
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
            Text("Gambar Pilihan", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 24), fontWeight: FontWeight.w600),),
          ],
        ),
      ),
      InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Color(0xffCBCBCB), width: 0.5),
          ),
          child: Container(
            width: 330,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: widgets.FadeInImage.assetNetwork(placeholder: 'assets/logo.png', image: 'https://images.unsplash.com/photo-1577083288073-40892c0860a4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80', fit: BoxFit.cover),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          width: 300,
                          child: Column(
                            children: [
                              Text("Congreve Street, Birmingham, showing Christ Church and the Town Hall, By Laurence J Hart", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w600),),
                            ],
                          )
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff004A54),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async{
                              //donwload image from link
                              var imageId = await ImageDownloader.downloadImage("https://images.unsplash.com/photo-1577083288073-40892c0860a4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80");
                              if (imageId == null) {
                                return;
                              }
                              var path = await ImageDownloader.findPath(imageId);
                              print(path);
                            },
                            icon: Icon(Icons.file_download_outlined, size: 18),
                            label: Text("UNDUH"),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff004A54),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async {
                              // Respond to button press
                              //share image
                              final urlImage = "https://images.unsplash.com/photo-1577083288073-40892c0860a4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80";

                              await Share.share('Congreve Street, Birmingham, showing Christ Church and the Town Hall, By Laurence J Hart $urlImage');
                            },
                            icon: Icon(Icons.share, size: 18),
                            label: Text("BAGIKAN"),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top:50, left: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Artikel Acak", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 24), fontWeight: FontWeight.w600),),
          ],
        ),
      ),
      InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Color(0xffCBCBCB), width: 0.5),
          ),
          child: Container(
            width: 330,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: widgets.Image.asset('assets/logo.png', fit: BoxFit.cover),
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
                              Text("Lorem ipsum dolor sit amet", style: GoogleFonts.poppins(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
                              Divider(
                                color: Colors.grey,
                                height: 20,
                                thickness: 1,
                                indent: 0,
                                endIndent: 200,
                              ),
                              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquet ipsum id mi porta volutpat. Donec convallis velit id maximus ornare. Mauris et velit fringilla ", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),),
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
      Container(
        child: Row(
          children: [
            InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Row(
                      children: <Widget>[
                        Text("Artikel acak lebih banyak", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 18), fontWeight: FontWeight.w600),),
                        Icon(Icons.arrow_forward, color: Color(0xff004A54),)
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
