class Company {
  int? companyid;
  String? comapnyname;
  String? companyphonenumber;
  String? companyaddress;
  String? companylogo;

  Company({this.companyid, this.comapnyname, this.companyphonenumber, this.companyaddress, this.companylogo});

  Company.fromJson(Map<String, dynamic> json) {
    companyid = json['id'];
    comapnyname = json['name'];
    companyphonenumber = json['phone'];
    companyaddress = json['address'];
    companylogo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    // data['id'] = companyid;
    data['name'] = comapnyname;
    data['phone'] = companyphonenumber;
    data['address'] = companyaddress;
    data['logo'] = companylogo;

    return data;
  }
}
