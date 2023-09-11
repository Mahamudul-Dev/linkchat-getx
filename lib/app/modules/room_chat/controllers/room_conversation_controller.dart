import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomConversationController extends GetxController {
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;

  void sendMessage(String roomId) {}
}
