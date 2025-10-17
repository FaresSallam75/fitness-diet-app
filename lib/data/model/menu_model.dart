class MenuModel {
  String? vegetableid;
  String? vegetablename;
  String? vegetablecalories;
  String? vegetableprice;
  String? vegetableimage;
  String? departmentid;
  String? departmentname;
  String? departmentcreate;

  MenuModel({
    this.vegetableid,
    this.vegetablename,
    this.vegetablecalories,
    this.vegetableprice,
    this.vegetableimage,
    this.departmentid,
    this.departmentname,
    this.departmentcreate,
  });

  MenuModel.fromJson(Map<String, dynamic> json) {
    vegetableid = json['vegetableid'].toString();
    vegetablename = json['vegetablename'];
    vegetablecalories = json['vegetablecalories'];
    vegetableprice = json['vegetableprice'].toString();
    vegetableimage = json['vegetableimage'];
    departmentid = json['departmentid'].toString();
    departmentname = json['departmentname'];
    departmentcreate = json['departmentcreate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vegetableid'] = vegetableid;
    data['vegetablename'] = vegetablename;
    data['vegetablecalories'] = vegetablecalories;
    data['vegetableprice'] = vegetableprice;
    data['vegetableimage'] = vegetableimage;
    data['departmentid'] = departmentid;
    data['departmentname'] = departmentname;
    data['departmentcreate'] = departmentcreate;
    return data;
  }
}
