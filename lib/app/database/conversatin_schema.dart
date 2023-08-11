import 'package:objectbox/objectbox.dart';

@Entity()
class ConversationSchema {
  @Id()
  int objectId;
  String name;

  final participant = ToMany<ChatParticipant>();

  ConversationSchema({this.objectId = 0, required this.name});
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
  String? groupId;
  @Property(type: PropertyType.date)
  DateTime timestamp;

  final sender = ToOne<ChatParticipant>();

  Message({
    this.objectId = 0,
    required this.content,
    required this.attachment,
    required this.receiverId,
    this.groupId,
    required this.timestamp,
  });
}
