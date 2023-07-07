import 'package:objectbox/objectbox.dart';

@Entity()
class Call {
  @Id()
  int id;
  String callId;
  @Backlink()
  final participants = ToMany<Participant>();

  @Property(type: PropertyType.date)
  DateTime startTime;
  @Property(type: PropertyType.date)
  DateTime endTime;
  int duration;
  String mediaType;
  String status;

  Call({
    required this.id,
    required this.callId,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.mediaType,
    required this.status,
  });
}

@Entity()
class Participant {
  @Id()
  int id;
  String uid;
  String name;
  bool isHost;

  @Property(type: PropertyType.byteVector)
  List<int> callId;

  Participant(
      {required this.id,
      required this.uid,
      required this.name,
      required this.isHost,
      required this.callId});
}
