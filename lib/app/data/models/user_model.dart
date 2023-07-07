class UserModel {
  int id;
  int uid;
  String userName;
  String userEmail;
  String? userPhone;
  String userProfilePic;
  String? tagline;
  String? bio;
  String? dob;
  String? gender;
  String? country;
  String? relationshipStatus;
  bool isActive;
  String? lastActive;
  List<UserModel> followers;
  List<UserModel> following;

  UserModel({
    required this.id,
    required this.uid,
    required this.userName,
    required this.userEmail,
    this.userPhone,
    required this.userProfilePic,
    this.tagline,
    this.bio,
    this.dob,
    this.gender,
    this.country,
    this.relationshipStatus,
    required this.isActive,
    this.lastActive,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      uid: json['uid'] as int,
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      userPhone: json['userPhone'] as String,
      userProfilePic: json['userProfilePic'] as String,
      tagline: json['tagline'] as String,
      bio: json['bio'] as String,
      dob: json['dob'] as String,
      gender: json['gender'] as String,
      country: json['country'] as String,
      relationshipStatus: json['relationshipStatus'] as String,
      isActive: json['isActive'] as bool,
      lastActive: json['lastActive'] as String,
      followers: (json['followers'] as List<dynamic>)
          .map((follower) => UserModel.fromJson(follower))
          .toList(),
      following: (json['following'] as List<dynamic>)
          .map((follow) => UserModel.fromJson(follow))
          .toList(),
    );
  }
}
