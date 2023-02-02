import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thehorizonapps/controller/article_controller.dart';

class add_article_users extends StatefulWidget {
  const add_article_users({Key? key}) : super(key: key);

  @override
  State<add_article_users> createState() => _add_article_usersState();
}

class _add_article_usersState extends State<add_article_users> {

  final ArticeControler articeControler = Get.put(ArticeControler());
  String imageName = "";
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articeControler.titleController.text = "";
    articeControler.subtittleController.text = "";
    articeControler.descController.text = "";
  }

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = image;
    });
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF3F3F3)),
                      child: GestureDetector(
                          onTap: (){
                            getImage();
                          },
                          child: image == null ? const Icon(Icons.add_a_photo, size: 50, color: Colors.grey,) : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    SizedBox(height: 20,),
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
                      minLines: 5,
                      maxLines: 15,
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
                            articeControler.descController.text,
                            image!.path
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
            ],
          ),
        ),
      ),
    );
  }


}
