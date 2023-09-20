import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/services/socket_io_service.dart';
import 'package:logger/logger.dart';

class RoomConversationController extends GetxController {
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;

  static RxList<String> message = <String>[].obs;

  void sendMessage(String roomId) {
    SocketIOService.socket
        .emit('groupMessage', {'message': 'hi', 'groupId': roomId});
  }
}
