class Category {
  String? catName;
  String? catColor;
  int? catId;

  Category({this.catName, this.catColor, this.catId});

  Category.fromJson(Map<String, dynamic> json) {
    catName = json['cat_name'];
    catColor = json['cat_color'];
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_name'] = this.catName;
    data['cat_color'] = this.catColor;
    data['cat_id'] = this.catId;
    return data;
  }
}
