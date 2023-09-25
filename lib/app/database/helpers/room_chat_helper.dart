import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/models/room_conversation_model.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/modules/room_chat/controllers/room_chat_controller.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:logger/logger.dart';

import '../../../objectbox.g.dart';
import '../../data/models/room_res_model.dart';
import '../objectbox_singleton.dart';
import '../room_schema.dart';

class RoomChatHelper {
  static final roomSchemaBox = ObjectBoxSingleton().store.box<RoomEntity>();
  static final roomMessageSchemaBox =
      ObjectBoxSingleton().store.box<RoomMessageSchema>();

  static Future<void> saveRoomInLocal(RoomModel room) async {
    final schema = RoomEntity(
        groupId: room.id,
        creatorId: room.creatorId,
        groupName: room.groupName,
        groupImage: room.groupImage ?? PLACEHOLDER_IMAGE,
        joinCode: room.joinCode);
    roomSchemaBox.putAsync(schema);
    RoomChatController.joinedRooms.add(room);
    Logger().i('Data Saved Successfully');
  }

  static Future<void> saveMessageToRoom(
      RoomModel room, RoomMessageModel roomMessage) async {
    UserModel? senderProfile =
        await ApiService.getSingleProfile(roomMessage.senderId!);

    RoomEntity? destinationRoom;

    final sender = RoomMemberSchema(
      serverId: senderProfile!.data.first.sId,
      name: senderProfile.data.first.userName,
      photo: senderProfile.data.first.profilePic,
    );

    final message = RoomMessageSchema(
        message: roomMessage.message,
        senderId: roomMessage.senderId,
        messageType: roomMessage.messageType,
        roomId: roomMessage.groupId,
        voiceMessageDuration: roomMessage.voiceMessageDuration,
        status: roomMessage.status,
        createdAt: roomMessage.createdAt);

    ReplyMessage? replyMessage;

    if (roomMessage.replyMessage != null) {
      replyMessage = ReplyMessage(
          message: roomMessage.replyMessage?.message,
          replyBy: roomMessage.replyMessage?.replyBy,
          replyTo: roomMessage.replyMessage?.replyTo,
          messageType: roomMessage.replyMessage?.messageType,
          voiceMessageDuration: roomMessage.replyMessage?.voiceMessageDuration);
      message.replyMessage.target = replyMessage;
      message.sender.target = sender;
    }

    final allLocalRooms = roomSchemaBox.getAll();

    if (allLocalRooms.isNotEmpty) {
      destinationRoom =
          allLocalRooms.firstWhere((room) => room.groupId == room.groupId);
    }

    Logger().i('Destination Room Found: ${destinationRoom?.groupId}');

    if (destinationRoom != null) {
      message.room.target = destinationRoom;
      destinationRoom.messages.add(message);
      roomMessageSchemaBox
          .putAsync(message)
          .then((value) => Logger().i('Message Putted: $value'));
      roomSchemaBox.put(destinationRoom);
    }
  }

  static Future<List<RoomEntity>> getJoinedRooms() async {
    return roomSchemaBox.getAllAsync();
  }

  static RoomEntity? getSingleRoomConversation(String roomId) {
    RoomEntity? schema;

    try {
      Logger().i(roomSchemaBox
          .query(RoomEntity_.groupId.equals(roomId))
          .build()
          .find());
      schema = roomSchemaBox
          .query(RoomEntity_.groupId.equals(roomId))
          .build()
          .find()
          .first;
    } catch (e) {
      Logger().e(e);
    }

    return schema;
  }
}
