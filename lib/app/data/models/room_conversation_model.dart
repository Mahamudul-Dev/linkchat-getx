import 'package:get/get.dart';
import 'package:linkchat/app/database/room_schema.dart';

class RoomConversationModel {
  final String roomName;
  final String roomId;
  final RxList<RoomMessageSchema> messages;

  RoomConversationModel(
      {required this.roomName, required this.roomId, required this.messages});
}

class RoomParticipantModel {
  String serverId;
  String? uid;
  String? name;
  String? photo;
  String? country;

  RoomParticipantModel(
      {required this.serverId, this.uid, this.name, this.photo, this.country});
}

class RoomMessageModel {
  final String? id;
  final String? message;
  final String? createdAt;
  final String? senderId;
  final String? groupId;
  final MessageReply? replyMessage;
  final ReactionModel? reaction;
  final String? messageType;
  final String? voiceMessageDuration;
  final String? status;

  RoomMessageModel({
    this.id,
    this.message,
    this.createdAt,
    this.senderId,
    this.groupId,
    this.replyMessage,
    this.reaction,
    this.messageType,
    this.voiceMessageDuration,
    this.status,
  });

  factory RoomMessageModel.fromJson(Map<String, dynamic> json) =>
      RoomMessageModel(
        id: json["id"],
        message: json["message"],
        createdAt: json["createdAt"],
        senderId: json["senderId"],
        groupId: json["groupId"],
        replyMessage: json["reply_message"] == null
            ? null
            : MessageReply.fromJson(json["reply_message"]),
        reaction: json["reaction"] == null
            ? null
            : ReactionModel.fromJson(json["reaction"]),
        messageType: json["message_type"],
        voiceMessageDuration: json["voice_message_duration"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "createdAt": createdAt,
        "senderId": senderId,
        "groupId": groupId,
        "replyMessage": replyMessage?.toJson(),
        "reaction": reaction?.toJson(),
        "messageType": messageType,
        "voiceMessageDuration": voiceMessageDuration,
        "status": status,
      };
}

class ReactionModel {
  final List<String>? reactions;
  final List<String>? reactedUserIds;

  ReactionModel({
    required this.reactions,
    required this.reactedUserIds,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) => ReactionModel(
        reactions: json["reactions"] == null
            ? []
            : List<String>.from(json["reactions"]!.map((x) => x)),
        reactedUserIds: json["reactedUserIds"] == null
            ? []
            : List<String>.from(json["reactedUserIds"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "reactions": List<dynamic>.from(reactions!.map((x) => x)),
        "reactedUserIds": List<dynamic>.from(reactedUserIds!.map((x) => x)),
      };
}

class MessageReply {
  final String? message;
  final String? replyBy;
  final String? replyTo;
  final String? messageType;
  final String? id;
  final String? voiceMessageDuration;

  MessageReply({
    this.message,
    this.replyBy,
    this.replyTo,
    this.messageType,
    this.id,
    this.voiceMessageDuration,
  });

  factory MessageReply.fromJson(Map<String, dynamic> json) => MessageReply(
        message: json["message"],
        replyBy: json["replyBy"],
        replyTo: json["replyTo"],
        messageType: json["messageType"],
        id: json["id"],
        voiceMessageDuration: json["voiceMessageDuration"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "replyBy": replyBy,
        "replyTo": replyTo,
        "messageType": messageType,
        "id": id,
        "voiceMessageDuration": voiceMessageDuration,
      };
}
