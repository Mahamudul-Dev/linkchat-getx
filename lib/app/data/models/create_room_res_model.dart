import 'dart:convert';

import 'room_res_model.dart';

class RoomCreateResModel {
  String status;
  String message;
  RoomModel data;

  RoomCreateResModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RoomCreateResModel.fromRawJson(String str) =>
      RoomCreateResModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomCreateResModel.fromJson(Map<String, dynamic> json) =>
      RoomCreateResModel(
        status: json["status"],
        message: json["message"],
        data: RoomModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}
