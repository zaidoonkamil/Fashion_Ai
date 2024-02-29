// To parse this JSON data, do
//
//     final getSearchProducts = getSearchProductsFromJson(jsonString);

import 'dart:convert';

GetSearchProducts getSearchProductsFromJson(String str) => GetSearchProducts.fromJson(json.decode(str));

String getSearchProductsToJson(GetSearchProducts data) => json.encode(data.toJson());

class GetSearchProducts {
  String status;
  List<Datum> data;

  GetSearchProducts({
    required this.status,
    required this.data,
  });

  factory GetSearchProducts.fromJson(Map<String, dynamic> json) => GetSearchProducts(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  DatumName name;
  String description;
  double ratingsAverage;
  double price;
  String imageCover;
  List<String> images;
  List<Color> colors;
  List<Size> sizes;
  String datumClass;
  UserId userId;
  User user;
  int v;
  List<dynamic> reviews;
  String datumId;

  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.ratingsAverage,
    required this.price,
    required this.imageCover,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.datumClass,
    required this.userId,
    required this.user,
    required this.v,
    required this.reviews,
    required this.datumId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: datumNameValues.map[json["name"]]!,
    description: json["description"],
    ratingsAverage: json["ratingsAverage"]?.toDouble(),
    price: json["price"]?.toDouble(),
    imageCover: json["imageCover"],
    images: List<String>.from(json["images"].map((x) => x)),
    colors: List<Color>.from(json["colors"].map((x) => colorValues.map[x]!)),
    sizes: List<Size>.from(json["sizes"].map((x) => sizeValues.map[x]!)),
    datumClass: json["class"],
    userId: userIdValues.map[json["userId"]]!,
    user: User.fromJson(json["user"]),
    v: json["__v"],
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": datumNameValues.reverse[name],
    "description": description,
    "ratingsAverage": ratingsAverage,
    "price": price,
    "imageCover": imageCover,
    "images": List<dynamic>.from(images.map((x) => x)),
    "colors": List<dynamic>.from(colors.map((x) => colorValues.reverse[x])),
    "sizes": List<dynamic>.from(sizes.map((x) => sizeValues.reverse[x])),
    "class": datumClass,
    "userId": userIdValues.reverse[userId],
    "user": user.toJson(),
    "__v": v,
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
    "id": datumId,
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

enum DatumName {
  TEST_ONE
}

final datumNameValues = EnumValues({
  "Test one": DatumName.TEST_ONE
});

enum Size {
  SM
}

final sizeValues = EnumValues({
  "SM": Size.SM
});

class User {
  UserId id;
  UserName name;
  Email email;
  String photo;
  Role role;
  UserId userId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: userIdValues.map[json["_id"]]!,
    name: userNameValues.map[json["name"]]!,
    email: emailValues.map[json["email"]]!,
    photo: json["photo"],
    role: roleValues.map[json["role"]]!,
    userId: userIdValues.map[json["id"]]!,
  );

  Map<String, dynamic> toJson() => {
    "_id": userIdValues.reverse[id],
    "name": userNameValues.reverse[name],
    "email": emailValues.reverse[email],
    "photo": photo,
    "role": roleValues.reverse[role],
    "id": userIdValues.reverse[userId],
  };
}

enum Email {
  SHOP_GMAIL_COM
}

final emailValues = EnumValues({
  "shop@gmail.com": Email.SHOP_GMAIL_COM
});

enum UserId {
  THE_653_D16_BC37_DB3_CA1_CC91917_B
}

final userIdValues = EnumValues({
  "653d16bc37db3ca1cc91917b": UserId.THE_653_D16_BC37_DB3_CA1_CC91917_B
});

enum UserName {
  SHOP_ONE
}

final userNameValues = EnumValues({
  "shop one": UserName.SHOP_ONE
});

enum Role {
  SHOP
}

final roleValues = EnumValues({
  "shop": Role.SHOP
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
