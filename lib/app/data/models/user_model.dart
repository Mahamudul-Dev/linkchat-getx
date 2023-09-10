import 'dart:convert';

class UserModel {
  String status;
  String message;
  List<FullProfile> data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    data: List<FullProfile>.from(json["data"].map((x) => FullProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FullProfile {
  String id;
  String userName;
  String uid;
  String email;
  String password;
  String userPhone;
  String profilePic;
  String tagLine;
  String bio;
  String gender;
  String country;
  DateTime dob;
  String relationshipStatus;
  String lastActive;
  bool isActive;
  List<Linked> linked;
  List<ShortProfile> followers;
  List<ShortProfile> following;
  List<ShortProfile> pendingLink;
  String createdAt;
  DateTime updatedAt;
  int v;

  FullProfile({
    required this.id,
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

  factory FullProfile.fromRawJson(String str) => FullProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FullProfile.fromJson(Map<String, dynamic> json) => FullProfile(
    id: json["_id"],
    userName: json["userName"],
    uid: json["uid"],
    email: json["email"],
    password: json["password"],
    userPhone: json["userPhone"],
    profilePic: json["profilePic"],
    tagLine: json["tagLine"],
    bio: json["bio"],
    gender: json["gender"],
    country: json["country"],
    dob: DateTime.parse(json["dob"]),
    relationshipStatus: json["relationshipStatus"],
    lastActive: json["lastActive"],
    isActive: json["isActive"],
    linked: List<Linked>.from(json["linked"].map((x) => Linked.fromJson(x))),
    followers: List<ShortProfile>.from(json["followers"].map((x) => ShortProfile.fromJson(x))),
    following: List<ShortProfile>.from(json["following"].map((x) => ShortProfile.fromJson(x))),
    pendingLink: List<ShortProfile>.from(json["pendingLink"].map((x) => ShortProfile.fromJson(x))),
    createdAt: json["createdAt"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userName": userName,
    "uid": uid,
    "email": email,
    "password": password,
    "userPhone": userPhone,
    "profilePic": profilePic,
    "tagLine": tagLine,
    "bio": bio,
    "gender": gender,
    "country": country,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "relationshipStatus": relationshipStatus,
    "lastActive": lastActive,
    "isActive": isActive,
    "linked": List<dynamic>.from(linked.map((x) => x.toJson())),
    "followers": List<dynamic>.from(followers.map((x) => x)),
    "following": List<dynamic>.from(following.map((x) => x.toJson())),
    "pendingLink": List<dynamic>.from(pendingLink.map((x) => x.toJson())),
    "createdAt": createdAt,
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class ShortProfile {
  String id;
  String userName;
  String email;
  String profilePic;
  String tagLine;
  String bio;
  String uid;
  String country;
  bool isActive;

  ShortProfile({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePic,
    required this.tagLine,
    required this.bio,
    required this.uid,
    required this.country,
    required this.isActive,
  });

  factory ShortProfile.fromRawJson(String str) => ShortProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShortProfile.fromJson(Map<String, dynamic> json) => ShortProfile(
    id: json["_id"],
    userName: json["userName"],
    email: json["email"],
    profilePic: json["profilePic"],
    tagLine: json["tagLine"],
    bio: json["bio"],
    uid: json["uid"],
    country: json["country"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userName": userName,
    "email": email,
    "profilePic": profilePic,
    "tagLine": tagLine,
    "bio": bio,
    "uid": uid,
    "country": country,
    "isActive": isActive,
  };
}

class Linked {
  String id;

  Linked({
    required this.id,
  });

  factory Linked.fromRawJson(String str) => Linked.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Linked.fromJson(Map<String, dynamic> json) => Linked(
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
  };
}


class GetMultipleProfileModel {
  String status;
  String message;
  List<ShortProfile> linkedList;

  GetMultipleProfileModel({
    required this.status,
    required this.message,
    required this.linkedList,
  });

  factory GetMultipleProfileModel.fromRawJson(String str) => GetMultipleProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetMultipleProfileModel.fromJson(Map<String, dynamic> json) => GetMultipleProfileModel(
    status: json["status"],
    message: json["message"],
    linkedList: List<ShortProfile>.from(json["linkedList"].map((x) => ShortProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "linkedList": List<ShortProfile>.from(linkedList.map((x) => x.toJson())),
  };
}