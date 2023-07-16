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
  int? uid;
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
  List<FollowerModel>? followers;
  List<FollowerModel>? following;
  String? createdAt;
  String? updateTime;
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
        this.followers,
        this.following,
        this.createdAt,
        this.updateTime,
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
    if (json['followers'] != null) {
      followers = <FollowerModel>[];
      json['followers'].forEach((v) {
        followers!.add(FollowerModel.fromJson(v));
      });
    }
    if (json['following'] != null) {
      following = <FollowerModel>[];
      json['following'].forEach((v) {
        following!.add(FollowerModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updateTime = json['updateTime'];
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
    if (followers != null) {
      data['followers'] = followers!.map((v) => v.toJson()).toList();
    }
    if (following != null) {
      data['following'] = following!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updateTime'] = updateTime;
    data['__v'] = iV;
    return data;
  }
}

class FollowerModel {
  String? sId;
  String? userName;
  String? profilePic;
  int? uid;
  String? country;
  bool? isActive;
  int? iV;

  FollowerModel(
      {this.sId,
        this.userName,
        this.profilePic,
        this.uid,
        this.country,
        this.isActive,
        this.iV});

  FollowerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePic = json['profilePic'];
    uid = json['uid'];
    country = json['country'];
    isActive = json['isActive'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['profilePic'] = profilePic;
    data['uid'] = uid;
    data['country'] = country;
    data['isActive'] = isActive;
    data['__v'] = iV;
    return data;
  }
}
