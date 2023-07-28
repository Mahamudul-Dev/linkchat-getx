import 'package:get/get.dart';

class FollowersCheckObjectModel {
  final String serverId;
  final int uid;
  final String userName;
  final String profilePic;
  final DateTime date;
  final RxBool isChecked;

  FollowersCheckObjectModel({
    required this.serverId,
    required this.uid,
    required this.userName,
    required this.profilePic,
    required this.date,
    bool isChecked = false,
  }) : isChecked = isChecked.obs;
}
