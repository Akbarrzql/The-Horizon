import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/article_users/edit_article.dart';
import 'package:thehorizonapps/controller/article_controller.dart';
import 'package:thehorizonapps/resposive/resposive.dart';

class DetailArticle extends StatefulWidget {
  const DetailArticle({Key? key, required this.title, required this.subtittle, required this.desc, required this.image, required this.id}) : super(key: key);
  final String title;
  final String subtittle;
  final String desc;
  final String image;
  final String id;

  @override
  State<DetailArticle> createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticle> {

  ArticeControler articeControler = Get.put(ArticeControler());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff042330),
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditArticle(
                arguments: widget.id,
                tittle: widget.title,
                subtittle: widget.subtittle,
                desc: widget.desc,
                image: widget.image,
              )));
            },
            icon: const Icon(Icons.edit),
            color: Colors.white,
          )
        ],
        //no back button
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xff042330),
            child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          child: Container(
                            //width if smartphone vertical else horizontal
                            width: isLandScape(context) ? width : width,
                            height: MediaQuery.of(context).orientation == Orientation.portrait ? 170 : 350,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(30), // Image radius
                                child: Image.network(widget.image, fit: BoxFit.cover,),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Text(widget.title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 10, right: 10,top: 5),
                          child: Text(widget.subtittle, style: GoogleFonts.poppins(color: Color(0xff5FD068), fontSize: 16, fontWeight: FontWeight.w500),),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,top: 10),
                    child: Text(widget.desc, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, height: 2),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,bottom: 50, top: 10),
                    child: Text('Terima kasih telah membaca sampai habis', style: GoogleFonts.poppins(color: Color(0xff5FD068), fontSize: 14, fontWeight: FontWeight.normal),),
                  ),
                ]
            )
        ),
      )
    );
  }
}
