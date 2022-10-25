import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailFeed.dart';
import 'package:thehorizonapps/Model/FeedModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Pagesave extends StatefulWidget {
  const Pagesave({Key? key}) : super(key: key);

  @override
  State<Pagesave> createState() => _PagesaveState();
}

class _PagesaveState extends State<Pagesave> {

  List<Articles> articles = <Articles>[];
  var database;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

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
    getResults().then((value) {
      setState(() {
        articles = value;
      });
    });
  }

  Future<List<Articles>> getResults() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('feed');
    return List.generate(maps.length, (i) {
      return Articles(
        normalizedtitle: maps[i]['normalizedtitle'],
        description: maps[i]['description'],
      );
    });
  }

  Future<void> deleteNyt(Articles articles) async {
    final db = await database;
    await db.delete(
      'feed',
      where: "normalizedtitle = ?",
      whereArgs: [articles.normalizedtitle],
    );
  }


  Future<dynamic> _refresh() {
    return initDB();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDB();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState!.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (
          RefreshIndicator(
        onRefresh: _refresh,
        key: _refreshIndicatorKey,
        child: articles.length == 0
            ? ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    child: Center(
                      child: Text(
                        "Tidak ada article yang disimpan",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ) : ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text("${articles[index].normalizedtitle}"),
                subtitle: Text("${articles[index].description}"),
                trailing: IconButton(
                  onPressed: () {
                    deleteNyt(articles[index]);
                    setState(() {
                      articles.removeAt(index);
                    });
                  },
                  icon: Icon(Icons.delete),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        articles: articles[index],
                      ),
                    ),
                  ).then((value) => initDB());
                },
              ),
            );
          },
        ),
      )
      ),
    );
  }
}
