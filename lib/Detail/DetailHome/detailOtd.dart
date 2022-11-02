import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailOtd.dart';
import 'package:thehorizonapps/Model/OnThisDayModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart' as widgets;
import 'dart:convert';

class DetailOtd extends StatefulWidget {
  const DetailOtd({Key? key}) : super(key: key);

  @override
  State<DetailOtd> createState() => _DetailOtdState();
}

class _DetailOtdState extends State<DetailOtd> {

  OnThisDayModel? onThisDayModel;
  bool loadingOtd = true;
  bool isVisiblemage =  true;
  final ScrollController _scrollController = ScrollController();
  //get mount
  String mount = DateTime.now().month.toString();
  String day = DateTime.now().day.toString();


  void getOtd() async{
    setState(() {
      loadingOtd = false;
    });
    final responseOtd = await http.get(Uri.parse('https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/${mount}/${day}'));
    print("Response status: ${responseOtd.statusCode}");
    onThisDayModel = OnThisDayModel.fromJson(jsonDecode(responseOtd.body.toString()));
    print("Response body: ${onThisDayModel?.events![0].text}");
    setState(() {
      loadingOtd = true;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOtd();

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
      body: loadingOtd ? ListView.builder(
        controller: _scrollController,
        itemCount: onThisDayModel?.events?.length,
        itemBuilder: (context, index) {
          return Container(
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
                              Text("${onThisDayModel?.events![index].year ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Color(0xff004A54), fontSize: 20, fontWeight: FontWeight.w600),),
                            ],
                          ),
                        )
                      ]
                  ),
                ),
                Container(
                  width: 350,
                  margin: EdgeInsets.only(left: 17, top: 10),
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
                                        Text("${onThisDayModel?.events![index].text ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOnthisday(
                                              pages: onThisDayModel!.events![index].pages![0],
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
                                                    child: FadeInImage.assetNetwork(placeholder: 'assets/logo.png', image: onThisDayModel?.events![index].pages![0].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png", width: 330, height: 230, fit: BoxFit.cover,),
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
                                                                Text("${onThisDayModel?.events![index].pages![0].normalizedtitle ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
                                                                const Divider(
                                                                  color: Colors.grey,
                                                                  height: 20,
                                                                  thickness: 1,
                                                                  indent: 0,
                                                                  endIndent: 200,
                                                                ),
                                                                Text("${onThisDayModel?.events![index].pages![0].description ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
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
          );
        },

      ) : Center(
        child: Lottie.asset('assets/loadingparticle.json', width: 300, height: 300, fit: BoxFit.cover,),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn);
        },
        child: Icon(Icons.navigation, color: Colors.white,),
        backgroundColor: Color(0xff004A54),
      ),
    );
  }
}
