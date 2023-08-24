import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/conversation_model.dart';
import 'package:logger/logger.dart';

import '../../../database/conversatin_schema.dart';
import '../../../database/database_helper.dart';
import '../../../services/socket_io_service.dart';

class MessageController extends GetxController {
  final dbHelper = DatabaseHelper();
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;
  ScrollController scrollController = ScrollController();

  static RxList<Message> messages = <Message>[].obs;
  Stream<ConversationSchema>? conversationStream;

  bool isOwnMessage(Message message) {
    if (message.receiverId == dbHelper.getUserData().serverId) {
      return false;
    }
    return true;
  }

  void sendMessage(String receiverId) {
    final sendMessage = ReceiveMessageModel(message: MessageModel(text: textMessageController.value.text), attachments: [], users: [dbHelper.getUserData().serverId, receiverId], sender: dbHelper.getUserData().serverId, receiver: receiverId, createdAt: DateTime.now().toString(), updatedAt: DateTime.now().toString());
    //SocketIOService.socket.emit('privateMessage',sendMessage.toJson());
    Logger().i(sendMessage.toJson());
    SocketIOService.socket.emit('privateMessage', sendMessage.toJson());
    final message = Message(message: textMessageController.value.text, attachments: [], receiverId: receiverId, timestamp: DateTime.now(), senderServerId: dbHelper.getUserData().serverId); 
    dbHelper.saveConversation(message);
    messages.add(message);
    textMessageController.value.clear();
    textMessage.value = '';
    // scrollToBottom();
  }

  void getMessage(ConversationSchema? conversationSchema) {
    try {
      messages.assignAll(conversationSchema?.messages.toList()??[]);
    } catch(e){
      Logger().e(e);
    }
    }

  // void scrollToBottom() {
  //   scrollController.animateTo(
  //     scrollController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }
}
