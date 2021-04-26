// https://app.quicktype.io/
// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  Result({
    this.apiVersion,
    this.resultsAvailable,
    this.resultsReturned,
    this.resultsStart,
    this.special,
  });

  String apiVersion;
  int resultsAvailable;
  String resultsReturned;
  int resultsStart;
  List<Special> special;

  List<Special> getSpecial(){
    return Result().special;
  }

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    apiVersion: json["api_version"],
    resultsAvailable: json["results_available"],
    resultsReturned: json["results_returned"],
    resultsStart: json["results_start"],
    special: List<Special>.from(json["special"].map((x) => Special.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "api_version": apiVersion,
    "results_available": resultsAvailable,
    "results_returned": resultsReturned,
    "results_start": resultsStart,
    "special": List<dynamic>.from(special.map((x) => x.toJson())),
  };
}

class Special {
  Special({
    this.code,
    this.name,
    this.specialCategory,
  });

  String code;
  String name;
  SpecialCategory specialCategory;

  factory Special.fromJson(Map<String, dynamic> json) => Special(
    code: json["code"],
    name: json["name"],
    specialCategory: SpecialCategory.fromJson(json["special_category"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "special_category": specialCategory.toJson(),
  };
}

class SpecialCategory {
  SpecialCategory({
    this.code,
    this.name,
  });

  Code code;
  Name name;

  factory SpecialCategory.fromJson(Map<String, dynamic> json) => SpecialCategory(
    code: codeValues.map[json["code"]],
    name: nameValues.map[json["name"]],
  );

  Map<String, dynamic> toJson() => {
    "code": codeValues.reverse[code],
    "name": nameValues.reverse[name],
  };
}

enum Code { SPG6 }

final codeValues = EnumValues({
  "SPG6": Code.SPG6
});

enum Name { EMPTY }

final nameValues = EnumValues({
  "定番おすすめ": Name.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
