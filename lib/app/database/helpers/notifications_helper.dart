import '../database.dart';
import '../objectbox_singleton.dart';

class NotificationsHelper{

  final notificationBox = ObjectBoxSingleton().store.box<NotificationSchema>();

  void saveNotification(NotificationSchema notificationSchema) {
    notificationBox.put(notificationSchema);
  }


}