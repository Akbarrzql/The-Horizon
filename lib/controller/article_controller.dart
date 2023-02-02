import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ArticeControler extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtittleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String imageName = "";
  XFile? image;
  var loadingImage = true.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    titleController.dispose();
    subtittleController.dispose();
    descController.dispose();
  }


  void addArticle(String tittle, String subtittle, String desc, String image) async{
    CollectionReference article = firestore.collection('article');
    String uploadImage = DateTime.now().millisecondsSinceEpoch.toString() + ".png";
    Reference ref = _storage.ref().child("article").child(uploadImage);
    UploadTask uploadTask = ref.putFile(File(image));
    uploadTask.snapshotEvents.listen((event){
      print("${event.bytesTransferred}\t${event.totalBytes}");
    }, onError: (e){
      print("Error: $e");
    });
    uploadTask.whenComplete(() async{
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
        String date = DateTime.now().toIso8601String();
        article.add({
          "tittle": tittle,
          "subtittle": subtittle,
          "desc": desc,
          "image": uploadPath,
          "date": date,
        }).then((value) => print("Uploaded"));
    });
  }

  Stream<QuerySnapshot<Object?>> getDataStream() {
    CollectionReference article = firestore.collection('article');

    return article.orderBy("date", descending: true).snapshots();
  }

  void deteleArticle(String docId) async{
    DocumentReference article = firestore.collection('article').doc(docId);

    try{
      await article.delete();
    } catch (e) {
      print(e);
    }
  }

  //edit article
  void editArticle(String docId, String tittle, String subtittle, String desc, String Image) async{
    DocumentReference article = firestore.collection('article').doc(docId);
    String uploadImage = DateTime.now().millisecondsSinceEpoch.toString() + ".png";
    Reference ref = _storage.ref().child("article").child(uploadImage);
    UploadTask uploadTask = ref.putFile(File(Image));
    uploadTask.snapshotEvents.listen((event){
      print(event.bytesTransferred.toString() + "\t" + event.totalBytes.toString());
    }, onError: (e){
      print("Error: $e");
    });
    uploadTask.whenComplete(() async{
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
        String date = DateTime.now().toIso8601String();
        await article.update({
          "tittle": tittle,
          "subtittle": subtittle,
          "desc": desc,
          "image": uploadPath,
          "date": date,
        }).then((value) => print("Uploaded"));
    });
  }

  Future<DocumentSnapshot<Object?>> getdata(String docId) async{
    DocumentReference article = firestore.collection('article').doc(docId);
    return article.get();
  }

}