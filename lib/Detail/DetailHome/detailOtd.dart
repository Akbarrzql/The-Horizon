import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:thehorizonapps/Detail/DetailArticle/DetailOtd.dart';
import 'package:thehorizonapps/Model/OnThisDayModel.dart';

import 'package:thehorizonapps/controller/controller_api.dart';

class DetailOtd extends StatefulWidget {
  const DetailOtd({Key? key}) : super(key: key);

  @override
  State<DetailOtd> createState() => _DetailOtdState();
}

class _DetailOtdState extends State<DetailOtd> {

  bool loadingOtd = true;
  bool isVisiblemage =  true;
  final ScrollController _scrollController = ScrollController();
  DataController dataController = Get.put(DataController());
  //get mount
  String mount = DateTime.now().month.toString();
  //get day
  String day = DateTime.now().day.toString().padLeft(2, '0');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataController.getApi(mount, day);
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff042330),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Color(0xff042330),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(2023, 1, 1),
                        lastDate: DateTime.utc(2023, 12, 31),
                        helpText: 'Hari ini dalam sejarah',
                        cancelText: 'Batal',
                        confirmText: 'Pilih',
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Color(0xff042330),
                              ),
                              buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then((value) {
                        dataController.getApi(value!.month.toString(), value.day.toString().padLeft(2, '0'));
                        setState(() {
                          mount = value.month.toString();
                          day = value.day.toString().padLeft(2, '0');
                        });
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${day} ${
                              mount == '1' ? 'Januari' :
                              mount == '2' ? 'Februari' :
                              mount == '3' ? 'Maret' :
                              mount == '4' ? 'April' :
                              mount == '5' ? 'Mei' :
                              mount == '6' ? 'Juni' :
                              mount == '7' ? 'Juli' :
                              mount == '8' ? 'Agustus' :
                              mount == '9' ? 'September' :
                              mount == '10' ? 'Oktober' :
                              mount == '11' ? 'November' :
                              mount == '12' ? 'Desember' : ''
                          }',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    ),
                ],
              )
            ],
          ),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Obx(()=> dataController.isDataLoading.value ? Center(
        child: Image.asset('assets/loading-plane.gif', width: 200, height: 200, fit: BoxFit.cover,) ,)
      : widthScreen < 550 ? ListView.builder(
        controller: _scrollController,
        itemCount:  dataController.onThisDayModel?.events?.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5, top: 10),
                          width: 40,
                          height: 40,
                          child: Lottie.asset('assets/circle.json', width: 300, height: 300, fit: BoxFit.cover,),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${ dataController.onThisDayModel?.events![index].year ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Color(0xff5FD068), fontSize: 20, fontWeight: FontWeight.w600),),
                            ],
                          ),
                        )
                      ]
                  ),
                ),
                Container(
                  width: 350,
                  margin: EdgeInsets.only(left: 17, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            VerticalDivider(
                              color: Color(0xffCBCBCB),
                              thickness: 1,
                            ),
                            Container(
                              width: 320,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${ dataController.onThisDayModel?.events![index].text ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOnthisday(
                                              pages:  dataController.onThisDayModel!.events![index].pages![0],
                                            )));
                                          },
                                          child: Card(
                                            color: Color(0xff042330),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              side: BorderSide(color: Colors.white),
                                            ),
                                            child: Container(
                                              width: 330,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    margin: const EdgeInsets.only(bottom: 10),
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                        child: FadeInImage.assetNetwork(placeholder: 'assets/logo.png', image: dataController.onThisDayModel?.events![index].pages![0].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png", width: 330, height: 230, fit: BoxFit.cover,)
                                                    ),
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
                                                                Text("${ dataController.onThisDayModel?.events![index].pages![0].normalizedtitle ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),),
                                                                const Divider(
                                                                  color: Colors.grey,
                                                                  height: 20,
                                                                  thickness: 1,
                                                                  indent: 0,
                                                                  endIndent: 200,
                                                                ),
                                                                Text("${ dataController.onThisDayModel?.events![index].pages![0].description ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },

      ): ListView.builder(
        controller: _scrollController,
        itemCount:  dataController.onThisDayModel?.events?.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5, top: 10),
                          width: 40,
                          height: 40,
                          child: Lottie.asset('assets/circle.json', width: 300, height: 300, fit: BoxFit.cover,),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${ dataController.onThisDayModel?.events![index].year ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Color(0xff5FD068), fontSize: 20, fontWeight: FontWeight.w600),),
                            ],
                          ),
                        )
                      ]
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 17, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            VerticalDivider(
                              color: Color(0xffCBCBCB),
                              thickness: 1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 80,
                              height: MediaQuery.of(context).size.height / 0.95,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${ dataController.onThisDayModel?.events![index].text ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOnthisday(
                                              pages:  dataController.onThisDayModel!.events![index].pages![0],
                                            )));
                                          },
                                          child: Card(
                                            color: Color(0xff042330),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              side: BorderSide(color: Colors.white),
                                            ),
                                            child: Container(
                                              width: 330,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    margin: const EdgeInsets.only(bottom: 10),
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                        child: FadeInImage.assetNetwork(placeholder: 'assets/logo.png', image: dataController.onThisDayModel?.events![index].pages![0].thumbnail?.source ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png", width: 330, height: 230, fit: BoxFit.cover,)
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                            margin: const EdgeInsets.only(left: 10, right: 10),
                                                            width: 300,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("${ dataController.onThisDayModel?.events![index].pages![0].normalizedtitle ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),),
                                                                const Divider(
                                                                  color: Colors.grey,
                                                                  height: 20,
                                                                  thickness: 1,
                                                                  indent: 0,
                                                                  endIndent: 200,
                                                                ),
                                                                Text("${ dataController.onThisDayModel?.events![index].pages![0].description ?? "Berada di masa lalu"}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },

      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn);
        },
        child: Icon(Icons.navigation, color: Colors.white,),
        backgroundColor: Color(0xff5FD068),
      ),
    );
  }
}
