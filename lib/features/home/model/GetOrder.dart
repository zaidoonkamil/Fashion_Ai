// To parse this JSON data, do
//
//     final getOrder = getOrderFromJson(jsonString);

import 'dart:convert';

GetOrder getOrderFromJson(String str) => GetOrder.fromJson(json.decode(str));

String getOrderToJson(GetOrder data) => json.encode(data.toJson());

class GetOrder {
  String status;
  int length;
  double totalPrice;
  List<Datum> data;

  GetOrder({
    required this.status,
    required this.length,
    required this.totalPrice,
    required this.data,
  });

  factory GetOrder.fromJson(Map<String, dynamic> json) => GetOrder(
    status: json["status"],
    length: json["length"],
    totalPrice: json["totalPrice"]?.toDouble(),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "length": length,
    "totalPrice": totalPrice,
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
    color: json["color"]!,
    size: json["size"]!,
    createdAt: DateTime.parse(json["createdAt"]),
    paid: json["paid"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product": product.toJson(),
    "shop": shopValues.reverse[shop],
    "user": user.toJson(),
    "color": colorValues.reverse[color],
    "size": sizeValues.reverse[size],
    "createdAt": createdAt.toIso8601String(),
    "paid": paid,
    "__v": v,
  };
}

enum Color {
  D97706,
  EF4444
}

final colorValues = EnumValues({
  "#d97706": Color.D97706,
  "#ef4444": Color.EF4444
});

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
    name: json["name"]!,
    price: json["price"]?.toDouble(),
    imageCover: json["imageCover"],
    productClass: json["class"],
    user: User.fromJson(json["user"]),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    productId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": productNameValues.reverse[name],
    "price": price,
    "imageCover": imageCover,
    "class": productClass,
    "user": user.toJson(),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
    "id": productId,
  };
}

enum ProductName {
  MEST_ONE,
  TEST_ONE
}

final productNameValues = EnumValues({
  "mest one": ProductName.MEST_ONE,
  "Test one": ProductName.TEST_ONE
});

class User {
  Shop id;
  UserName name;
  Email email;
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
    name: userNameValues.map[json["name"]]!,
    email: emailValues.map[json["email"]]!,
    photo: json["photo"],
    role: roleValues.map[json["role"]]!,
    userId: shopValues.map[json["id"]]!,
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": shopValues.reverse[id],
    "name": userNameValues.reverse[name],
    "email": emailValues.reverse[email],
    "photo": photo,
    "role": roleValues.reverse[role],
    "id": shopValues.reverse[userId],
    "__v": v,
  };
}

enum Email {
  SHOP_GMAIL_COM,
  USER_GMAIL_COM
}

final emailValues = EnumValues({
  "shop@gmail.com": Email.SHOP_GMAIL_COM,
  "user@gmail.com": Email.USER_GMAIL_COM
});

enum Shop {
  THE_653_D16_A137_DB3_CA1_CC919179,
  THE_653_D16_BC37_DB3_CA1_CC91917_B
}

final shopValues = EnumValues({
  "653d16a137db3ca1cc919179": Shop.THE_653_D16_A137_DB3_CA1_CC919179,
  "653d16bc37db3ca1cc91917b": Shop.THE_653_D16_BC37_DB3_CA1_CC91917_B
});

enum UserName {
  SHOP_ONE,
  USER_ONE
}

final userNameValues = EnumValues({
  "shop one": UserName.SHOP_ONE,
  "user one": UserName.USER_ONE
});

enum Role {
  SHOP,
  USER
}

final roleValues = EnumValues({
  "shop": Role.SHOP,
  "user": Role.USER
});

enum Size {
  SM
}

final sizeValues = EnumValues({
  "SM": Size.SM
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
