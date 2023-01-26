import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/article_users/view_article_page.dart';
import 'package:thehorizonapps/controller/article_controller.dart';

class EditArticle extends StatefulWidget {
  const EditArticle({Key? key, required this.arguments}) : super(key: key);
  final String arguments;

  @override
  State<EditArticle> createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {

  ArticeControler articeControler = Get.put(ArticeControler());
  var listAllArticle = [].obs;

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
            TextField(
              controller: articeControler.titleController,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              style: const TextStyle(color: Colors.white),
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Tittle',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: articeControler.subtittleController,
              textInputAction: TextInputAction.next,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Subtittle',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: articeControler.descController,
              textInputAction: TextInputAction.done,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'description',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
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
                Navigator.pop(context);
              },
              child: const Text('Edit Article'),
            ),
          ],
        ),
      ),
    );
  }
}
