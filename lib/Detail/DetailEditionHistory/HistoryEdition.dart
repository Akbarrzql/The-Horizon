import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Model/HistoryModel.dart';


class DetailHistoryEdition extends StatefulWidget {
  const DetailHistoryEdition({Key? key, required this.historyModel}) : super(key: key);
  final HistoryModel historyModel;

  @override
  State<DetailHistoryEdition> createState() => _DetailHistoryEditionState();
}

class _DetailHistoryEditionState extends State<DetailHistoryEdition> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff042330),
        elevation: 0.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 1), child: Text('${
            //text to long change to 3 dot
            widget.historyModel.namaSejarah!.length > 30 ? widget.historyModel.namaSejarah!.substring(0, 30) + '...' : widget.historyModel.namaSejarah
            }', style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white))),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xff042330),
            child: Column(
                children: [
                  Container(
                    color: Color(0xff0D4D80),
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Card(
                            margin: EdgeInsets.only(top: 90),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  topRight: Radius.circular(100),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)
                              ),
                            ),
                            color: Color(0xff5FD068),
                          ),
                        ),
                        Container(
                          child: Container(
                            width: 130,
                            height: 170,
                            margin: const EdgeInsets.only(top: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(30), // Image radius
                                child: Image.network('${widget.historyModel.image}', fit: BoxFit.cover, width: 30, height: 30,),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Text('${widget.historyModel.namaSejarah}', style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 10, right: 10,top: 5),
                          child: Text('${widget.historyModel.author}', style: GoogleFonts.poppins(color: Color(0xff5FD068), fontSize: 16, fontWeight: FontWeight.w500),),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10,top: 10),
                          child: Text('${widget.historyModel.extract}', style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,top: 10),
                    child: Text('${
                    //new paragraph after every four . characters and space one line
                    widget.historyModel.desc!.replaceAll(RegExp(r'\.'), '.\n\n')
                    }', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, height: 2),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,bottom: 50, top: 10),
                    child: Text('Terima kasih telah membaca sampai habis', style: GoogleFonts.poppins(color: Color(0xff5FD068), fontSize: 14, fontWeight: FontWeight.normal),),
                  ),
                ]
            )
        ),
      )
    );
  }
}
