import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/article_users/add_article_users_page.dart';
import 'package:thehorizonapps/Main/article_users/detail_article.dart';
import 'package:thehorizonapps/controller/article_controller.dart';
import 'package:thehorizonapps/resposive/resposive.dart';

class view_aritcle extends StatefulWidget {
  const view_aritcle({Key? key}) : super(key: key);

  @override
  State<view_aritcle> createState() => _view_aritcleState();
}

class _view_aritcleState extends State<view_aritcle> {

  ArticeControler articeControler = Get.put(ArticeControler());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    isMobile(BuildContext context) {
      return width < 550;
    }
    return Scaffold(
      backgroundColor: Color(0xff042330),
      appBar: AppBar(
        backgroundColor: Color(0xff042330),
        elevation: 0.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/newlogosmall.png',
              fit: BoxFit.contain,
              height: 50,
              width: 50,
            ),
            Container(
                padding: const EdgeInsets.only(left: 1), child: Text('TheHorizon', style: GoogleFonts.imFellGreatPrimerSc(color: Colors.white),)),
          ],
        ),
        actions: [
          //search button
          IconButton(
            onPressed: () {
              // showSearch(context: context, delegate: Search());
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
        ],
        //no back button
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream : articeControler.getDataStream(),
        builder: (context, snapshot) {
          width = width;
          height = height;
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllArticle = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context) ? 1 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: isMobile(context) ? 0.9 : 0.9,
              ),
              itemCount: listAllArticle.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailArticle(
                      id: listAllArticle[index].id,
                      title: (listAllArticle[index].data() as Map<String, dynamic>)['tittle'],
                      subtittle: (listAllArticle[index].data() as Map<String, dynamic>)['subtittle'],
                      desc: (listAllArticle[index].data() as Map<String, dynamic>)['desc'],
                      image: (listAllArticle[index].data() as Map<String, dynamic>)['image'],
                    )));
                  },
                  child: Card(
                    elevation: 2,
                    color: Color(0xff042330),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //image
                                Container(
                                  height: 200,
                                  width: isLandScape(context) ? width/2.074 : width/1.024,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/loading.gif',
                                    image: (listAllArticle[index].data() as Map<String, dynamic>)['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 330,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "${(listAllArticle[index].data() as Map<String, dynamic>)['tittle'] ?? 'Tidak ada Jedul'}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 330,
                                  height: isLandScape(context) ? 49  : 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "${
                                    (listAllArticle[index].data() as Map<String, dynamic>)['subtittle'] != null
                                        ? (listAllArticle[index].data() as Map<String, dynamic>)['subtittle'].toString().length > 100
                                        ? (listAllArticle[index].data() as Map<String, dynamic>)['subtittle'].toString().substring(0, 85) + '...'
                                        : (listAllArticle[index].data() as Map<String, dynamic>)['subtittle']
                                        : 'Tidak ada Subtittle'
                                    }",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                        child: Card(
                                          //radius
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          elevation: 1,
                                          color: Color(0xff5FD068),
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              "Artikel",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff042330),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 200, top: 10, bottom: 10),
                                          child: Container(
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
                                                      backgroundColor: Color(0xff042330),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20.0),
                                                      ),
                                                      //width and height of alert dialog
                                                      title: Text("Hapus!", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16, color: Colors.red)), textAlign: TextAlign.center,),
                                                      content: Text("Apakah anda yakin ingin menhapus artikel ini?", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14, color: Colors.white)),textAlign: TextAlign.center,),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text("Tidak", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14, color: Colors.white)),),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            articeControler.deteleArticle(listAllArticle[index].id);
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text("Ya", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14, color: Colors.white)),),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          )

                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
          } else {
            return Center(
              child: Image.asset('assets/loading-plane.gif', width: 200, height: 200, fit: BoxFit.cover,),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => const add_article_users()),
          );
        },
        child: const Icon(Icons.add_comment, color: Colors.white,),
        backgroundColor: Color(0xff5FD068),
      ),
    );

    //tablet view
  }
}
