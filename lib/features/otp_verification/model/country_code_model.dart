// To parse this JSON data, do
//
//     final countryCode = countryCodeFromJson(jsonString);

import 'dart:convert';

CountryCode countryCodeFromJson(String str) =>
    CountryCode.fromJson(json.decode(str));

String countryCodeToJson(CountryCode data) => json.encode(data.toJson());

class CountryCode {
  final bool status;
  final String message;
  final List<CountryData> data;

  CountryCode({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CountryCode.fromJson(Map<String, dynamic> json) => CountryCode(
        status: json["status"],
        message: json["message"],
        data: List<CountryData>.from(
            json["data"].map((x) => CountryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CountryData {
  final int id;
  final String name;
  final String code;
  final String telCode;
  final dynamic timezone;
  final String flag;
  final DateTime createdAt;
  final DateTime updatedAt;

  CountryData({
    required this.id,
    required this.name,
    required this.code,
    required this.telCode,
    required this.timezone,
    required this.flag,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        telCode: json["tel_code"],
        timezone: json["timezone"],
        flag: json["flag"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "tel_code": telCode,
        "timezone": timezone,
        "flag": flag,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
