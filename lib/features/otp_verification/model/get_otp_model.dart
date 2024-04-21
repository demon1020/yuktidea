// To parse this JSON data, do
//
//     final getOtp = getOtpFromJson(jsonString);

import 'dart:convert';

GetOtp getOtpFromJson(String str) => GetOtp.fromJson(json.decode(str));

String getOtpToJson(GetOtp data) => json.encode(data.toJson());

class GetOtp {
  final bool status;
  final String message;
  final Data data;

  GetOtp({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetOtp.fromJson(Map<String, dynamic> json) => GetOtp(
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
  final int id;
  final dynamic name;
  final dynamic email;
  final int countryId;
  final String phone;
  final dynamic phoneVerifiedAt;
  final dynamic avatar;
  final dynamic approvedAt;
  final dynamic detailsType;
  final dynamic detailsId;
  final int profileStatusId;
  final int reviewCount;
  final String reviewRating;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.countryId,
    required this.phone,
    required this.phoneVerifiedAt,
    required this.avatar,
    required this.approvedAt,
    required this.detailsType,
    required this.detailsId,
    required this.profileStatusId,
    required this.reviewCount,
    required this.reviewRating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        countryId: json["country_id"],
        phone: json["phone"],
        phoneVerifiedAt: json["phone_verified_at"],
        avatar: json["avatar"],
        approvedAt: json["approved_at"],
        detailsType: json["details_type"],
        detailsId: json["details_id"],
        profileStatusId: json["profile_status_id"],
        reviewCount: json["review_count"],
        reviewRating: json["review_rating"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "country_id": countryId,
        "phone": phone,
        "phone_verified_at": phoneVerifiedAt,
        "avatar": avatar,
        "approved_at": approvedAt,
        "details_type": detailsType,
        "details_id": detailsId,
        "profile_status_id": profileStatusId,
        "review_count": reviewCount,
        "review_rating": reviewRating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
