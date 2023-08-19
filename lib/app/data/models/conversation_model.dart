
import 'package:get/get.dart';

class ConversationModel {
  final String conversationTitle;
  final RxList<MessageModel?> messages;
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



class MessageModel {
  MessageModel({
    required this.content,
    required this.attachments,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
  });
  String? content;
  List<String?>? attachments;
  List<Users?>? users;
  String? createdAt;
  String? updatedAt;
  
  MessageModel.fromJson(Map<String, dynamic> json){
    content = json['content'];
    attachments = List.castFrom<String, String?>(json['attachments']);
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content;
    _data['attachments'] = attachments;
    _data['users'] = users?.map((e)=>e?.toJson()).toList();
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class Users {
  Users({
    required this.sender,
    required this.receiver,
  });
  late final String sender;
  late final String receiver;
  
  Users.fromJson(Map<String, dynamic> json){
    sender = json['sender'];
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sender'] = sender;
    _data['receiver'] = receiver;
    return _data;
  }
}