import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ArticeControler extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtittleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    titleController.dispose();
    subtittleController.dispose();
    descController.dispose();
  }

  void addArticle(String tittle, String subtittle, String desc) async{
    CollectionReference article = firestore.collection('article');

    try {
      String date = DateTime.now().toIso8601String();
      await article.add({
        'tittle': tittle,
        'subtittle': subtittle,
        'desc': desc,
        'date': date,
      });
    } catch (e) {
      print(e);
    }
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
  void editArticle(String docId, String tittle, String subtittle, String desc) async{
    DocumentReference article = firestore.collection('article').doc(docId);

    try{
      await article.update({
        'tittle': tittle,
        'subtittle': subtittle,
        'desc': desc,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot<Object?>> getdata(String docId) async{
    DocumentReference article = firestore.collection('article').doc(docId);
    return article.get();
  }
}