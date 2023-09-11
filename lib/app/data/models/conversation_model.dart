import 'package:get/get.dart';

class ConversationModel {
  final String conversationTitle;
  final RxList<ReceiveMessageModel?> messages;
  final ChatParticipantModel receiver;
  final List<ChatParticipantModel> participant;

  ConversationModel(
      {required this.conversationTitle,
      required this.messages,
      required this.receiver,
      required this.participant});
}

class ChatParticipantModel {
  String serverId;
  String? uid;
  String? name;
  String? photo;
  String? country;

  ChatParticipantModel(
      {required this.serverId, this.uid, this.name, this.photo, this.country});
}

// class ReceiveMessageModel {
//   ReceiveMessageModel({
//     required this.message,
//     required this.users,
//     required this.sender,
//     required this.receiver,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final MessageModel message;
//   late final List<String> users;
//   late final String sender;
//   late final String receiver;
//   late final String createdAt;
//   late final String updatedAt;

//   ReceiveMessageModel.fromJson(Map<String, dynamic> json){
//     message = MessageModel.fromJson(json['message']);
//     users = List.castFrom<dynamic, String>(json['users']);
//     sender = json['sender'];
//     receiver = json['receiver'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['message'] = message.toJson();
//     _data['users'] = users;
//     _data['sender'] = sender;
//     _data['receiver'] = receiver;
//     _data['createdAt'] = createdAt;
//     _data['updatedAt'] = updatedAt;
//     return _data;
//   }
// }

class ReceiveMessageModel {
  String message;
  String createdAt;
  String senderId;
  String receiverId;
  ReplyMessage? replyMessage;
  Reaction? reaction;
  String messageType;
  String voiceMessageDuration;
  String status;

  ReceiveMessageModel({
    required this.message,
    required this.createdAt,
    required this.senderId,
    required this.receiverId,
    this.replyMessage,
    this.reaction,
    required this.messageType,
    required this.voiceMessageDuration,
    required this.status,
  });

  factory ReceiveMessageModel.fromJson(Map<String, dynamic> json) =>
      ReceiveMessageModel(
        message: json["message"],
        createdAt: json["createdAt"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        replyMessage: ReplyMessage.fromJson(json["reply_message"]),
        reaction: Reaction.fromJson(json["reaction"]),
        messageType: json["message_type"],
        voiceMessageDuration: json["voice_message_duration"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "createdAt": createdAt,
        "senderId": senderId,
        "receiverId": receiverId,
        "reply_message": replyMessage?.toJson(),
        "reaction": reaction?.toJson(),
        "message_type": messageType,
        "voice_message_duration": voiceMessageDuration,
        "status": status,
      };
}

class Reaction {
  List<String> reactions;
  List<String> reactedUserIds;

  Reaction({
    required this.reactions,
    required this.reactedUserIds,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        reactions: List<String>.from(json["reactions"].map((x) => x)),
        reactedUserIds: List<String>.from(json["reactedUserIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "reactions": List<dynamic>.from(reactions.map((x) => x)),
        "reactedUserIds": List<dynamic>.from(reactedUserIds.map((x) => x)),
      };
}

class ReplyMessage {
  String message;
  String replyBy;
  String replyTo;
  String messageType;
  String id;
  String voiceMessageDuration;

  ReplyMessage({
    required this.message,
    required this.replyBy,
    required this.replyTo,
    required this.messageType,
    required this.id,
    required this.voiceMessageDuration,
  });

  factory ReplyMessage.fromJson(Map<String, dynamic> json) => ReplyMessage(
        message: json["message"],
        replyBy: json["replyBy"],
        replyTo: json["replyTo"],
        messageType: json["message_type"],
        id: json["id"],
        voiceMessageDuration: json["voiceMessageDuration"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "replyBy": replyBy,
        "replyTo": replyTo,
        "message_type": messageType,
        "id": id,
        "voiceMessageDuration": voiceMessageDuration,
      };
}

class MessageModel {
  MessageModel({required this.text, required this.attachments});
  late final String text;
  late final List<String> attachments;

  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    attachments = List.castFrom<dynamic, String>(json['attachments']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['attachments'] = attachments;
    return _data;
  }
}
