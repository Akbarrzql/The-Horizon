import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:thehorizonapps/Model/OnThisDayModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/widgets.dart' as widgets;

class DetailOnthisday extends StatefulWidget {
  const DetailOnthisday({Key? key, required this.pages}) : super(key: key);
  final Pages pages;

  @override
  State<DetailOnthisday> createState() => _DetailOnthisdayState();
}

class _DetailOnthisdayState extends State<DetailOnthisday> {

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
      join(await getDatabasesPath(), 'otdDB.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE otd(normalizedtitle TEXT, description TEXT, content_urls TEXT)",
        );
      },
      version: 1,
    );
    isFavorite = await readOtd(widget.pages.normalizedtitle);
    setState(() {});
  }

  //insert
  Future<void> insertOtd(Pages pages, BuildContext context) async {
    final Database db = await database;
    await db.insert(
      'otd',
      pages.toMap(),
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
            deleteOtd(pages, context);
          },
        ),
      ),
    );
  }

  Future<void> deleteOtd(Pages? pages, BuildContext context) async {
    final db = await database;
    await db.delete(
      'otd',
      where: "normalizedtitle = ?",
      whereArgs: [pages!.normalizedtitle],
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
            insertOtd(pages, context);
          },
        ),
      ),
    );
  }

  Future<bool> readOtd(String? normalizedtitle) async {
    final Database db = await database;
    final data = await db.query('otd', where: "normalizedtitle = ?", whereArgs: [normalizedtitle]);
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
        elevation: 0.5,
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
            isFavorite ? deleteOtd(widget.pages, context) : insertOtd(widget.pages, context);
          }, icon: isFavorite ?
          Icon(Icons.bookmark_added, color: Colors.black,) : Icon(Icons.bookmark_add_outlined, color: Colors.black,)),
        ],
      ),
      body: WebView(
        initialUrl: widget.pages.contentUrls,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
