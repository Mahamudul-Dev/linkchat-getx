import 'package:objectbox/objectbox.dart';

@Entity()
class NotificationSchema {
  @Id()
  int id;

  String title;
  String message;
  String type;
  bool isRead;
  String timestamp;

  NotificationSchema({
    this.id = 0,
    required this.title,
    required this.message,
    required this.type,
    this.isRead = false,
    required this.timestamp,
  });
}
