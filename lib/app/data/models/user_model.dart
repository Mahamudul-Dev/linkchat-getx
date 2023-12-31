class UserModel {
  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final List<Profile> data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Profile.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Profile {
  Profile({
    required this.sId,
    required this.userName,
    required this.uid,
    required this.email,
    required this.password,
    required this.userPhone,
    required this.profilePic,
    required this.tagLine,
    required this.bio,
    required this.gender,
    required this.country,
    required this.dob,
    required this.relationshipStatus,
    required this.lastActive,
    required this.isActive,
    required this.linked,
    required this.followers,
    required this.following,
    required this.pendingLink,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
  late final String sId;
  late final String userName;
  late final String uid;
  late final String email;
  late final String password;
  late final String userPhone;
  late final String profilePic;
  late final String tagLine;
  late final String bio;
  late final String gender;
  late final String country;
  late final String dob;
  late final String relationshipStatus;
  late final String lastActive;
  late final bool isActive;
  late final List<ShortProfileModel> linked;
  late final List<ShortProfileModel> followers;
  late final List<ShortProfileModel> following;
  late final List<ShortProfileModel> pendingLink;
  late final String createdAt;
  late final String updatedAt;
  late final int v;

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    uid = json['uid'];
    email = json['email'];
    password = json['password'];
    userPhone = json['userPhone'];
    profilePic = json['profilePic'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    gender = json['gender'];
    country = json['country'];
    dob = json['dob'];
    relationshipStatus = json['relationshipStatus'];
    lastActive = json['lastActive'];
    isActive = json['isActive'];
    linked = List.from(json['linked'])
        .map((e) => ShortProfileModel.fromJson(e))
        .toList();
    followers = List.from(json['followers'])
        .map((e) => ShortProfileModel.fromJson(e))
        .toList();
    following = List.from(json['following'])
        .map((e) => ShortProfileModel.fromJson(e))
        .toList();
    pendingLink = List.from(json['pendingLink'])
        .map((e) => ShortProfileModel.fromJson(e))
        .toList();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sId;
    _data['userName'] = userName;
    _data['uid'] = uid;
    _data['email'] = email;
    _data['password'] = password;
    _data['userPhone'] = userPhone;
    _data['profilePic'] = profilePic;
    _data['tagLine'] = tagLine;
    _data['bio'] = bio;
    _data['gender'] = gender;
    _data['country'] = country;
    _data['dob'] = dob;
    _data['relationshipStatus'] = relationshipStatus;
    _data['lastActive'] = lastActive;
    _data['isActive'] = isActive;
    _data['linked'] = linked;
    _data['followers'] = followers.map((e) => e.toJson()).toList();
    _data['following'] = following.map((e) => e.toJson()).toList();
    _data['pendingLink'] = pendingLink.map((e) => e.toJson()).toList();
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = v;
    return _data;
  }
}

class ShortProfileModel {
  ShortProfileModel({
    required this.sId,
    required this.uid,
    required this.userName,
    required this.profilePic,
    required this.tagLine,
    required this.bio,
    required this.country,
    required this.isActive,
  });
  late final String sId;
  late final String uid;
  late final String userName;
  late final String profilePic;
  late final String tagLine;
  late final String bio;
  late final String country;
  late final bool isActive;

  ShortProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    userName = json['userName'];
    profilePic = json['profilePic'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    country = json['country'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sid'] = sId;
    _data['uid'] = uid;
    _data['userName'] = userName;
    _data['profilePic'] = profilePic;
    _data['tagLine'] = tagLine;
    _data['bio'] = bio;
    _data['country'] = country;
    _data['isActive'] = isActive;
    return _data;
  }
}

class GetMultipleProfileModel {
  String status;
  String message;
  List<ShortProfileModel> profiles;

  GetMultipleProfileModel({
    required this.status,
    required this.message,
    required this.profiles,
  });

  factory GetMultipleProfileModel.fromJson(Map<String, dynamic> json) =>
      GetMultipleProfileModel(
        status: json["status"],
        message: json["message"],
        profiles: List<ShortProfileModel>.from(
            json["linkedList"].map((x) => ShortProfileModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "linkedList":
            List<ShortProfileModel>.from(profiles.map((x) => x.toJson())),
      };
}
