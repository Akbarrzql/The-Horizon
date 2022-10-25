// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.batchcomplete,
    required this.searchModelContinue,
    required this.query,
  });

  String batchcomplete;
  Continue searchModelContinue;
  Query query;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    batchcomplete: json["batchcomplete"],
    searchModelContinue: Continue.fromJson(json["continue"]),
    query: Query.fromJson(json["query"]),
  );

  Map<String, dynamic> toJson() => {
    "batchcomplete": batchcomplete,
    "continue": searchModelContinue.toJson(),
    "query": query.toJson(),
  };
}

class Query {
  Query({
    required this.searchinfo,
    required this.search,
  });

  Searchinfo searchinfo;
  List<Search> search;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    searchinfo: Searchinfo.fromJson(json["searchinfo"]),
    search: List<Search>.from(json["search"].map((x) => Search.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "searchinfo": searchinfo.toJson(),
    "search": List<dynamic>.from(search.map((x) => x.toJson())),
  };
}

class Search {
  Search({
    required this.ns,
    required this.title,
    required this.pageid,
    required this.size,
    required this.wordcount,
    required this.snippet,
    required this.timestamp,
  });

  int ns;
  String title;
  int pageid;
  int size;
  int wordcount;
  String snippet;
  DateTime timestamp;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    ns: json["ns"],
    title: json["title"],
    pageid: json["pageid"],
    size: json["size"],
    wordcount: json["wordcount"],
    snippet: json["snippet"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "ns": ns,
    "title": title,
    "pageid": pageid,
    "size": size,
    "wordcount": wordcount,
    "snippet": snippet,
    "timestamp": timestamp.toIso8601String(),
  };
}

class Searchinfo {
  Searchinfo({
    required this.totalhits,
  });

  int totalhits;

  factory Searchinfo.fromJson(Map<String, dynamic> json) => Searchinfo(
    totalhits: json["totalhits"],
  );

  Map<String, dynamic> toJson() => {
    "totalhits": totalhits,
  };
}

class Continue {
  Continue({
    required this.sroffset,
    required this.continueContinue,
  });

  int sroffset;
  String continueContinue;

  factory Continue.fromJson(Map<String, dynamic> json) => Continue(
    sroffset: json["sroffset"],
    continueContinue: json["continue"],
  );

  Map<String, dynamic> toJson() => {
    "sroffset": sroffset,
    "continue": continueContinue,
  };
}
