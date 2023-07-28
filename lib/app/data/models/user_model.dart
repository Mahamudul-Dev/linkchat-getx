class UserModel {
  String? status;
  String? message;
  List<Data>? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? userName;
  String? uid;
  String? profilePic;
  String? email;
  String? password;
  String? userPhone;
  String? tagLine;
  String? bio;
  String? gender;
  String? country;
  String? dob;
  String? relationshipStatus;
  String? lastActive;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  List<FollowerModel>? linked;
  List<FollowerModel>? followers;
  List<FollowerModel>? following;
  List<FollowerModel>? pendingFollowers;
  List<FollowerModel>? pendingFollowing;
  int? iV;

  Data(
      {this.sId,
        this.userName,
        this.uid,
        this.profilePic,
        this.email,
        this.password,
        this.userPhone,
        this.tagLine,
        this.bio,
        this.gender,
        this.country,
        this.dob,
        this.relationshipStatus,
        this.lastActive,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.linked,
        this.followers,
        this.following,
        this.pendingFollowers,
        this.pendingFollowing,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    uid = json['uid'];
    profilePic = json['profilePic'];
    email = json['email'];
    password = json['password'];
    userPhone = json['userPhone'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    gender = json['gender'];
    country = json['country'];
    dob = json['dob'];
    relationshipStatus = json['relationshipStatus'];
    lastActive = json['lastActive'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['linked'] != null) {
      linked = <FollowerModel>[];
      json['linked'].forEach((v) {
        linked!.add(FollowerModel.fromJson(v));
      });
    } else {
      linked = [];
    }
    if (json['followers'] != null) {
      followers = <FollowerModel>[];
      json['followers'].forEach((v) {
        followers!.add(FollowerModel.fromJson(v));
      });
    } else {
      followers = [];
    }
    if (json['following'] != null) {
      following = <FollowerModel>[];
      json['following'].forEach((v) {
        following!.add(FollowerModel.fromJson(v));
      });
    } else {
      following = [];
    }
    if (json['pendingFollowers'] != null) {
      pendingFollowers = <FollowerModel>[];
      json['pendingFollowers'].forEach((v) {
        pendingFollowers!.add(FollowerModel.fromJson(v));
      });
    } else {
      pendingFollowers = [];
    }
    if (json['pendingFollowing'] != null) {
      pendingFollowing = <FollowerModel>[];
      json['pendingFollowing'].forEach((v) {
        pendingFollowing!.add(FollowerModel.fromJson(v));
      });
    } else {
      pendingFollowing = [];
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['uid'] = uid;
    data['profilePic'] = profilePic;
    data['email'] = email;
    data['password'] = password;
    data['userPhone'] = userPhone;
    data['tagLine'] = tagLine;
    data['bio'] = bio;
    data['gender'] = gender;
    data['country'] = country;
    data['dob'] = dob;
    data['relationshipStatus'] = relationshipStatus;
    data['lastActive'] = lastActive;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (followers != null) {
      data['followers'] = followers!.map((v) => v.toJson()).toList();
    }
    if (following != null) {
      data['following'] = following!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}


class FollowerModel {
  String? sId;
  String? userName;
  String? profilePic;
  String? tagLine;
  String? bio;
  int? uid;
  String? country;
  bool? isActive;

  FollowerModel(
      {this.sId,
        this.userName,
        this.profilePic,
        this.tagLine,
        this.bio,
        this.uid,
        this.country,
        this.isActive});

  FollowerModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['profilePic'] = profilePic;
    data['tagLine'] = tagLine;
    data['bio'] = bio;
    data['uid'] = uid;
    data['country'] = country;
    data['isActive'] = isActive;
    return data;
  }
}
