import 'package:objectbox/objectbox.dart';


@Entity()
class Follow {
  @Id()
  int objectId;
  String serverId;
  int uid;
  String name;
  String photo;
  String country;
  bool isActive;

  final profile = ToOne<Profile>();

  Follow({
    this.objectId = 0,
    required this.serverId,
    required this.uid,
    required this.name,
    required this.photo,
    required this.country,
    required this.isActive
  });
}


@Entity()
class Profile {
  @Id()
  int objectId;
  String serverId;
  int uid;
  String name;
  String photo;
  String tagline;
  String dob;
  String email;
  String phone;
  String country;
  String relationshipStatus;
  String gender;
  bool isActive;
  String lastActive;
  @Property(type: PropertyType.date)
  DateTime createdAt;
  @Backlink('profile')
  final followers = ToMany<Follow>();
  @Backlink('profile')
  final following = ToMany<Follow>();

  Profile(
      {this.objectId = 0,
        required this.serverId,
        required this.uid,
        required this.name,
        required this.photo,
        required this.tagline,
        required this.dob,
        required this.email,
        required this.phone,
        required this.country,
        required this.relationshipStatus,
        required this.gender,
        required this.isActive,
        required this.lastActive,
        required this.createdAt});
}
