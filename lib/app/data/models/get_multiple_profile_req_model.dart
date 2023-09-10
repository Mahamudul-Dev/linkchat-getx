import 'dart:convert';

class GetMultipleProfileReqModel {
  List<String> idList;

  GetMultipleProfileReqModel({
    required this.idList,
  });

  factory GetMultipleProfileReqModel.fromRawJson(String str) => GetMultipleProfileReqModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetMultipleProfileReqModel.fromJson(Map<String, dynamic> json) => GetMultipleProfileReqModel(
    idList: List<String>.from(json["idList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "idList": List<dynamic>.from(idList.map((x) => x)),
  };
}
