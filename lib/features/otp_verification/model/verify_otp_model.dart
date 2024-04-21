// To parse this JSON data, do
//
//     final verifyOtp = verifyOtpFromJson(jsonString);

import 'dart:convert';

VerifyOtp verifyOtpFromJson(String str) => VerifyOtp.fromJson(json.decode(str));

String verifyOtpToJson(VerifyOtp data) => json.encode(data.toJson());

class VerifyOtp {
  final bool status;
  final String message;
  final Data data;

  VerifyOtp({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
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
  final String phone;
  final DateTime phoneVerifiedAt;
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  Data({
    required this.profileStatus,
    required this.role,
    required this.phone,
    required this.phoneVerifiedAt,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileStatus: json["profile_status"],
        role: json["role"],
        phone: json["phone"],
        phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "profile_status": profileStatus,
        "role": role,
        "phone": phone,
        "phone_verified_at": phoneVerifiedAt.toIso8601String(),
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
