import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
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
  static ScrollController scrollController = ScrollController();

  static RxList<MessageSchema> messages = <MessageSchema>[].obs;
  Stream<ConversationSchema>? conversationStream;

  bool isOwnMessage(MessageSchema message) {
    if (message.receiverId == dbHelper.getUserData().serverId) {
      return false;
    }
    return true;
  }

  void sendMessage(String receiverId) {
    final sendMessage = ReceiveMessageModel(message: MessageModel(text: textMessageController.value.text, attachments: []), users: [dbHelper.getUserData().serverId, receiverId], sender: dbHelper.getUserData().serverId, receiver: receiverId, createdAt: DateTime.now().toString(), updatedAt: DateTime.now().toString());
    //SocketIOService.socket.emit('privateMessage',sendMessage.toJson());
    Logger().i(sendMessage.toJson());
    SocketIOService.socket.emit('privateMessage', sendMessage.toJson());
    final message = MessageSchema(content: textMessageController.value.text, attachments: [], receiverId: receiverId, timestamp: DateTime.now(), senderServerId: dbHelper.getUserData().serverId); 
    dbHelper.saveConversation(message);
    messages.add(message);
    
    textMessageController.value.clear();
    textMessage.value = '';
    scrollToBottom();
  }

  void getMessage(ConversationSchema? conversationSchema) {
    try {
      messages.assignAll(conversationSchema?.messages.toList()??[]);
    } catch(e){
      Logger().e(e);
    }
    }

  static void scrollToBottom() {
  if (scrollController.hasClients) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
}

@override
  void onInit() {
    scrollToBottom();
    super.onInit();
  }
}
