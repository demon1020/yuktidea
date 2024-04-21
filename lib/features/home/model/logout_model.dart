// To parse this JSON data, do
//
//     final logout = logoutFromJson(jsonString);

import 'dart:convert';

UserDeleteLogout logoutFromJson(String str) =>
    UserDeleteLogout.fromJson(json.decode(str));

String logoutToJson(UserDeleteLogout data) => json.encode(data.toJson());

class UserDeleteLogout {
  final bool status;
  final String message;
  final String data;

  UserDeleteLogout({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserDeleteLogout.fromJson(Map<String, dynamic> json) =>
      UserDeleteLogout(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
