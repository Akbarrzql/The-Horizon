class HistoryModel {
  int? id;
  String? namaSejarah;
  String? extract;
  String? image;
  String? desc;
  String? author;

  HistoryModel(
      {this.id,
        this.namaSejarah,
        this.extract,
        this.image,
        this.desc,
        this.author});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaSejarah = json['namaSejarah'];
    extract = json['extract'];
    image = json['image'];
    desc = json['desc'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['namaSejarah'] = this.namaSejarah;
    data['extract'] = this.extract;
    data['image'] = this.image;
    data['desc'] = this.desc;
    data['author'] = this.author;
    return data;
  }
}
