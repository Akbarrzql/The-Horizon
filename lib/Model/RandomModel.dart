class RandomModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? linkurl;

  RandomModel(
      {this.id, this.title, this.description, this.image, this.linkurl});

  RandomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    linkurl = json['linkurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['linkurl'] = this.linkurl;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'linkurl': linkurl,
    };
  }
}
