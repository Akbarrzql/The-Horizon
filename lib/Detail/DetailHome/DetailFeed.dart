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
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widgets.Image.asset(
                'assets/logonew1.png',
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 1), child: Text('TheHorizon', style: GoogleFonts.imFellGreatPrimerSc(color: Colors.black),)),
            ],
          ),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: loadingFeed ? ListView.builder(
          itemCount: feedModel?.mostread!.articles!.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: () {
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
                            margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${feedModel?.mostread!.articles![index].normalizedtitle.toString() ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),
                                        Text("${feedModel?.mostread!.articles![index].description.toString() ?? "Kesalahan pada server"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
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
            );
          }) : Center( child: Lottie.asset('assets/loadingparticle.json', width: 300, height: 300, fit: BoxFit.cover,),),
    );
  }
}

