import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/article_users/view_article_page.dart';
import 'package:thehorizonapps/controller/article_controller.dart';

class EditArticle extends StatefulWidget {
  const EditArticle({Key? key, required this.arguments, required this.desc, required this.tittle, required this.subtittle}) : super(key: key);
  final String arguments;
  final String tittle;
  final String subtittle;
  final String desc;

  @override
  State<EditArticle> createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {

  ArticeControler articeControler = Get.put(ArticeControler());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articeControler.titleController.text = widget.tittle;
    articeControler.subtittleController.text = widget.subtittle;
    articeControler.descController.text = widget.desc;
  }

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
        //no back button
        automaticallyImplyLeading: false,
      ),
      //edit article
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: articeControler.titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: articeControler.subtittleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Subtitle',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: articeControler.descController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                articeControler.editArticle(
                    widget.arguments,
                    articeControler.titleController.text,
                    articeControler.subtittleController.text,
                    articeControler.descController.text);
                articeControler.titleController.clear();
                articeControler.subtittleController.clear();
                articeControler.descController.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const view_aritcle()));
              },
              child: const Text('Edit Article'),
            ),
          ],
        ),
      ),
    );
  }
}
