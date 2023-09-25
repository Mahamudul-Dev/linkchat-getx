import 'package:objectbox/objectbox.dart';

@Entity()
class ConversationSchema {
  @Id()
  int objectId;
  String name;
  String receiverServerId;
  String creatorServerId;

  final participant = ToMany<ChatParticipantSchema>();
  final messages = ToMany<MessageSchema>();
  final receiver = ToOne<ChatParticipantSchema>();
  final sender = ToOne<ChatParticipantSchema>();

  ConversationSchema({
    this.objectId = 0,
    required this.name,
    required this.receiverServerId,
    required this.creatorServerId,
  });
}

@Entity()
class ChatParticipantSchema {
  @Id()
  int objectId;
  String serverId;
  String uid;
  String name;
  String photo;
  String country;

  @Backlink('participant')
  final conversation = ToMany<ConversationSchema>();

  @Backlink('sender')
  final messageSchema = ToMany<MessageSchema>();

  ChatParticipantSchema(
      {this.objectId = 0,
      required this.serverId,
      required this.uid,
      required this.name,
      required this.photo,
      required this.country});
}

@Entity()
class MessageSchema {
  @Id(assignable: true)
  int id; // Primary key
  String? message;
  String? createdAt;
  String? senderId;
  String? receiverId;

  final sender = ToOne<ChatParticipantSchema>();
  final conversation = ToOne<ConversationSchema>();
  final replyMessage = ToOne<ReplyMessage>();
  final reactions = ToOne<ReactionSchema>();

  String? messageType;
  String? voiceMessageDuration;
  String? status;

  MessageSchema({
    this.id = 0,
    this.message,
    this.createdAt,
    this.senderId,
    this.receiverId,
    this.messageType,
    this.voiceMessageDuration,
    this.status,
  });
}

@Entity()
class ReactionSchema {
  @Id(assignable: true)
  int id; // Primary key
  List<String>? reactions;
  List<String>? reactedUserIds;

  final messageSchema = ToOne<MessageSchema>();

  ReactionSchema({
    this.id = 0,
    required this.reactions,
    required this.reactedUserIds,
  });
}

@Entity()
class ReplyMessage {
  @Id(assignable: true)
  int id = 0; // Primary key
  String? message;
  String? replyBy;
  String? replyTo;
  String? messageType;
  String? voiceMessageDuration;

  final messageSchema = ToOne<MessageSchema>();

  ReplyMessage({
    this.id = 0,
    this.message,
    this.replyBy,
    this.replyTo,
    this.messageType,
    this.voiceMessageDuration,
  });
}
