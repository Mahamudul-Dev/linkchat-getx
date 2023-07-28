class EmailLoginResponseModel {
  String? id;
  String? userName;
  String? email;
  String? token;

  EmailLoginResponseModel({this.id, this.userName, this.email, this.token});

  EmailLoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userName = json['userName'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}
