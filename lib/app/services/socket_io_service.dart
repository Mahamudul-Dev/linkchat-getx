import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linkchat/app/data/models/socket_model.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/modules/message/controllers/message_controller.dart';
import 'package:linkchat/app/services/notification_service.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../data/models/conversation_model.dart';
import '../data/utils/utils.dart';
import '../modules/profile/controllers/profile_controller.dart';

class SocketIOService {
  static AudioPlayer audioPlayer = AudioPlayer();
  static final NotificationService _notificationService = NotificationService();
  static final profile = ProfileController();
  static SocketUserModel? socketUserModel;
  static final box = GetStorage();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static final dbHelper = DatabaseHelper();
  static IO.Socket socket = IO.io(SOCKET_CONNECTION_URL, <String, dynamic>{
    'transports': ['websocket'],
  },);
  

  static void initSocket(){
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation < AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    socket.onConnect((_) {
    Logger().i('Socket Connection Established Success');
    socket.emit('join', dbHelper.getLoginInfo().id);
    socket.on('privateMessage', (message) async {
      
      Logger().i(message);
      final msg = ReceiveMessageModel.fromJson(message);
      
      try {
        final userProfile = await profile.getProfileDetails(msg.sender);
        if(userProfile != null){
          _notificationService.showNotification(userProfile.data.first.userName, msg.message.text, 'Link Message', 'New Message Got From Alu Boti');
        }
      } catch (e) {
        Logger().e(e);
      }
      // playNotificationSound();
      Logger().i('Message Recieved from: ${msg.sender}, Message: ${msg.message.text}');
      final dbMsg = MessageSchema(content: msg.message.text, attachments: msg.message.attachments, receiverId: msg.receiver, timestamp: DateTime.parse(msg.createdAt), senderServerId: msg.sender);
      MessageController.messages.add(dbMsg);
      MessageController.scrollToBottom();
      dbHelper.saveConversation(dbMsg);
    });
  });

  socket.onConnectError((error) => Logger().e(error));
  socket.onError((error) => Logger().e(error));
  socket.onConnecting((data) => Logger().i(data));
  socket.onPing((data) => Logger().i(data));
  socket.onPong((data) => Logger().i(data));
  socket.onReconnect((data) => Logger().i(data));
  socket.onDisconnect((data) => Logger().i(data));
  socket.onConnectTimeout((data) => Logger().i(data));
  socket.onReconnecting((data) => Logger().i(data));
  socket.onReconnectFailed((data) => Logger().i(data));
  }

  static Future <void> playNotificationSound() async {
  // You need to replace 'notification.mp3' with the actual path of your audio file
  try {
    await audioPlayer.play(AssetSource('sounds/Notification.mp3'), mode: PlayerMode.lowLatency);
  } catch (e) {
    Logger().e(e);
  }

}
}