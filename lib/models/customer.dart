class Customer {
  Customer({
    required this.sId,
    required this.customerName,
    required this.companyName,
    required this.emailId,
    required this.date,
    required this.customerType,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.phone,
  });
  late final String sId;
  late final String customerName;
  late final String companyName;
  late final String emailId;
  late final String date;
  late final String customerType;
  late final String address;
  late final String city;
  late final int zipCode;
  late final String phone;

  Customer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerName = json['customer_name'];
    companyName = json['company_name'];
    emailId = json['email_id'];
    date = json['date'];
    customerType = json['customer_type'];
    address = json['address'];
    city = json['city'];
    zipCode = json['zip_code'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sId;
    _data['customer_name'] = customerName;
    _data['company_name'] = companyName;
    _data['email_id'] = emailId;
    _data['date'] = date;
    _data['customer_type'] = customerType;
    _data['address'] = address;
    _data['city'] = city;
    _data['zip_code'] = zipCode;
    _data['phone'] = phone;
    return _data;
  }
}
