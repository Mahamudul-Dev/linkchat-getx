import 'package:objectbox/objectbox.dart';

@Entity()
class Chat {
  @Id()
  int id;
  String content;
  List<String> attachment;
  int senderId;
  int? receiverId;
  int? groupId;
  @Property(type: PropertyType.date)
  DateTime timestamp;

  Chat({
    required this.id,
    required this.content,
    required this.attachment,
    required this.senderId,
    this.receiverId,
    this.groupId,
    required this.timestamp,
  });
}
