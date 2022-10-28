import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter/material.dart';
import 'package:thehorizonapps/Model/SearchModel.dart';
import 'package:thehorizonapps/Search/DetailSearch.dart';
import 'package:thehorizonapps/Search/SearchPage.dart';

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
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back)),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: myController,
                        onSubmitted: (value) {
                          getSearch(value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(onPressed: (){
                            myController.clear();
                            getSearch(myController).clear();
                          }, icon: Icon(Icons.clear)),
                          hintText: 'Search',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 5, top: 6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
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



