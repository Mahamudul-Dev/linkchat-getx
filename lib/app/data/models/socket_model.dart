class SocketUserModel {
  SocketUserModel({
    required this.userId,
    required this.socketId,
  });
  late final String userId;
  late final String socketId;
  
  SocketUserModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    socketId = json['socketId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['socketId'] = socketId;
    return _data;
  }
}