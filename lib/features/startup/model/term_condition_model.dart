import 'dart:convert';

TermCondition termConditionFromJson(String str) =>
    TermCondition.fromJson(json.decode(str));

String termConditionToJson(TermCondition data) => json.encode(data.toJson());

class TermCondition {
  final bool status;
  final String message;
  final Data data;

  TermCondition({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TermCondition.fromJson(Map<String, dynamic> json) => TermCondition(
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
  final String title;
  final String content;
  final DateTime publishedAt;
  final int enabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.enabled,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        publishedAt: DateTime.parse(json["published_at"]),
        enabled: json["enabled"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "published_at": publishedAt.toIso8601String(),
        "enabled": enabled,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
