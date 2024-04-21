// To parse this JSON data, do
//
//     final selectedCountry = selectedCountryFromJson(jsonString);

import 'dart:convert';

SelectedCountry selectedCountryFromJson(String str) =>
    SelectedCountry.fromJson(json.decode(str));

String selectedCountryToJson(SelectedCountry data) =>
    json.encode(data.toJson());

class SelectedCountry {
  final bool status;
  final String message;
  final Data data;

  SelectedCountry({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SelectedCountry.fromJson(Map<String, dynamic> json) =>
      SelectedCountry(
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
  final String selectedCountry;

  Data({
    required this.profileStatus,
    required this.role,
    required this.selectedCountry,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileStatus: json["profile_status"],
        role: json["role"],
        selectedCountry: json["selected_country"],
      );

  Map<String, dynamic> toJson() => {
        "profile_status": profileStatus,
        "role": role,
        "selected_country": selectedCountry,
      };
}
