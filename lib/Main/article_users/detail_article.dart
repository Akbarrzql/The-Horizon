import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/article_users/edit_article.dart';
import 'package:thehorizonapps/controller/article_controller.dart';

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
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/logo.png'),
              image: NetworkImage(widget.image),
            ),
            Text(widget.title, style: GoogleFonts.imFellGreatPrimerSc(color: Colors.white, fontSize: 30),),
            const SizedBox(height: 10,),
            Text(widget.subtittle, style: GoogleFonts.imFellGreatPrimerSc(color: Colors.white, fontSize: 20),),
            const SizedBox(height: 10,),
            Text(widget.desc, style: GoogleFonts.imFellGreatPrimerSc(color: Colors.white, fontSize: 15),),
          ],
        ),
      ),
    );
  }
}
