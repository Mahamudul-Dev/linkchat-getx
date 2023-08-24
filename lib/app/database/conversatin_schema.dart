import 'package:objectbox/objectbox.dart';

@Entity()
class ConversationSchema {
  @Id()
  int objectId;
  String name;
  String receiverServerId;
  String creatorServerId;


  final participant = ToMany<ChatParticipant>();
  final messages = ToMany<Message>();
  final receiver = ToOne<ChatParticipant>();
  final sender = ToOne<ChatParticipant>();


  ConversationSchema({
    this.objectId = 0,
    required this.name,
    required this.receiverServerId,
    required this.creatorServerId,
  });
}

@Entity()
class ChatParticipant {
  @Id()
  int objectId;
  String serverId;
  String uid;
  String name;
  String photo;
  String country;

  @Backlink('participant')
  final conversation = ToMany<ConversationSchema>();

  final message = ToMany<Message>();

  ChatParticipant(
      {this.objectId = 0,
      required this.serverId,
      required this.uid,
      required this.name,
      required this.photo,
      required this.country});
}

@Entity()
class Message {
  @Id()
  int objectId;
  String message;
  List<String> attachments;
  String receiverId;
  String senderServerId;
  @Property(type: PropertyType.date)
  DateTime timestamp;
  final sender = ToOne<ChatParticipant>();
  final conversation = ToOne<ConversationSchema>();

  Message({
    this.objectId = 0,
    required this.message,
    required this.attachments,
    required this.receiverId,
    required this.senderServerId,
    required this.timestamp,
  });
}
