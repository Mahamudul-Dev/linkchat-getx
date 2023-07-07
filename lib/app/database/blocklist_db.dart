import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class BlockedUser {
  @Id()
  int id;
  int uid;
  String username;
  DateTime blockedDate;
  RxBool isChecked;

  BlockedUser(
      {this.id = 0,
      required this.uid,
      required this.username,
      required this.blockedDate,
      bool isChecked = false})
      : isChecked = isChecked.obs;
}

@Entity()
class UserBlocklist {
  @Id()
  int id;

  late final ToMany<BlockedUser> blockedUsers;

  UserBlocklist({
    this.id = 0,
  });
}
