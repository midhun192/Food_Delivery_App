import 'package:food_delivery_app/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.img,
    this.quantity,
    this.time,
    this.isExist,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    img = json['img'];
    quantity = json["quantity"];
    time = json["time"];
    isExist = json["isExist"];
    product = ProductModel.fromJson(json["product"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "img": this.img,
      "price": this.price,
      "quantity": this.quantity,
      "time": this.time,
      "product": this.product!.toJson(),
    };
  }
}
