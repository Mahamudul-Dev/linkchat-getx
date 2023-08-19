import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:logger/logger.dart';

import '../../../../objectbox.g.dart';

class MessageController extends GetxController {
  final dbHelper = DatabaseHelper();
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;

  RxList<Message> messages = <Message>[].obs;

  bool isOwnMessage(Message message) {
    if (message.receiverId == dbHelper.getUserData().serverId) {
      return false;
    }
    return true;
  }


  void sendMessage(String receiverId) {

    final message = Message(
        content: textMessageController.value.text,
        attachment: [],
        receiverId: receiverId,
        timestamp: DateTime.now());
    dbHelper.saveConversation(receiverId, message);
    messages.add(message);
    textMessageController.value.clear();
    textMessage.value = '';
  }



  void getMessage(ConversationSchema? conversationSchema) {
    try {
      messages.assignAll(conversationSchema?.messages.toList()??[]);
    } catch(e){
      Logger().e(e);
    }
    }
}
