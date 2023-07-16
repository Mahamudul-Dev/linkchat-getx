import 'package:objectbox/objectbox.dart';

@Entity()
class Participant {
  @Id()
  int objectId;
  String serverId;
  int uid;
  String name;
  String photo;
  String tagline;
  String gender;
  bool isActive;
  String lastActive;

  final group = ToOne<Group>();

  Participant({
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
class Group {
  @Id()
  int objectId;
  String groupId;
  String name;
  String photo;
  @Property(type: PropertyType.date)
  DateTime createdAt;
  @Backlink('group')
  final participants = ToMany<Participant>();

  Group(
      {this.objectId = 0,
        required this.groupId,
        required this.name,
        required this.photo,
        required this.createdAt});
}