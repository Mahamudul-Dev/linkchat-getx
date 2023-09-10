import 'package:linkchat/app/data/models/user_model.dart';

import 'match_model.dart';

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
  List<ShortProfile>? linked;
  List<ShortProfile>? followers;
  List<ShortProfile>? global;

  SearchResultModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    message = json['message'];
    query = json['query'];
    linked = List.from(json['linked']).map((e) => Linked.fromJson(e)).toList();
    followers =
        List.from(json['followers']).map((e) => Followers.fromJson(e)).toList();
    global = List.from(json['global']).map((e) => Global.fromJson(e)).toList();
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['query'] = query;
    _data['linked'] = linked?.map((e) => e.toJson()).toList();
    _data['followers'] = followers?.map((e) => e.toJson()).toList();
    _data['global'] = global?.map((e) => e.toJson()).toList();
    return _data;
  }
}
