import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/conversation_model.dart';
import 'package:linkchat/app/services/google_drive_service.dart';
import 'package:logger/logger.dart';

import '../../../database/conversatin_schema.dart';
import '../../../database/helpers/helpers.dart';
import '../../../services/socket_io_service.dart';

class MessageController extends GetxController {
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;
  static ScrollController scrollController = ScrollController();

  static RxList<MessageSchema> messages = <MessageSchema>[].obs;
  Stream<ConversationSchema>? conversationStream;

  bool isOwnMessage(MessageSchema message) {
    if (message.receiverId == AccountHelper.getUserData().serverId) {
      return false;
    }
    return true;
  }

  Future<void> getAttachment(String email) async{
    final result = await FilePicker.platform.pickFiles();
    Logger().i(result);
    if(result != null){
      Logger().i('path: ${result.files.first.path}');
      final file = File(result.files.first.path!);
      Logger().i(file.path);
      Logger().i(email);
      // try{
        await GoogleDriveService.uploadFile(file, email);
        Logger().i(file.path);
      // } catch(e){
      //   Logger().e(e);
      // }
    }
  }

  void sendMessage(String receiverId) {
    final sendMessage = ReceiveMessageModel(message: MessageModel(text: textMessageController.value.text, attachments: []), users: [AccountHelper.getUserData().serverId, receiverId], sender: AccountHelper.getUserData().serverId, receiver: receiverId, createdAt: DateTime.now().toString(), updatedAt: DateTime.now().toString());
    //SocketIOService.socket.emit('privateMessage',sendMessage.toJson());
    Logger().i(sendMessage.toJson());
    SocketIOService.socket.emit('privateMessage', sendMessage.toJson());
    final message = MessageSchema(content: textMessageController.value.text, attachments: [], receiverId: receiverId, timestamp: DateTime.now(), senderServerId: AccountHelper.getUserData().serverId);
    P2PChatHelper.saveConversation(message);
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
