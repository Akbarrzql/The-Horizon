import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: <Widget>[
                    Text("Hari ini di TheHorizon", style: GoogleFonts.poppins(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                  ]
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: <Widget>[
                      Text("Lihat halaman utama", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 18), fontWeight: FontWeight.normal),),
                      Icon(Icons.arrow_forward, color: Color(0xff004A54),)
                    ]
                  ),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                )
              ),
              Container(
                  margin: const EdgeInsets.only(top: 15, left: 15),
                child: Column(
                  children: [
                    Row(
                        children: <Widget>[
                          Text("Hari ini", style: GoogleFonts.poppins(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
                        ]
                    ),
                    Row(
                        children: <Widget>[
                          Text("Bacaan Teratas", style: GoogleFonts.poppins(color: Color(0xff004A54), fontSize: 24, fontWeight: FontWeight.bold),),
                        ]
                    ),
                  ],
                )
              ),
              Container(
                child: SizedBox(
                  width: 350,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                           child: Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                    //text circle avatar
                                    child: Image.asset(
                                      'assets/one.png',
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Liga Champions UEFA", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                                                Text("Liga Champions Eropa", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20), // Image border
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(30), // Image radius
                                          child: Image.asset('assets/logo.png', fit: BoxFit.cover, width: 30, height: 30,),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
                        ),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                    //text circle avatar
                                    child: Image.asset(
                                      'assets/two.png',
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Liga Champions UEFA", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                                                Text("Liga Champions Eropa", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20), // Image border
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(30), // Image radius
                                          child: Image.asset('assets/logo.png', fit: BoxFit.cover, width: 30, height: 30,),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
                        ),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                    //text circle avatar
                                    child: Image.asset(
                                      'assets/three.png',
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Liga Champions UEFA", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                                                Text("Liga Champions Eropa", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20), // Image border
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(30), // Image radius
                                          child: Image.asset('assets/logo.png', fit: BoxFit.cover, width: 30, height: 30,),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
                        ),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                    //text circle avatar
                                    child: Image.asset(
                                      'assets/four.png',
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Liga Champions UEFA", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                                                Text("Liga Champions Eropa", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20), // Image border
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(30), // Image radius
                                          child: Image.asset('assets/logo.png', fit: BoxFit.cover, width: 30, height: 30,),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
                        ),
                        InkWell(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                                    //text circle avatar
                                    child: Image.asset(
                                      'assets/five.png',
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Liga Champions UEFA", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                                                Text("Liga Champions Eropa", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20), // Image border
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(30), // Image radius
                                          child: Image.asset('assets/logo.png', fit: BoxFit.cover, width: 30, height: 30,),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
                        ),
                      ]
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                              children: <Widget>[
                                Text("Lebih banyak bacaan tertas", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 18), fontWeight: FontWeight.w600),),
                                Icon(Icons.arrow_forward, color: Color(0xff004A54),)
                              ]
                          ),
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top:50, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gambar Pilihan", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 24), fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: 330,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                  width: 300,
                                  child: Column(
                                    children: [
                                      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquet ipsum id mi porta volutpat. Donec convallis velit id maximus ornare. Mauris et velit fringilla ", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w600),),
                                    ],
                                  )
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff004A54),
                                      onPrimary: Colors.white,
                                    ),
                                    onPressed: () {
                                      // Respond to button press
                                    },
                                    icon: Icon(Icons.file_download_outlined, size: 18),
                                    label: Text("UNDUH"),
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff004A54),
                                      onPrimary: Colors.white,
                                    ),
                                    onPressed: () {
                                      // Respond to button press
                                    },
                                    icon: Icon(Icons.share, size: 18),
                                    label: Text("BAGIKAN"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top:50, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Artikel Acak", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 24), fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: 330,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Lorem ipsum dolor sit amet", style: GoogleFonts.poppins(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),),
                                      Divider(
                                        color: Colors.grey,
                                        height: 20,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 200,
                                      ),
                                      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquet ipsum id mi porta volutpat. Donec convallis velit id maximus ornare. Mauris et velit fringilla ", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),),
                                    ],
                                  )
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
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Row(
                              children: <Widget>[
                                Text("Artikel acak lebih banyak", style: GoogleFonts.poppins(color: Color(0xff004A54), textStyle: TextStyle(fontSize: 18), fontWeight: FontWeight.w600),),
                                Icon(Icons.arrow_forward, color: Color(0xff004A54),)
                              ]
                          ),
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
