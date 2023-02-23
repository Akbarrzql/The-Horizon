import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailRandom.dart';
import 'package:thehorizonapps/Model/RandomModel.dart';

class SaveRandom extends StatefulWidget {
  const SaveRandom({Key? key}) : super(key: key);

  @override
  State<SaveRandom> createState() => _SaveRandomState();
}

class _SaveRandomState extends State<SaveRandom> {
  List<RandomModel> randomModel = <RandomModel>[];
  var database;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

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
    getResults().then((value) {
      setState(() {
        randomModel = value;
      });
    });
  }

  Future<List<RandomModel>> getResults() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('random');
    return List.generate(maps.length, (i) {
      return RandomModel(
        title: maps[i]['title'],
        description: maps[i]['description'],
        linkurl: maps[i]['linkurl'],
      );
    });
  }

  Future<void> deleteNyt(RandomModel randomModel) async {
    final db = await database;
    await db.delete(
      'random',
      where: "title = ?",
      whereArgs: [randomModel.title],
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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState!.show());
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
                Image.asset(
                  'assets/newlogosmall.png',
                  fit: BoxFit.contain,
                  height: 50,
                  width: 50,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 1),
                    child: Text(
                      'TheHorizon',
                      style:
                          GoogleFonts.imFellGreatPrimerSc(color: Colors.white),
                    )),
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
            child: randomModel.length == 0
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                  )
                : MediaQuery.of(context).size.width >= 500
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.7,
                        ),
                        itemCount: randomModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailArticleRandom(
                                    randomModel: randomModel[index],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            margin: EdgeInsets.only(
                                                top: 10, left: 15),
                                            child: Text(
                                              "${randomModel[index].title}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            margin: EdgeInsets.only(
                                                left: 15, bottom: 10),
                                            child: Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              "${randomModel[index].description ?? "Tidak terdapat deskripsi"}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Row(children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Card(
                                                //radius
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                elevation: 1,
                                                color: Color(0xff5FD068),
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text(
                                                    "Sejarah Hari ini",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff042330),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Spacer(),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
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
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Color(0xff042330),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        //width and height of alert dialog
                                                        title: Text(
                                                          "Hapus!",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .red)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        content: Text(
                                                          "Apakah anda yakin ingin menghapus artikel ini?",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "Tidak",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              deleteNyt(
                                                                  randomModel[
                                                                      index]);
                                                              setState(() {
                                                                randomModel
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "Ya",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          14,
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
                    : ListView.builder(
                        itemCount: randomModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailArticleRandom(
                                    randomModel: randomModel[index],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            margin: EdgeInsets.only(
                                                top: 10, left: 15),
                                            child: Text(
                                              "${randomModel[index].title}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            margin: EdgeInsets.only(
                                                left: 15, bottom: 10),
                                            child: Text(
                                              "${randomModel[index].description ?? "Tidak terdapat deskripsi"}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Row(children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Card(
                                                //radius
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                elevation: 1,
                                                color: Color(0xff5FD068),
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text(
                                                    "Sejarah Hari ini",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff042330),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Spacer(),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
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
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Color(0xff042330),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        //width and height of alert dialog
                                                        title: Text(
                                                          "Hapus!",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .red)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        content: Text(
                                                          "Apakah anda yakin ingin menghapus artikel ini?",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "Tidak",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              deleteNyt(
                                                                  randomModel[
                                                                      index]);
                                                              setState(() {
                                                                randomModel
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "Ya",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          14,
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
                      ))));
  }
}
