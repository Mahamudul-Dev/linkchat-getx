class MatchModel {
  MatchModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final List<Data> data;

  MatchModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.pendingLink,
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
  late final List<dynamic> linked;
  late final List<Followers> followers;
  late final List<Following> following;
  late final String createdAt;
  late final String updatedAt;
  late final int v;
  late final List<PendingLink> pendingLink;

  Data.fromJson(Map<String, dynamic> json){
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
    linked = List.castFrom<dynamic, dynamic>(json['linked']);
    followers = List.from(json['followers']).map((e)=>Followers.fromJson(e)).toList();
    following = List.from(json['following']).map((e)=>Following.fromJson(e)).toList();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    pendingLink = List.from(json['pendingLink']).map((e)=>PendingLink.fromJson(e)).toList();
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
    _data['followers'] = followers.map((e)=>e.toJson()).toList();
    _data['following'] = following.map((e)=>e.toJson()).toList();
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = v;
    _data['pendingLink'] = pendingLink.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Followers {
  Followers({
    required this.sId,
    required this.userName,
    required this.profilePic,
    required this.tagLine,
    required this.bio,
    required this.uid,
    required this.country,
    required this.isActive,
  });
  late final String sId;
  late final String userName;
  late final String profilePic;
  late final String tagLine;
  late final String bio;
  late final String uid;
  late final String country;
  late final bool? isActive;

  Followers.fromJson(Map<String, dynamic> json){
    sId = json['_id'];
    userName = json['userName'];
    profilePic = json['profilePic'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    uid = json['uid'];
    country = json['country'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sId;
    _data['userName'] = userName;
    _data['profilePic'] = profilePic;
    _data['tagLine'] = tagLine;
    _data['bio'] = bio;
    _data['uid'] = uid;
    _data['country'] = country;
    _data['isActive'] = isActive;
    return _data;
  }
}

class Following {
  Following({
    required this.sId,
    required this.userName,
    required this.email,
    required this.profilePic,
    required this.tagLine,
    required this.bio,
    required this.uid,
    required this.country,
    required this.isActive,
  });
  late final String sId;
  late final String userName;
  late final String email;
  late final String profilePic;
  late final String tagLine;
  late final String bio;
  late final String uid;
  late final String country;
  late final bool isActive;

  Following.fromJson(Map<String, dynamic> json){
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    profilePic = json['profilePic'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    uid = json['uid'];
    country = json['country'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sId;
    _data['userName'] = userName;
    _data['email'] = email;
    _data['profilePic'] = profilePic;
    _data['tagLine'] = tagLine;
    _data['bio'] = bio;
    _data['uid'] = uid;
    _data['country'] = country;
    _data['isActive'] = isActive;
    return _data;
  }
}

class PendingLink {
  PendingLink({
    required this.sId,
    required this.userName,
    required this.email,
    required this.profilePic,
    required this.tagLine,
    required this.bio,
    required this.uid,
    required this.country,
    required this.isActive,
  });
  late final String sId;
  late final String userName;
  late final String email;
  late final String profilePic;
  late final String tagLine;
  late final String bio;
  late final String uid;
  late final String country;
  late final bool isActive;

  PendingLink.fromJson(Map<String, dynamic> json){
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    profilePic = json['profilePic'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    uid = json['uid'];
    country = json['country'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sId;
    _data['userName'] = userName;
    _data['email'] = email;
    _data['profilePic'] = profilePic;
    _data['tagLine'] = tagLine;
    _data['bio'] = bio;
    _data['uid'] = uid;
    _data['country'] = country;
    _data['isActive'] = isActive;
    return _data;
  }
}