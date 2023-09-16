import 'package:get/get.dart';

class ConversationModel {
  final String conversationTitle;
  final RxList<MessageModel?> messages;
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

class MessageModel {
  final String? id;
  final String? message;
  final String? createdAt;
  final String? senderId;
  final String? receiverId;
  final MessageReply? replyMessage;
  final ReactionModel? reaction;
  final String? messageType;
  final String? voiceMessageDuration;
  final String? status;

  MessageModel({
    this.id,
    this.message,
    this.createdAt,
    this.senderId,
    this.receiverId,
    this.replyMessage,
    this.reaction,
    this.messageType,
    this.voiceMessageDuration,
    this.status,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        message: json["message"],
        createdAt: json["createdAt"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
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
        "id": id,
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

// class MessageModel {
//   MessageModel({
//     required this.text,
//     required this.attachments
//   });
//   late final String text;
//   late final List<String> attachments;
  
//   MessageModel.fromJson(Map<String, dynamic> json){
//     text = json['text'];
//     attachments = List.castFrom<dynamic, String>(json['attachments']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['text'] = text;
//     _data['attachments'] = attachments;
//     return _data;
//   }
// }
