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
      body: Container(
        width: 500,
        height: 500,
        child: Row(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
                    height: 130,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SaveOnThisDay()));
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
                        color: Color(0xffA5C9CA),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 35, left: 20),
                                  child: Text('Sejarah Hari ini', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xff2C3333)),),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5, left: 20),
                                  child: Text('Tersimpan dari Sejarah Hari ini', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff767676)),),
                                ),
                                SizedBox(width: 50,),
                              ],
                            ),
                            Container(
                              //image with border radius
                              padding: const EdgeInsets.only(right: 5),
                              margin: const EdgeInsets.only(top: 10, left: 35),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(5),
                                ),
                                child: Image.asset('assets/tersimpansejarah.jpg', width: 100, height: 100, fit: BoxFit.cover,),),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
                    height: 130,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Pagesave()));
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
                        color: Color(0xffA5C9CA),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 35, left: 20),
                                  child: Text('Bacaan teratas', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xff2C3333)),),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5, left: 20),
                                  child:  Text('Tersimpan dari bacaan teratas',style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff767676)),),
                                ),
                                SizedBox(width: 50,),
                              ],
                            ),
                            Container(
                              //image with border radius
                              padding: const EdgeInsets.only(right: 5),
                              margin: const EdgeInsets.only(top: 10, left: 30),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(5),
                                ),
                                child: Image.asset('assets/tersimpanteratas.jpg', width: 100, height: 100, fit: BoxFit.cover,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
                    height: 130,
                    width: 350,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SaveRandom()));
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
                        color: Color(0xffA5C9CA),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 35, left: 20),
                                  child: Text('Artikel Acak', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xff2C3333)),),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5, left: 20),
                                  child:  Text('Tersimpan dari Artikel Acak', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff767676)),),
                                ),
                                SizedBox(width: 50,),
                              ],
                            ),
                            Container(
                              //image with border radius
                              padding: const EdgeInsets.only(right: 5),
                              margin: const EdgeInsets.only(top: 10, left: 52),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(5),
                                ),
                                child: Image.asset('assets/artikelacak.jpg', width: 100, height: 100, fit: BoxFit.cover,),),
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
    );
  }
}
