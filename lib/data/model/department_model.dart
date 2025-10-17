class DepartmentModel {
  String? departmentid;
  String? departmentname;
  String? departmentcreate;

  DepartmentModel({
    this.departmentid,
    this.departmentname,
    this.departmentcreate,
  });

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    departmentid = json['departmentid'].toString();
    departmentname = json['departmentname'];
    departmentcreate = json['departmentcreate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departmentid'] = departmentid;
    data['departmentname'] = departmentname;
    data['departmentcreate'] = departmentcreate;
    return data;
  }
}
