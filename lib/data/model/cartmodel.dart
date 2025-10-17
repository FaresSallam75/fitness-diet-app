class CartModel {
  String? vegetableid;
  String? vegetablename;
  String? vegetablecalories;
  String? vegetableprice;
  String? vegetableimage;
  String? departmentid;
  String? cartid;
  String? userId;
  String? vegtableId;
  String? name;
  int? price;
  int? unitCalories;
  int? calories;
  int? unitPrice;
  String? quantity;
  String? image;
  String? datetime;

  CartModel({
    this.vegetableid,
    this.vegetablename,
    this.vegetablecalories,
    this.vegetableprice,
    this.vegetableimage,
    this.departmentid,
    this.cartid,
    this.userId,
    this.vegtableId,
    this.name,
    this.price,
    this.unitCalories,
    this.calories,
    this.unitPrice,
    this.quantity,
    this.image,
    this.datetime,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    vegetableid = json['vegetableid'].toString();
    vegetablename = json['vegetablename'].toString();
    vegetablecalories = json['vegetablecalories'].toString();
    vegetableprice = json['vegetableprice'].toString();
    vegetableimage = json['vegetableimage'].toString();
    departmentid = json['departmentid'].toString();
    cartid = json['cartid'].toString();
    userId = json['userId'].toString();
    vegtableId = json['vegtableId'].toString();
    name = json['name'].toString();
    price = json['price'];
    unitCalories = json['unitCalories'];
    calories = json['calories'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'].toString();
    image = json['image'].toString();
    datetime = json['datetime'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vegetableid'] = vegetableid;
    data['vegetablename'] = vegetablename;
    data['vegetablecalories'] = vegetablecalories;
    data['vegetableprice'] = vegetableprice;
    data['vegetableimage'] = vegetableimage;
    data['departmentid'] = departmentid;
    data['cartid'] = cartid;
    data['userId'] = userId;
    data['vegtableId'] = vegtableId;
    data['name'] = name;
    data['price'] = price;
    data['unitCalories'] = unitCalories;
    data['calories'] = calories;
    data['unitPrice'] = unitPrice;
    data['quantity'] = quantity;
    data['image'] = image;
    data['datetime'] = datetime;
    return data;
  }
}
