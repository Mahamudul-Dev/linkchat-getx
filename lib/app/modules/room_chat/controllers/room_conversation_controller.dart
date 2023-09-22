import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/database/helpers/helpers.dart';
import 'package:linkchat/app/services/socket_io_service.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/models.dart';
import '../../../data/models/multiple_profile_req_model.dart';
import '../../../data/utils/utils.dart';

class RoomConversationController extends GetxController {
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;
  final dio = Dio();
  ScrollController drawerScrollController = ScrollController();

  static RxList<String> message = <String>[].obs;

  void sendMessage(String roomId) {
    SocketIOService.socket.emit('groupMessage', {
      'status': 'pending',
      'senderId': AccountHelper.getUserData().serverId,
      'message': textMessageController.value.text,
      'groupId': roomId,
      'messageType': 'text',
      'voiceMessageDuration': '1235'
    });
    textMessageController.value.clear();
  }
}
