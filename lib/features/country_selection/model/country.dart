// To parse this JSON data, do
//
//     final selectCountry = selectCountryFromJson(jsonString);

import 'dart:convert';

SelectCountry selectCountryFromJson(String str) =>
    SelectCountry.fromJson(json.decode(str));

String selectCountryToJson(SelectCountry data) => json.encode(data.toJson());

class SelectCountry {
  final bool status;
  final String message;
  final Data data;

  SelectCountry({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SelectCountry.fromJson(Map<String, dynamic> json) => SelectCountry(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String profileStatus;
  final String role;
  final dynamic selectedCountry;
  final List<Country> countries;

  Data({
    required this.profileStatus,
    required this.role,
    required this.selectedCountry,
    required this.countries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileStatus: json["profile_status"],
        role: json["role"],
        selectedCountry: json["selected_country"],
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profile_status": profileStatus,
        "role": role,
        "selected_country": selectedCountry,
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  final int id;
  final String name;
  final String flag;
  final String image;
  bool isSelected;

  Country(
      {required this.id,
      required this.name,
      required this.flag,
      required this.image,
      this.isSelected = false});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        flag: json["flag"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "flag": flag,
        "image": image,
      };
}
