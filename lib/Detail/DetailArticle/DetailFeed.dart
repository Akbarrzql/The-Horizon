import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Model/FeedModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart' as widgets;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.articles}) : super(key: key);
  final Articles articles;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

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
      join(await getDatabasesPath(), 'feedDB.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE feed(normalizedtitle TEXT, description TEXT)",
        );
      },
      version: 1,
    );
    isFavorite = await readNyt(widget.articles.normalizedtitle);
    setState(() {});
  }

  //insert
  Future<void> insertNyt(Articles articles) async {
    final Database db = await database;
    await db.insert(
      'feed',
      articles.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    setState(() {
      isFavorite = true;
    });
  }

  Future<void> deleteNyt(Articles? articles) async {
    final db = await database;
    await db.delete(
      'feed',
      where: "normalizedtitle = ?",
      whereArgs: [articles!.normalizedtitle],
    );
    setState(() {
      isFavorite = false;
    });
  }

  Future<bool> readNyt(String? normalizedtitle) async {
    final Database db = await database;
    final data = await db.query('feed', where: "normalizedtitle = ?", whereArgs: [normalizedtitle]);
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
        actions: [
          IconButton(onPressed: (){
            isFavorite ? deleteNyt(widget.articles) : insertNyt(widget.articles);
          }, icon: isFavorite ? Icon(Icons.bookmark_added, color: Colors.black,) : Icon(Icons.bookmark_add_outlined, color: Colors.black,)),
        ],
      ),
      body: WebView(
        initialUrl: widget.articles.contentUrls!.mobile!.page!,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
