// To parse this JSON data, do
//
//     final detailsProducts = detailsProductsFromJson(jsonString);

import 'dart:convert';

DetailsProducts detailsProductsFromJson(String str) => DetailsProducts.fromJson(json.decode(str));

String detailsProductsToJson(DetailsProducts data) => json.encode(data.toJson());

class DetailsProducts {
  String status;
  Data data;

  DetailsProducts({
    required this.status,
    required this.data,
  });

  factory DetailsProducts.fromJson(Map<String, dynamic> json) => DetailsProducts(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String name;
  String description;
  double ratingsAverage;
  double price;
  String imageCover;
  List<String> images;
  List<String> colors;
  List<String> sizes;
  String dataClass;
  String userId;
  User user;
  int v;
  List<dynamic> reviews;
  String dataId;

  Data({
    required this.id,
    required this.name,
    required this.description,
    required this.ratingsAverage,
    required this.price,
    required this.imageCover,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.dataClass,
    required this.userId,
    required this.user,
    required this.v,
    required this.reviews,
    required this.dataId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    ratingsAverage: json["ratingsAverage"]?.toDouble(),
    price: json["price"]?.toDouble(),
    imageCover: json["imageCover"],
    images: List<String>.from(json["images"].map((x) => x)),
    colors: List<String>.from(json["colors"].map((x) => x)),
    sizes: List<String>.from(json["sizes"].map((x) => x)),
    dataClass: json["class"],
    userId: json["userId"],
    user: User.fromJson(json["user"]),
    v: json["__v"],
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    dataId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "ratingsAverage": ratingsAverage,
    "price": price,
    "imageCover": imageCover,
    "images": List<dynamic>.from(images.map((x) => x)),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "sizes": List<dynamic>.from(sizes.map((x) => x)),
    "class": dataClass,
    "userId": userId,
    "user": user.toJson(),
    "__v": v,
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
    "id": dataId,
  };
}

class User {
  String id;
  String name;
  String email;
  String photo;
  String role;
  String userId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    photo: json["photo"],
    role: json["role"],
    userId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "photo": photo,
    "role": role,
    "id": userId,
  };
}
