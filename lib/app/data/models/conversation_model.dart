
import 'package:get/get.dart';

class ConversationModel {
  final String conversationTitle;
  final RxList<ReceiveMessageModel?> messages;
  final ChatParticipantModel receiver;
  final List<ChatParticipantModel> participant;

  ConversationModel({required this.conversationTitle, required this.messages, required this.receiver, required this.participant});
}

class ChatParticipantModel {
  String serverId;
  String? uid;
  String? name;
  String? photo;
  String? country;

  ChatParticipantModel({required this.serverId, this.uid, this.name, this.photo, this.country});
}



class ReceiveMessageModel {
  ReceiveMessageModel({
    required this.message,
    required this.users,
    required this.sender,
    required this.receiver,
    required this.createdAt,
    required this.updatedAt,
  });
  late final MessageModel message;
  late final List<String> users;
  late final String sender;
  late final String receiver;
  late final String createdAt;
  late final String updatedAt;
  
  ReceiveMessageModel.fromJson(Map<String, dynamic> json){
    message = MessageModel.fromJson(json['message']);
    users = List.castFrom<dynamic, String>(json['users']);
    sender = json['sender'];
    receiver = json['receiver'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message.toJson();
    _data['users'] = users;
    _data['sender'] = sender;
    _data['receiver'] = receiver;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class MessageModel {
  MessageModel({
    required this.text,
    required this.attachments
  });
  late final String text;
  late final List<String> attachments;
  
  MessageModel.fromJson(Map<String, dynamic> json){
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
