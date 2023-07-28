import 'package:objectbox/objectbox.dart';


@Entity()
class ProfileSchema {
  @Id()
  int objectId;
  String serverId;
  String? uid;
  String name;
  String? photo;
  String? tagline;
  String? bio;
  String? dob;
  String email;
  String? phone;
  String? country;
  int? followersCount;
  int? followingCounts;
  int? linkedCounts;
  String? relationshipStatus;
  String? gender;
  bool isActive;
  String? lastActive;
  String? createdAt;

  ProfileSchema(
      {this.objectId = 0,
        required this.serverId,
        this.uid,
        required this.name,
        this.photo,
        this.tagline,
        this.bio,
        this.dob,
        required this.email,
        this.phone,
        this.country,
        this.followersCount,
        this.followingCounts,
        this.linkedCounts,
        this.relationshipStatus,
        this.gender,
        required this.isActive,
        this.lastActive,
        required this.createdAt});
}
