import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/models/room_conversation_model.dart';
import 'package:linkchat/app/data/models/socket_model.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/modules/message/controllers/message_controller.dart';
import 'package:linkchat/app/modules/room_chat/controllers/room_chat_controller.dart';
import 'package:linkchat/app/modules/video_call/controllers/video_call_controller.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:linkchat/app/services/notification_service.dart';
import 'package:linkchat/app/services/webRTC_service.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../data/models/conversation_model.dart';
import '../data/models/room_res_model.dart';
import '../data/utils/utils.dart';
import '../database/helpers/helpers.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/room_chat/controllers/room_conversation_controller.dart';

class SocketIOService {
  static AudioPlayer audioPlayer = AudioPlayer();
  static final NotificationService _notificationService = NotificationService();
  static final profile = ProfileController();
  static SocketUserModel? socketUserModel;
  static final box = GetStorage();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static IO.Socket socket = IO.io(
    SOCKET_CONNECTION_URL,
    <String, dynamic>{
      'transports': ['websocket'],
      'auth': {'token': AccountHelper.getUserData().serverId}
    },
  );

  static void initSocket() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    socket.onConnect((_) {
      Logger().i('Socket Connection Established Success');
      socket.emit('join', AccountHelper.getLoginInfo().id);
      socket.on('privateMessage', (message) async {
        Logger().i(message);
        final msg = MessageModel.fromJson(message);

        try {
          final userProfile = await profile.getProfileDetails(msg.senderId!);
          if (userProfile != null) {
            _notificationService.showNotification(
                userProfile.data.first.userName,
                msg.message!,
                'Link Message',
                'New Message Got From ${userProfile.data.first.userName}');
          }
        } catch (e) {
          Logger().e(e);
        }
        final dbMsg = MessageSchema(
            message: msg.message,
            createdAt: msg.createdAt,
            senderId: msg.senderId,
            receiverId: msg.receiverId,
            messageType: msg.messageType,
            voiceMessageDuration: msg.voiceMessageDuration,
            status: msg.status);
        final reaction = ReactionSchema(
            reactions: msg.reaction?.reactions,
            reactedUserIds: msg.reaction?.reactedUserIds ?? []);
        dbMsg.reactions.target = reaction;

        MessageController.messages.add(dbMsg);
        MessageController.scrollToBottom();
        P2PChatHelper.saveConversation(dbMsg);
      });
      final joinedGroupList = RoomChatHelper.roomSchemaBox.getAll();
      Logger().i('Rooms length: ${joinedGroupList.length}');
      for (var i = 0; i < joinedGroupList.length; i++) {
        Logger().i(joinedGroupList[i].groupId);
        SocketIOService.socket.emit('joinGroup', joinedGroupList[i].groupId);
      }

      socket.on('typing', (_) {
        MessageController.isTyping.value = true;
      });

      socket.on('stopTyping', (_) {
        MessageController.isTyping.value = false;
      });

      socket.on('groupMessage', (message) async {
        Logger().i('Message recieved from server: $message');

        final roomMessage = RoomMessageModel.fromJson(message);
        Logger().i('Message converted: ${roomMessage.toJson()}');

        final roomRes = await ApiService.getRoomInfo(roomMessage.groupId!);

        final room = RoomResModel.fromJson(roomRes.data);

        await RoomChatHelper.saveMessageToRoom(room.data.first, roomMessage);
      });

      socket.on('offer', (data) async {
        Logger().i({'incoming call': data});
        await VideoCallController.incommingCallRecieved(
            ShortProfileModel.fromJson(data['callerDetails']));
        WebRTCService.establishPeerConnectionForReciver(
            data['callerDetails'], data['offer']);
      });

      socket.on('ice-candidate', (candidate) {
        Logger().i(candidate);
        WebRTCService.peerConnection.addCandidate(candidate);
      });

      socket.on('answer', (data) async {
        Logger().i({'call recieved': data});
        WebRTCService.peerConnection.setRemoteDescription(data['answer']);
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

  static Future<void> playNotificationSound() async {
    // You need to replace 'notification.mp3' with the actual path of your audio file
    try {
      await audioPlayer.play(AssetSource('sounds/Notification.mp3'),
          mode: PlayerMode.lowLatency);
    } catch (e) {
      Logger().e(e);
    }
  }
}
