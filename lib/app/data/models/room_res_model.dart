import 'dart:convert';

class RoomResModel {
  String status;
  String message;
  List<RoomModel> data;

  RoomResModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RoomResModel.fromRawJson(String str) =>
      RoomResModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomResModel.fromJson(Map<String, dynamic> json) => RoomResModel(
        status: json["status"],
        message: json["message"],
        data: List<RoomModel>.from(
            json["data"].map((x) => RoomModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RoomModel {
  Settings settings;
  String id;
  String creatorId;
  String groupName;
  String groupDescription;
  String? groupImage;
  int joinCode;
  List<String> admins;
  List<String> members;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RoomModel({
    required this.settings,
    required this.id,
    required this.creatorId,
    required this.groupName,
    required this.groupDescription,
    this.groupImage,
    required this.joinCode,
    required this.admins,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RoomModel.fromRawJson(String str) =>
      RoomModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        settings: Settings.fromJson(json["settings"]),
        id: json["_id"],
        creatorId: json["creatorId"],
        groupName: json["groupName"],
        groupDescription: json["groupDescription"],
        groupImage: json["groupImage"],
        joinCode: json["joinCode"],
        admins: List<String>.from(json["admins"].map((x) => x)),
        members: List<String>.from(json["members"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "settings": settings.toJson(),
        "_id": id,
        "creatorId": creatorId,
        "groupName": groupName,
        "groupDescription": groupDescription,
        "groupImage": groupImage,
        "joinCode": joinCode,
        "admins": List<dynamic>.from(admins.map((x) => x)),
        "members": List<dynamic>.from(members.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Settings {
  String groupVisibility;
  int memberLimit;
  bool anyoneCanAddMember;
  bool anyoneCanModifyGroup;
  bool nudeProtection;
  String whoCanMessage;

  Settings({
    required this.groupVisibility,
    required this.memberLimit,
    required this.anyoneCanAddMember,
    required this.anyoneCanModifyGroup,
    required this.nudeProtection,
    required this.whoCanMessage,
  });

  factory Settings.fromRawJson(String str) =>
      Settings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        groupVisibility: json["groupVisibility"],
        memberLimit: json["memberLimit"],
        anyoneCanAddMember: json["anyoneCanAddMember"],
        anyoneCanModifyGroup: json["anyoneCanModifyGroup"],
        nudeProtection: json["nudeProtection"],
        whoCanMessage: json["whoCanMessage"],
      );

  Map<String, dynamic> toJson() => {
        "groupVisibility": groupVisibility,
        "memberLimit": memberLimit,
        "anyoneCanAddMember": anyoneCanAddMember,
        "anyoneCanModifyGroup": anyoneCanModifyGroup,
        "nudeProtection": nudeProtection,
        "whoCanMessage": whoCanMessage,
      };
}
