import 'package:objectbox/objectbox.dart';

@Entity()
class ConversationSchema {
  @Id()
  int objectId;
  String name;
  String receiverServerId;


  final participant = ToMany<ChatParticipant>();
  final messages = ToMany<Message>();
  final receiver = ToOne<ChatParticipant>();
  final sender = ToOne<ChatParticipant>();


  ConversationSchema({
    this.objectId = 0,
    required this.name,
    required this.receiverServerId,
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
  String content;
  List<String> attachment;
  String receiverId;
  @Property(type: PropertyType.date)
  DateTime timestamp;

  final sender = ToOne<ChatParticipant>();
  final conversation = ToOne<ConversationSchema>();

  Message({
    this.objectId = 0,
    required this.content,
    required this.attachment,
    required this.receiverId,
    required this.timestamp,
  });
}
