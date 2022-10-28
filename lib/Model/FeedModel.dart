class FeedModel {
  Mostread? mostread;
  Thumbnail? imagethumnail;

  FeedModel({this.mostread, this.imagethumnail});

  FeedModel.fromJson(Map<String, dynamic> json) {
    mostread = json['mostread'] != null
        ? new Mostread.fromJson(json['mostread'])
        : null;
    imagethumnail =
    json['image'] != null ? new Thumbnail.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mostread != null) {
      data['mostread'] = this.mostread!.toJson();
    }
    if (this.imagethumnail != null) {
      data['image'] = this.imagethumnail!.toJson();
    }
    return data;
  }
}

class Mostread {
  String? date;
  List<Articles>? articles;

  Mostread({this.date, this.articles});

  Mostread.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  int? views;
  int? rank;
  List<ViewHistory>? viewHistory;
  String? type;
  String? title;
  String? displaytitle;
  Namespace? namespace;
  String? wikibaseItem;
  Titles? titles;
  int? pageid;
  Thumbnail? thumbnail;
  Thumbnail? originalimage;
  String? lang;
  String? dir;
  String? revision;
  String? tid;
  String? timestamp;
  String? description;
  String? descriptionSource;
  String? contentUrls;
  String? extract;
  String? extractHtml;
  String? normalizedtitle;
  String? source;
  int? width;
  int? height;


  Articles(
      {this.views,
        this.rank,
        this.viewHistory,
        this.type,
        this.title,
        this.displaytitle,
        this.namespace,
        this.wikibaseItem,
        this.titles,
        this.pageid,
        this.thumbnail,
        this.originalimage,
        this.lang,
        this.dir,
        this.revision,
        this.tid,
        this.timestamp,
        this.description,
        this.descriptionSource,
        this.contentUrls,
        this.extract,
        this.extractHtml,
        this.normalizedtitle,
        this.source,
        this.width,
        this.height});

  Articles.fromJson(Map<String, dynamic> json) {
    views = json['views'];
    rank = json['rank'];
    if (json['view_history'] != null) {
      viewHistory = <ViewHistory>[];
      json['view_history'].forEach((v) {
        viewHistory!.add(new ViewHistory.fromJson(v));
      });
    }
    type = json['type'];
    title = json['title'];
    displaytitle = json['displaytitle'];
    namespace = json['namespace'] != null
        ? new Namespace.fromJson(json['namespace'])
        : null;
    wikibaseItem = json['wikibase_item'];
    titles =
    json['titles'] != null ? new Titles.fromJson(json['titles']) : null;
    pageid = json['pageid'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    originalimage = json['originalimage'] != null
        ? new Thumbnail.fromJson(json['originalimage'])
        : null;
    lang = json['lang'];
    dir = json['dir'];
    revision = json['revision'];
    tid = json['tid'];
    timestamp = json['timestamp'];
    description = json['description'];
    descriptionSource = json['description_source'];
    contentUrls = json['content_urls']['mobile']['page'];
    extract = json['extract'];
    extractHtml = json['extract_html'];
    normalizedtitle = json['normalizedtitle'];
    source = json['source'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['views'] = this.views;
    data['rank'] = this.rank;
    if (this.viewHistory != null) {
      data['view_history'] = this.viewHistory!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['title'] = this.title;
    data['displaytitle'] = this.displaytitle;
    if (this.namespace != null) {
      data['namespace'] = this.namespace!.toJson();
    }
    data['wikibase_item'] = this.wikibaseItem;
    if (this.titles != null) {
      data['titles'] = this.titles!.toJson();
    }
    data['pageid'] = this.pageid;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.originalimage != null) {
      data['originalimage'] = this.originalimage!.toJson();
    }
    data['lang'] = this.lang;
    data['dir'] = this.dir;
    data['revision'] = this.revision;
    data['tid'] = this.tid;
    data['timestamp'] = this.timestamp;
    data['description'] = this.description;
    data['description_source'] = this.descriptionSource;
    data['content_urls']['mobile']['page'] = this.contentUrls;
    data['extract'] = this.extract;
    data['extract_html'] = this.extractHtml;
    data['normalizedtitle'] = this.normalizedtitle;
    data['source'] = this.source;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }

  Map<String, dynamic> toMap(){
    return {
      'normalizedtitle': normalizedtitle,
      'description': description,
      'content_urls': contentUrls,
    };
  }
}

class ViewHistory {
  String? date;
  int? views;

  ViewHistory({this.date, this.views});

  ViewHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['views'] = this.views;
    return data;
  }
}

class Namespace {
  int? id;
  String? text;

