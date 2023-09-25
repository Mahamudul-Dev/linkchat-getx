import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/room_conversation_model.dart';
import 'package:linkchat/app/database/helpers/helpers.dart';
import 'package:linkchat/app/database/room_schema.dart';
import 'package:linkchat/app/modules/room_chat/controllers/room_chat_controller.dart';
import 'package:linkchat/app/services/socket_io_service.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/room_res_model.dart';

class RoomConversationController extends GetxController {
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;
  final dio = Dio();
  ScrollController drawerScrollController = ScrollController();
  static ScrollController messageScrollController = ScrollController();

  static RxList<RoomMessageSchema> roomMessages = <RoomMessageSchema>[].obs;

  Future<void> sendMessage(RoomModel roomModel) async {
    final message = RoomMessageModel(
        message: textMessageController.value.text,
        senderId: AccountHelper.getUserData().serverId,
        groupId: roomModel.id,
        messageType: 'text',
        voiceMessageDuration: '00',
        status: 'pending',
        createdAt: DateTime.now().toIso8601String());

    await RoomChatHelper.saveMessageToRoom(roomModel, message);
    SocketIOService.socket.emit('groupMessage', message.toJson());

    roomMessages.add(RoomMessageSchema(
        message: message.message,
        senderId: message.senderId,
        roomId: message.groupId,
        messageType: message.messageType,
        voiceMessageDuration: message.voiceMessageDuration,
        status: message.status,
        createdAt: message.createdAt));
    RoomChatController.roomConversation.refresh();

    textMessageController.value.clear();

    RoomChatController.roomConversation
        .firstWhere((element) => element.roomId == roomModel.id)
        .messages
        .add(RoomMessageSchema(
            message: message.message,
            senderId: message.senderId,
            roomId: message.groupId,
            messageType: message.messageType,
            voiceMessageDuration: message.voiceMessageDuration,
            status: message.status,
            createdAt: message.createdAt));
  }

  void getRoomMessage(RoomEntity? roomSchema) async {
    if (roomSchema != null) {
      roomMessages.assignAll(RoomChatController.roomConversation
          .firstWhere((element) => element.roomId == roomSchema.groupId)
          .messages);
    }
    // try {
    //   for (var i = 0; i < roomSchema!.messages.length; i++) {
    //     Logger().i({
    //       'Room Name': roomSchema.groupName,
    //       'Message': roomSchema.messages[i].message,
    //       'Room Id': roomSchema.groupId
    //     });
    //   }

    //   Logger().i(
    //       'Room Entity First Message: ${roomSchema?.messages.first.message}, Room Entity Message Count: ${roomSchema?.messages.length}');
    //   roomMessages.assignAll(roomSchema?.messages.toList() ?? []);

    //   Logger().i('Room Messages: ${roomMessages.length}');
    // } catch (e) {
    //   Logger().e(e);
    // }
  }
}
