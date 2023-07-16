import 'package:objectbox/objectbox.dart';

@Entity()
class CallParticipant {
  @Id()
  int objectId;
  String serverId;
  String uid;
  String name;
  bool isHost;

  final call = ToOne<Call>();

  CallParticipant(
      {this.objectId = 0,
        required this.serverId,
      required this.uid,
      required this.name,
      required this.isHost});
}

@Entity()
class Call {
  @Id()
  int objectId;
  String callId;

  @Backlink('call')
  final participants = ToMany<CallParticipant>();

  @Property(type: PropertyType.date)
  DateTime startTime;
  @Property(type: PropertyType.date)
  DateTime endTime;
  int duration;
  String mediaType;
  String status;

  Call({
    this.objectId = 0,
    required this.callId,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.mediaType,
    required this.status,
  });
}
