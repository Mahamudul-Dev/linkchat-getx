import 'package:objectbox/objectbox.dart';

@Entity()
class Group {
  @Id()
  int id;
  String name;
  String photo;
  @Property(type: PropertyType.date)
  DateTime createdAt;
  @Backlink()
  final participants = ToMany<Participant>();

  Group(
      {required this.id,
      required this.name,
      required this.photo,
      required this.createdAt});
}

@Entity()
class Participant {
  @Id()
  int id;
  int uid;
  String name;
  String photo;
  String tagline;
  String gender;
  bool isActive;
  String lastActive;

  Participant({
    required this.id,
    required this.uid,
    required this.name,
    required this.photo,
    required this.tagline,
    required this.gender,
    required this.isActive,
    required this.lastActive,
  });
}
