import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/controller/article_controller.dart';

class add_article_users extends StatefulWidget {
  const add_article_users({Key? key}) : super(key: key);

  @override
  State<add_article_users> createState() => _add_article_usersState();
}

class _add_article_usersState extends State<add_article_users> {

  final ArticeControler articeControler = Get.put(ArticeControler());


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
                articeControler.addArticle(
                    articeControler.titleController.text,
                    articeControler.subtittleController.text,
                    articeControler.descController.text
                );
                articeControler.titleController.clear();
                articeControler.subtittleController.clear();
                articeControler.descController.clear();
                Navigator.pop(context);
              },
              child: const Text('Add Article'),
            ),
          ],
        ),
      ),
    );
  }


}
