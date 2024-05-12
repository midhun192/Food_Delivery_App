class CartModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? Datetime;

  CartModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.img,
    this.quantity,
    this.Datetime,
    this.isExist,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    img = json['img'];
    quantity = json["quantity"];
    Datetime = json["Datetime"];
    isExist = json["isExist"];
  }
}
