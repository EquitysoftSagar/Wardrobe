class Category {
  String userId;
  String name;
  String id;
  List<String> images;

  Category({this.userId, this.name, this.images});

  Category.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    id = json['id'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['id'] = this.id;
    data['images'] = this.images;
    return data;
  }
}