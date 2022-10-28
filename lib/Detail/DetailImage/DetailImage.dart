import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:google_fonts/google_fonts.dart';

class DetailImage extends StatefulWidget {
  const DetailImage({Key? key}) : super(key: key);

  @override
  State<DetailImage> createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage> {
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
      ),
      body: SingleChildScrollView(
         child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 100,
                  child: Text("Congreve Street, Birmingham, showing Christ Church and the Town Hall, By Laurence J Hart", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                ),
                Container(
                    child: widgets.FadeInImage.assetNetwork(placeholder: 'assets/logo.png', image: 'https://images.unsplash.com/photo-1577083288073-40892c0860a4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80', fit: BoxFit.cover)
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text("Deksripsi Gambar", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text("Congreve Street, Birmingham, showing Christ Church and the Town Hall, By Laurence J Hart", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text("Karya Seni", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text("Laurence J Hart", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),

                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text("Tanggal", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text("December 23, 2019", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),

                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text("Sumber", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text("Birmingham Museums Trust", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text("Lisensi", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Text("Unsplash License", style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      )
    );
  }
}
