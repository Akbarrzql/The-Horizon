import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thehorizonapps/Model/RandomModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:path/path.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailArticleRandom extends StatefulWidget {
  const DetailArticleRandom({Key? key, required this.randomModel}) : super(key: key);
  final RandomModel randomModel;

  @override
  State<DetailArticleRandom> createState() => _DetailArticleRandomState();
}

class _DetailArticleRandomState extends State<DetailArticleRandom> {

  var database;
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDB();
  }

  Future initDB() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'randomDB.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE random(title TEXT, description TEXT, linkurl TEXT)",
        );
      },
      version: 1,
    );
    isFavorite = await readRandom(widget.randomModel.title);
    setState(() {});
  }

  //insert
  Future<void> insertRandom(RandomModel randomModel) async {
    final Database db = await database;
    await db.insert(
      'random',
      randomModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    setState(() {
      isFavorite = true;
    });
  }

  Future<void> deleteRandom(RandomModel? randomModel) async {
    final db = await database;
    await db.delete(
      'random',
      where: "title = ?",
      whereArgs: [randomModel?.title],
    );
    setState(() {
      isFavorite = false;
    });
  }

  Future<bool> readRandom(String? title) async {
    final Database db = await database;
    final data = await db.query('random', where: "title = ?", whereArgs: [title]);
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
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
      //web view for detail article
      body: WebView(
        initialUrl: widget.randomModel.linkurl.toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
