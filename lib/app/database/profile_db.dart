import 'package:objectbox/objectbox.dart';

@Entity()
class Profile {
  @Id()
  int id;
  int uid;
  String name;
  String photo;
  String tagline;
  String dob;
  String gender;
  bool isActive;
  String lastActive;
  @Backlink()
  final followers = ToMany<Follow>();
  @Backlink()
  final following = ToMany<Follow>();

  Profile(
      {required this.id,
      required this.uid,
      required this.name,
      required this.photo,
      required this.tagline,
      required this.dob,
      required this.gender,
      required this.isActive,
      required this.lastActive});
}

@Entity()
class Follow {
  @Id()
  int id;
  int uid;
  String name;
  String photo;
  String tagline;

  Follow({
    required this.id,
    required this.uid,
    required this.name,
    required this.photo,
    required this.tagline,
  });
}
