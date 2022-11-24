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
          "CREATE TABLE feed(normalizedtitle TEXT, description TEXT, content_urls TEXT)",
        );
      },
      version: 1,
    );
    isFavorite = await readNyt(widget.articles.normalizedtitle);
    setState(() {});
  }

  //insert
  Future<void> insertNyt(Articles articles, BuildContext context) async {
    final Database db = await database;
    await db.insert(
      'feed',
      articles.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    setState(() {
      isFavorite = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blueGrey,
        margin: EdgeInsets.all(20),
        content: Text('Menambahkan ke favorit'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Urungkan',
          textColor: Colors.white,
          onPressed: (){
            deleteNyt(articles, context);
          },
        ),
      ),
    );
  }

  Future<void> deleteNyt(Articles? articles, BuildContext context) async {
    final db = await database;
    await db.delete(
      'feed',
      where: "normalizedtitle = ?",
      whereArgs: [articles!.normalizedtitle],
    );
    setState(() {
      isFavorite = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blueGrey,
        margin: EdgeInsets.all(20),
        content: Text('Menghapus dari favorit'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Urungkan',
          textColor: Colors.white,
          onPressed: (){
            insertNyt(articles, context);
          },
        ),
      ),
    );
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
      backgroundColor: Color(0xff042330),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Color(0xff042330),
        title: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widgets.Image.asset(
                'assets/newlogosmall.png',
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 1), child: Text('TheHorizon', style: GoogleFonts.imFellGreatPrimerSc(color: Colors.white),)),
            ],
          ),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(onPressed: (){
            isFavorite ? deleteNyt(widget.articles, context) : insertNyt(widget.articles, context);
          }, icon: isFavorite ? Icon(Icons.bookmark_added, color: Color(0xff5FD068),) : Icon(Icons.bookmark_add_outlined, color: Color(0xff5FD068),)),
        ],
      ),
      body: WebView(
        initialUrl: widget.articles.contentUrls,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
