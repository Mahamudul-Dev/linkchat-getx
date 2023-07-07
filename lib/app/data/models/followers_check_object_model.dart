import 'package:get/get.dart';

class FollowersCheckObjectModel {
  final int uid;
  final String username;
  final String profilepic;
  final DateTime date;
  final RxBool isChecked;

  FollowersCheckObjectModel({
    required this.uid,
    required this.username,
    required this.profilepic,
    required this.date,
    bool isChecked = false,
  }) : isChecked = isChecked.obs;
}
