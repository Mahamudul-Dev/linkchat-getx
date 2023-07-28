class BlockedUserModel {
  String serverId;
  int uid;
  String userName;
  DateTime blockedDate;

  BlockedUserModel({required this.serverId, required this.uid, required this.userName, required this.blockedDate});
}