  Namespace({this.id, this.text});

  Namespace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }
}

class Titles {
  String? canonical;
  String? normalized;
  String? display;

  Titles({this.canonical, this.normalized, this.display});

  Titles.fromJson(Map<String, dynamic> json) {
    canonical = json['canonical'];
    normalized = json['normalized'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canonical'] = this.canonical;
    data['normalized'] = this.normalized;
    data['display'] = this.display;
    return data;
  }
}

class Thumbnail {
  String? source;
  int? width;
  int? height;

  Thumbnail({this.source, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class ContentUrls {
  Desktop? desktop;
  Desktop? mobile;

  ContentUrls({this.desktop, this.mobile});

  ContentUrls.fromJson(Map<String, dynamic> json) {
    desktop =
    json['desktop'] != null ? new Desktop.fromJson(json['desktop']) : null;
    mobile =
    json['mobile'] != null ? new Desktop.fromJson(json['mobile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.desktop != null) {
      data['desktop'] = this.desktop!.toJson();
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile!.toJson();
    }
    return data;
  }

}

class Desktop {
  String? page;
  String? revisions;
  String? edit;
  String? talk;

  Desktop({this.page, this.revisions, this.edit, this.talk});

  Desktop.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    revisions = json['revisions'];
    edit = json['edit'];
    talk = json['talk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['revisions'] = this.revisions;
    data['edit'] = this.edit;
    data['talk'] = this.talk;
    return data;
  }

  Map<String, dynamic> toMap(){
    return {
      'page': page,
      'revisions': revisions,
      'edit': edit,
      'talk': talk,
    };
  }

}

class Image {
  String? title;
  Thumbnail? thumbnail;
  Thumbnail? image;
  String? filePage;
  Artist? artist;
  Credit? credit;
  License? license;
  Description? description;
  String? wbEntityId;
  Structured? structured;

  Image(
      {this.title,
        this.thumbnail,
        this.image,
        this.filePage,
        this.artist,
        this.credit,
        this.license,
        this.description,
        this.wbEntityId,
        this.structured});

  Image.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    image =
    json['image'] != null ? new Thumbnail.fromJson(json['image']) : null;
    filePage = json['file_page'];
    artist =
    json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    credit =
    json['credit'] != null ? new Credit.fromJson(json['credit']) : null;
    license =
    json['license'] != null ? new License.fromJson(json['license']) : null;
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    wbEntityId = json['wb_entity_id'];
    structured = json['structured'] != null
        ? new Structured.fromJson(json['structured'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['file_page'] = this.filePage;
    if (this.artist != null) {
      data['artist'] = this.artist!.toJson();
    }
    if (this.credit != null) {
      data['credit'] = this.credit!.toJson();
    }
    if (this.license != null) {
      data['license'] = this.license!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['wb_entity_id'] = this.wbEntityId;
    if (this.structured != null) {
      data['structured'] = this.structured!.toJson();
    }
    return data;
  }
}

class Artist {
  String? html;
  String? text;
  String? name;
  String? userPage;

  Artist({this.html, this.text, this.name, this.userPage});

  Artist.fromJson(Map<String, dynamic> json) {
    html = json['html'];
    text = json['text'];
    name = json['name'];
    userPage = json['user_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html'] = this.html;
    data['text'] = this.text;
    data['name'] = this.name;
    data['user_page'] = this.userPage;
    return data;
  }
}

class Credit {
  String? html;
  String? text;

  Credit({this.html, this.text});

  Credit.fromJson(Map<String, dynamic> json) {
    html = json['html'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html'] = this.html;
    data['text'] = this.text;
    return data;
  }
}

class License {
  String? type;
  String? code;
  String? url;

  License({this.type, this.code, this.url});

  License.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['code'] = this.code;
    data['url'] = this.url;
    return data;
  }
}

class Description {
  String? html;
  String? text;
  String? lang;

  Description({this.html, this.text, this.lang});

  Description.fromJson(Map<String, dynamic> json) {
    html = json['html'];
    text = json['text'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html'] = this.html;
    data['text'] = this.text;
    data['lang'] = this.lang;
    return data;
  }
}

class Structured {
  Captions? captions;

  Structured({this.captions});

  Structured.fromJson(Map<String, dynamic> json) {
    captions = json['captions'] != null
        ? new Captions.fromJson(json['captions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.captions != null) {
      data['captions'] = this.captions!.toJson();
    }
    return data;
  }
}

class Captions {
  String? en;

  Captions({this.en});

  Captions.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    return data;
  }
}
