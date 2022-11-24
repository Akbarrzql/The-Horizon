import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailFeed.dart';
import 'package:thehorizonapps/Model/FeedModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart' as widgets;
import 'dart:convert';

class DetailFeed extends StatefulWidget {
  const DetailFeed({Key? key}) : super(key: key);

  @override
  State<DetailFeed> createState() => _DetailFeedState();
}

class _DetailFeedState extends State<DetailFeed> {

  FeedModel? feedModel;
  bool loadingFeed = true;
  String year = DateTime.now().year.toString();
  String mount = DateTime.now().month.toString();
  String day = DateTime.now().day.toString().padLeft(2, '0');
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  void getFeedDetail() async{
    setState(() {
      loadingFeed = false;
    });
    final response = await http.get(Uri.parse('https://api.wikimedia.org/feed/v1/wikipedia/id/featured/${year}/${mount}/${day}'));
    print("Response status: ${response.statusCode}");
    feedModel = FeedModel.fromJson(jsonDecode(response.body.toString()));
    print("Response body: ${feedModel?.mostread!.articles![0].normalizedtitle}");
    setState(() {
      loadingFeed = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeedDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff042330),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xff042330),
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 120.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Bacaan Teratas TheHorizon'),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
            childCount: feedModel?.mostread!.articles!.length,
                (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                                  articles: feedModel!.mostread!.articles![index],
                                )));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(top: 10, left: 15,),
                                            child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${feedModel?.mostread!.articles![index].normalizedtitle.toString() ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                                                      Text("${feedModel?.mostread!.articles![index].description.toString() ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                                                  ],
                                                )
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 60),
                                          child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20), // Image border
                                            child: SizedBox.fromSize(
                                              size: Size.fromRadius(30), // Image radius
                                              child: widgets.Image.network("${feedModel?.mostread!.articles![index].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png"}", fit: BoxFit.cover, width: 30, height: 30,),
                                              ),
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xff837F7F),
                        height: 20,
                        thickness: 1,
                        indent: 15,
                        endIndent: 15,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

