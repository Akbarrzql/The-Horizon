import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Model/SearchModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/widgets.dart' as widgets;

class DetailSearch extends StatefulWidget {
  const DetailSearch({Key? key, required this.searchModel, required this.index}) : super(key: key);
  final SearchModel? searchModel;
  final int index;

  @override
  State<DetailSearch> createState() => _DetailSearchState();
}

class _DetailSearchState extends State<DetailSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff042330),
      appBar: AppBar(
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
      body: WebView(
        initialUrl: "https://id.wikipedia.org/wiki/${widget.searchModel!.query.search[widget.index].title.toString()}",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}