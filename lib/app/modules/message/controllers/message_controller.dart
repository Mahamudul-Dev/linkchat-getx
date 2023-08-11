import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/database/database.dart';

class MessageController extends GetxController {
  final dbHelper = DatabaseHelper();
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;

  final dummySms = <Message>[].obs;

  bool isOwnMessage(Message message) {
    if (message.receiverId == dbHelper.getUserData().serverId) {
      return false;
    }
    return true;
  }

  void sendMessage() {
    final message = Message(
        content: textMessageController.value.text,
        attachment: [],
        receiverId: '64c5688e5a14e70467929ae0',
        timestamp: DateTime.now());
    dummySms.add(message);
    textMessageController.value.clear();
    textMessage.value = '';
  }
}
