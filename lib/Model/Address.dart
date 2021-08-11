class Address {
  String? addressType;
  String? addressStreet;
  String? addressDetails;
  int? addressId;

  Address(
      {this.addressType,
      this.addressStreet,
      this.addressDetails,
      this.addressId});

  Address.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    addressStreet = json['address_street'];
    addressDetails = json['address_details'];
    addressId = json['address_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_type'] = this.addressType;
    data['address_street'] = this.addressStreet;
    data['address_details'] = this.addressDetails;
    data['address_id'] = this.addressId;
    return data;
  }
}
