import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter/material.dart';
import 'package:thehorizonapps/Model/SearchModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  SearchModel? searchModel;
  bool isLoading = false;
  getSearch(searchQuery) async{
    setState(() {
      isLoading = false;
    });
    final responseSearch = await http.get(Uri.parse('https://id.wikipedia.org/w/api.php?action=query&list=search&prop=info&inprop=url&utf8=&format=json&origin=*&srlimit=20&srsearch=${searchQuery}'));
    searchModel = SearchModel.fromJson(jsonDecode(responseSearch.body.toString()));
    setState(() {
      isLoading = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: myController,
                      onSubmitted: (value) {
                        getSearch(value);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        getSearch(myController).clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ],
              ),
              ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(0),
                padding: EdgeInsets.all(0.0),
                child: isLoading ? searchModel!.query.search.isEmpty ? const Center(child: Text('No Data'),) : ListView.builder(
                  itemCount: searchModel!.query.search.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSearch(searchModel: searchModel, index: index,)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(searchModel!.query.search[index].title.toString(), style: GoogleFonts.poppins(fontSize: 20),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    );
                  },
                ) : Center(
                  child: widgets.Image.asset(
                    'assets/search2.gif',
                    fit: BoxFit.contain,
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
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
      body: WebView(
        initialUrl: "https://id.wikipedia.org/wiki/${widget.searchModel!.query.search[widget.index].title.toString()}",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}


