import 'package:objectbox/objectbox.dart';

@Entity()
class RoomParticipantSchema {
  @Id()
  int objectId;
  String serverId;
  String uid;
  String name;
  String photo;
  String tagline;
  String gender;
  bool isActive;
  String lastActive;

  final room = ToOne<RoomSchema>();
  @Backlink('sender')
  final roomMessage = ToMany<RoomMessage>();

  RoomParticipantSchema({
    this.objectId = 0,
    required this.serverId,
    required this.uid,
    required this.name,
    required this.photo,
    required this.tagline,
    required this.gender,
    required this.isActive,
    required this.lastActive,
  });
}

@Entity()
class RoomSchema {
  @Id()
  int objectId;
  String groupId;
  String name;
  String photo;
  @Property(type: PropertyType.date)
  DateTime createdAt;
  @Backlink('room')
  final participants = ToMany<RoomParticipantSchema>();
  @Backlink('room')
  final roomMessage = ToMany<RoomMessage>();

  RoomSchema(
      {this.objectId = 0,
      required this.groupId,
      required this.name,
      required this.photo,
      required this.createdAt});
}

@Entity()
class RoomMessage {
  @Id()
  int objectId;
  String content;
  List<String> attachments;
  String receiverId;
  String senderServerId;
  @Property(type: PropertyType.date)
  DateTime timestamp;
  final sender = ToOne<RoomParticipantSchema>();
  final room = ToOne<RoomSchema>();

  RoomMessage({
    this.objectId = 0,
    required this.content,
    required this.attachments,
    required this.receiverId,
    required this.senderServerId,
    required this.timestamp,
  });
}
