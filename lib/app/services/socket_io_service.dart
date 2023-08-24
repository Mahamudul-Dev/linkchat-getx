import 'package:audioplayers/audioplayers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linkchat/app/data/models/socket_model.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/modules/message/controllers/message_controller.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../data/models/conversation_model.dart';

class SocketIOService {
  static AudioPlayer audioPlayer = AudioPlayer();
  static SocketUserModel? socketUserModel;
  static final box = GetStorage();

  static final dbHelper = DatabaseHelper();
  static IO.Socket socket = IO.io('http://linkfysocket.linkfy.org:3434', <String, dynamic>{
    'transports': ['websocket'],
  },);
  

  static void initSocket(){
    socket.onConnect((_) {
    Logger().i('Socket Connection Established Success');
    socket.emit('join', dbHelper.getLoginInfo().id);
    socket.on('privateMessage', (message) {
      Logger().i(message);
      final msg = ReceiveMessageModel.fromJson(message);
      playNotificationSound();
      Logger().i('Message Recieved from: ${msg.sender}, Message: ${msg.message.text}');
      final dbMsg = Message(message: msg.message.text, attachments: msg.attachments, receiverId: msg.receiver, timestamp: DateTime.parse(msg.createdAt), senderServerId: msg.sender);
      MessageController.messages.add(dbMsg);
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