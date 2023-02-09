import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailFeed.dart';
import 'package:thehorizonapps/Model/FeedModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart' as widgets;

class articlesave extends StatefulWidget {
  const articlesave({Key? key}) : super(key: key);

  @override
  State<articlesave> createState() => _articlesaveState();
}

class _articlesaveState extends State<articlesave> {

  List<Articles> articles = <Articles>[];
  var database;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

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
        contentUrls: maps[i]['content_urls'],
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
      ),
      body: (RefreshIndicator(
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ) : MediaQuery.of(context).size.width >= 500?

            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.7,
                ),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return InkWell(
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
                    child: Card(
                      elevation: 3,
                      color: Color(0xff042330),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    margin: EdgeInsets.only(top: 10, left: 15),
                                    child: Text(
                                      "${articles[index].normalizedtitle}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    margin:
                                        EdgeInsets.only(left: 15, bottom: 10),
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      "${articles[index].description ?? "Tidak terdapat deskripsi"}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Row(children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Card(
                                        //radius
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        elevation: 1,
                                        color: Color(0xff5FD068),
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            "Sejarah Hari ini",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff042330),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.19,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: IconButton(
                                        color: Colors.red,
                                        //size icon
                                        iconSize: 20,
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          //alert dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Color(0xff042330),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                //width and height of alert dialog
                                                title: Text(
                                                  "Hapus!",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.red)),
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Text(
                                                  "Apakah anda yakin ingin menghapus artikel ini?",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white)),
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Tidak",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteNyt(articles[index]);
                                                      setState(() {
                                                        articles.removeAt(index);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Ya",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ])
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ):ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return InkWell(
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
                    child: Card(
                      elevation: 1,
                      color: Color(0xff042330),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(top: 10, left: 15),
                                    child: Text(
                                      "${articles[index].normalizedtitle}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin:
                                        EdgeInsets.only(left: 15, bottom: 10),
                                    child: Text(
                                      "${articles[index].description ?? "Tidak terdapat deskripsi"}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Row(children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 15, top: 10, bottom: 10),
                                      child: Card(
                                        //radius
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        elevation: 1,
                                        color: Color(0xff5FD068),
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            "Sejarah Hari ini",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff042330),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: IconButton(
                                        color: Colors.red,
                                        //size icon
                                        iconSize: 20,
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          //alert dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Color(0xff042330),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                //width and height of alert dialog
                                                title: Text(
                                                  "Hapus!",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.red)),
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Text(
                                                  "Apakah anda yakin ingin menghapus artikel ini?",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white)),
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Tidak",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteNyt(articles[index]);
                                                      setState(() {
                                                        articles.removeAt(index);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Ya",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ])
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )

      )
      )
      );
  }
}
