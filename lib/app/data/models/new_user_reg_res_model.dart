class NewUserRegResModel {
  NewUser? newUser;
  String? token;

  NewUserRegResModel({this.newUser, this.token});

  NewUserRegResModel.fromJson(Map<String, dynamic> json) {
    newUser =
    json['newUser'] != null ? NewUser.fromJson(json['newUser']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (newUser != null) {
      data['newUser'] = newUser!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class NewUser {
  String? userName;
  int? uid;
  String? email;
  String? password;
  String? country;
  bool? isActive;
  String? sId;
  List? followers;
  List? following;

  NewUser(
      {this.userName,
        this.uid,
        this.email,
        this.password,
        this.country,
        this.isActive,
        this.sId,
        this.followers,
        this.following});

  NewUser.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    uid = json['uid'];
    email = json['email'];
    password = json['password'];
    country = json['country'];
    isActive = json['isActive'];
    sId = json['_id'];
    followers = json['followers'];
    following = json['following'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['uid'] = uid;
    data['email'] = email;
    data['password'] = password;
    data['country'] = country;
    data['isActive'] = isActive;
    data['_id'] = sId;
    if (followers != null) {
      data['followers'] = followers!.map((v) => v.toJson()).toList();
    }
    if (following != null) {
      data['following'] = following!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
