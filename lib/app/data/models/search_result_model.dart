class SearchResultModel {
  SearchResultModel({
     this.status,
     this.message,
     this.query,
     this.linked,
     this.followers,
     this.global,
  });
  String? status;
  String? message;
  String? query;
  List<Linked>? linked;
  List<Followers>? followers;
  List<Global>? global;

  SearchResultModel.fromJson(Map<String?, dynamic> json){
    status = json['status'];
    message = json['message'];
    query = json['query'];
    linked = List.from(json['linked']).map((e)=>Linked.fromJson(e)).toList();
    followers = List.from(json['followers']).map((e)=>Followers.fromJson(e)).toList();
    global = List.from(json['global']).map((e)=>Global.fromJson(e)).toList();
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['query'] = query;
    _data['linked'] = linked?.map((e)=>e.toJson()).toList();
    _data['followers'] = followers?.map((e)=>e.toJson()).toList();
    _data['global'] = global?.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Linked {
  Linked({
    this.sId,
    this.userName,
    this.uid,
    this.email,
    this.profilePic,
    this.tagLine,
    this.bio,
    this.country,
    this.isActive,
  });
  String? sId;
  String? userName;
  String? uid;
  String? email;
  String? profilePic;
  String? tagLine;
  String? bio;
  String? country;
  bool? isActive;

  Linked.fromJson(Map<String?, dynamic> json){
    sId = json['_id'];
    userName = json['userName'];
    uid = json['uid'];
    email = json['email'];
    profilePic = json['profilePic'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    country = json['country'];
    isActive = json['isActive'];
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['_id'] = sId;
    _data['userName'] = userName;
    _data['uid'] = uid;
    _data['email'] = email;
    _data['profilePic'] = profilePic;
    _data['tagLine'] = tagLine;
    _data['bio'] = bio;
    _data['country'] = country;
    _data['isActive'] = isActive;
    return _data;
  }
}

class Followers {
  Followers({
    this.sId,
    this.userName,
    this.uid,
    this.email,
    this.profilePic,
    this.tagLine,
    this.bio,
    this.country,
    this.isActive,
  });
  String? sId;
  String? userName;
  String? uid;
  String? email;
  String? profilePic;
  String? tagLine;
  String? bio;
  String? country;
  bool? isActive;

  Followers.fromJson(Map<String?, dynamic> json){
    sId = json['_id'];
    userName = json['userName'];
    uid = json['uid'];
    email = json['email'];
    profilePic = json['profilePic'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    country = json['country'];
    isActive = json['isActive'];
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['_id'] = sId;
    _data['userName'] = userName;
    _data['uid'] = uid;
    _data['email'] = email;
    _data['profilePic'] = profilePic;
    _data['tagLine'] = tagLine;
    _data['bio'] = bio;
    _data['country'] = country;
    _data['isActive'] = isActive;
    return _data;
  }
}

class Global {
  Global({
     this.sId,
     this.userName,
     this.uid,
     this.email,
     this.profilePic,
     this.tagLine,
     this.bio,
     this.country,
     this.isActive,
  });
  String? sId;
  String? userName;
  String? uid;
  String? email;
  String? profilePic;
  String? tagLine;
  String? bio;
  String? country;
  bool? isActive;

  Global.fromJson(Map<String?, dynamic> json){
    sId = json['_id'];
    userName = json['userName'];
    uid = json['uid'];
    email = json['email'];
    profilePic = json['profilePic'];
    tagLine = json['tagLine'];
    bio = json['bio'];
    country = json['country'];
    isActive = json['isActive'];
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['_id'] = sId;
    _data['userName'] = userName;
    _data['uid'] = uid;
    _data['email'] = email;
    _data['profilePic'] = profilePic;
    _data['tagLine'] = tagLine;
    _data['bio'] = bio;
    _data['country'] = country;
    _data['isActive'] = isActive;
    return _data;
  }
}