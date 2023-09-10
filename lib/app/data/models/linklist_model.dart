import 'dart:convert';

import 'package:linkchat/app/data/models/user_model.dart';

class LinkListModel {
  String status;
  String message;
  List<Linked> data;

  LinkListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LinkListModel.fromRawJson(String str) => LinkListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LinkListModel.fromJson(Map<String, dynamic> json) => LinkListModel(
    status: json["status"],
    message: json["message"],
    data: List<Linked>.from(json["data"].map((x) => Linked.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<Linked>.from(data.map((x) => x.toJson())),
  };
}
