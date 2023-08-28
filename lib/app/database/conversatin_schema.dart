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
  @Id()
  int objectId;
  String content;
  List<String> attachments;
  String receiverId;
  String senderServerId;
  @Property(type: PropertyType.date)
  DateTime timestamp;
  final sender = ToOne<ChatParticipantSchema>();
  final conversation = ToOne<ConversationSchema>();

  MessageSchema({
    this.objectId = 0,
    required this.content,
    required this.attachments,
    required this.receiverId,
    required this.senderServerId,
    required this.timestamp,
  });
}
