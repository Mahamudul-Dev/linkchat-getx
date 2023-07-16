import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class BlockedUser {
  @Id()
  int objectId;
  String serverId;
  int uid;
  String username;
  @Property(type: PropertyType.date)
  DateTime blockedDate;

  BlockedUser(
      {this.objectId = 0,
        required this.serverId,
      required this.uid,
      required this.username,
      required this.blockedDate});
}