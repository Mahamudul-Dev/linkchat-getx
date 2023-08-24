
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
    required this.attachments,
    required this.users,
    required this.sender,
    required this.receiver,
    required this.createdAt,
    required this.updatedAt,
  });
  late final MessageModel message;
  late final List<String> attachments;
  late final List<String> users;
  late final String sender;
  late final String receiver;
  late final String createdAt;
  late final String updatedAt;
  
  ReceiveMessageModel.fromJson(Map<String, dynamic> json){
    message = MessageModel.fromJson(json['message']);
    attachments = List.castFrom<dynamic, String>(json['attachments']);
    users = List.castFrom<dynamic, String>(json['users']);
    sender = json['sender'];
    receiver = json['receiver'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message.toJson();
    _data['attachments'] = attachments;
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
  });
  late final String text;
  
  MessageModel.fromJson(Map<String, dynamic> json){
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    return _data;
  }
}


class SendMessageModel {
  final String message;
  final String from;
  final String to;

  SendMessageModel({
    required this.message,
    required this.from,
    required this.to,
  });
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'from': from,
      'to': to,
    };
  }
}
