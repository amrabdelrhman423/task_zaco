class Deal {
  int? dealId;
  String? dealColor;
  String? dealTitle;
  String? dealSubtitle;
  String? dealAway;
  String? priceAfter;
  String? priceBefor;
  late bool like;

  Deal(
      {this.dealId,
      this.dealColor,
      this.dealTitle,
      this.dealSubtitle,
      this.dealAway,
      this.priceAfter,
      this.priceBefor,
      required this.like});

  Deal.fromJson(Map<String, dynamic> json) {
    dealId = json['deal_id'];
    dealColor = json['deal_color'];
    dealTitle = json['deal_title'];
    dealSubtitle = json['deal_subtitle'];
    dealAway = json['deal_away'];
    priceAfter = json['price_after'];
    priceBefor = json['price_befor'];
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_id'] = this.dealId;
    data['deal_color'] = this.dealColor;
    data['deal_title'] = this.dealTitle;
    data['deal_subtitle'] = this.dealSubtitle;
    data['deal_away'] = this.dealAway;
    data['price_after'] = this.priceAfter;
    data['price_befor'] = this.priceBefor;
    data['like'] = this.like;
    return data;
  }
}
