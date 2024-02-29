// To parse this JSON data, do
//
//     final getOrderAdmin = getOrderAdminFromJson(jsonString);

import 'dart:convert';

GetOrderAdmin getOrderAdminFromJson(String str) => GetOrderAdmin.fromJson(json.decode(str));

String getOrderAdminToJson(GetOrderAdmin data) => json.encode(data.toJson());

class GetOrderAdmin {
  String status;
  int length;
  List<Datum> data;

  GetOrderAdmin({
    required this.status,
    required this.length,
    required this.data,
  });

  factory GetOrderAdmin.fromJson(Map<String, dynamic> json) => GetOrderAdmin(
    status: json["status"],
    length: json["length"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "length": length,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  Product product;
  Shop shop;
  User user;
  String color;
  String size;
  DateTime createdAt;
  bool paid;
  int v;

  Datum({
    required this.id,
    required this.product,
    required this.shop,
    required this.user,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.paid,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    product: Product.fromJson(json["product"]),
    shop: shopValues.map[json["shop"]]!,
    user: User.fromJson(json["user"]),
    color: json["color"],
    size: json["size"],
    createdAt: DateTime.parse(json["createdAt"]),
    paid: json["paid"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product": product.toJson(),
    "shop": shopValues.reverse[shop],
    "user": user.toJson(),
    "color": color,
    "size": size,
    "createdAt": createdAt.toIso8601String(),
    "paid": paid,
    "__v": v,
  };
}

class Product {
  String id;
  String name;
  double price;
  String imageCover;
  String productClass;
  User user;
  List<dynamic> reviews;
  String productId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageCover,
    required this.productClass,
    required this.user,
    required this.reviews,
    required this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    imageCover: json["imageCover"],
    productClass: json["class"],
    user: User.fromJson(json["user"]),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    productId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "imageCover": imageCover,
    "class": productClass,
    "user": user.toJson(),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
    "id": productId,
  };
}

class User {
  Shop id;
  String name;
  String email;
  String photo;
  Role role;
  Shop userId;
  int? v;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.userId,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: shopValues.map[json["_id"]]!,
    name: json["name"]!,
    email: json["email"]!,
    photo: json["photo"],
    role: roleValues.map[json["role"]]!,
    userId: shopValues.map[json["id"]]!,
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": shopValues.reverse[id],
    "name": nameValues.reverse[name],
    "email": emailValues.reverse[email],
    "photo": photo,
    "role": roleValues.reverse[role],
    "id": shopValues.reverse[userId],
    "__v": v,
  };
}

enum Email {
  MOHMMAD_GMAIL_COM,
  SHOP_GMAIL_COM,
  USER_GMAIL_COM
}

final emailValues = EnumValues({
  "mohmmad@gmail.com": Email.MOHMMAD_GMAIL_COM,
  "shop@gmail.com": Email.SHOP_GMAIL_COM,
  "user@gmail.com": Email.USER_GMAIL_COM
});

enum Shop {
  THE_653_D16_A137_DB3_CA1_CC919179,
  THE_653_D16_BC37_DB3_CA1_CC91917_B,
  THE_655066_DC19_AF51_CE9_AED6539
}

final shopValues = EnumValues({
  "653d16a137db3ca1cc919179": Shop.THE_653_D16_A137_DB3_CA1_CC919179,
  "653d16bc37db3ca1cc91917b": Shop.THE_653_D16_BC37_DB3_CA1_CC91917_B,
  "655066dc19af51ce9aed6539": Shop.THE_655066_DC19_AF51_CE9_AED6539
});

enum Name {
  MOHMMAD,
  SHOP_ONE,
  USER_ONE
}

final nameValues = EnumValues({
  "mohmmad": Name.MOHMMAD,
  "shop one": Name.SHOP_ONE,
  "user one": Name.USER_ONE
});

enum Role {
  SHOP,
  USER
}

final roleValues = EnumValues({
  "shop": Role.SHOP,
  "user": Role.USER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
