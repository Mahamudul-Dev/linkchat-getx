import 'package:objectbox/objectbox.dart';

@Entity()
class BlockListSchema {
  @Id()
  int objectId;
  String serverId;
  int uid;
  String username;
  @Property(type: PropertyType.date)
  DateTime blockedDate;

  BlockListSchema(
      {this.objectId = 0,
        required this.serverId,
      required this.uid,
      required this.username,
      required this.blockedDate});
}