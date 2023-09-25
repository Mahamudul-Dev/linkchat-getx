import 'package:objectbox/objectbox.dart';

import 'conversatin_schema.dart';

@Entity()
class RoomEntity {
  // ObjectBox ID is automatically generated for each entity.
  int id;

  // Fields from your Room model
  String groupId;
  String creatorId;
  String groupName;
  String groupImage;
  int joinCode;

  final messages = ToMany<RoomMessageSchema>();

  RoomEntity({
    this.id = 0,
    required this.groupId,
    required this.creatorId,
    required this.groupName,
    required this.groupImage,
    required this.joinCode,
  });
}

@Entity()
class RoomMemberSchema {
  @Id()
  int objectId;
  String serverId;
  String name;
  String photo;

  @Backlink('sender')
  final roomMessageSchema = ToMany<RoomMessageSchema>();

  RoomMemberSchema(
      {this.objectId = 0,
      required this.serverId,
      required this.name,
      required this.photo});
}

@Entity()
class RoomMessageSchema {
  @Id(assignable: true)
  int id; // Primary key
  String? message;
  String? createdAt;
  String? senderId;
  String? roomId;

  final sender = ToOne<RoomMemberSchema>();
  final room = ToOne<RoomEntity>();
  final replyMessage = ToOne<ReplyMessage>();
  final reactions = ToOne<ReactionSchema>();

  String? messageType;
  String? voiceMessageDuration;
  String? status;

  RoomMessageSchema({
    this.id = 0,
    this.message,
    this.createdAt,
    this.senderId,
    this.roomId,
    this.messageType,
    this.voiceMessageDuration,
    this.status,
  });
}
