import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/PageSave/KategoriSave/saveFeed.dart';
import 'package:thehorizonapps/Main/PageSave/KategoriSave/saveOtd.dart';
import 'package:thehorizonapps/Main/PageSave/KategoriSave/saveRandom.dart';

class PageSaveKategori extends StatefulWidget {
  const PageSaveKategori({Key? key}) : super(key: key);

  @override
  State<PageSaveKategori> createState() => _PageSaveKategoriState();
}

class _PageSaveKategoriState extends State<PageSaveKategori> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff042330),
        body: SingleChildScrollView(
          child: Container(
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 130,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SaveOnThisDay()));
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            color: Color(0xff5FD068),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Sejarah Hari ini',
                                            style: GoogleFonts.poppins(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'Tersimpan dari Sejarah Hari ini',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 130),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          child: Image.asset(
                                            'assets/tersimpansejarah.jpg',
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 130,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => articlesave()));
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            color: Color(0xff5FD068),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Bacaan Teratas',
                                            style: GoogleFonts.poppins(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'Tersimpan dari Bacaan Teratas',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 130),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          child: Image.asset(
                                            'assets/tersimpanteratas.jpg',
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 130,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SaveRandom()));
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            color: Color(0xff5FD068),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Artikel Acak',
                                            style: GoogleFonts.poppins(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'Tersimpan dari Artikel Acak',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 130),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          child: Image.asset(
                                            'assets/artikelacak.jpg',
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
