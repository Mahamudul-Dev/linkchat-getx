import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/dummy_messages.dart';
import 'package:linkchat/app/data/models/conversation_model.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:logger/logger.dart';
import 'package:chatview/chatview.dart' as chat;

import '../../../database/conversatin_schema.dart';
import '../../../database/helpers/helpers.dart';
import '../../../services/socket_io_service.dart';

class MessageController extends GetxController {
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;
  RxBool isTyping = true.obs;
  static ScrollController scrollController = ScrollController();
  static Rx<chat.ChatController?> chatViewController =
      Rx<chat.ChatController?>(null);
  static RxList<MessageSchema> messages = <MessageSchema>[].obs;

  UserModel? receiverProfile;

  void sendMessage(
      {String? textMessage,
      String? mediaMessage,
      required String receiverId,
      required String messageType,
      String? voiceMessageDuration}) {
    final id = messages.isNotEmpty ? messages.last.id + 1 : 0;
    final messageSchema = MessageSchema(
        id: id,
        message: messageType == 'text' ? textMessage : mediaMessage,
        createdAt: DateTime.now().toIso8601String(),
        senderId: AccountHelper.getUserData().serverId,
        receiverId: receiverId,
        messageType: messageType,
        voiceMessageDuration: voiceMessageDuration,
        status: chat.MessageStatus.pending.name);

    P2PChatHelper.saveConversation(messageSchema);
    textMessageController.value.clear();

    SocketIOService.socket.emit('privateMessage', messageSchema);

    messages.add(messageSchema);
    scrollToBottom();
  }

  Future<void> getAttachment({required String receiverId}) async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg',
          'mp4',
          'wav',
          'mp3',
          'mov',
          'mkv'
        ]);
    Logger().i(result);
    if (result != null) {
      Logger().i('path: ${result.files.first.path}');
      final file = File(result.files.first.path!);
      Logger().i(file.path);
      sendMessage(
          receiverId: receiverId,
          messageType: 'media',
          mediaMessage: file.path);
      // try{
      // await GoogleDriveService.uploadFile(file, email);
      Logger().i(file.path);
      // } catch(e){
      //   Logger().e(e);
      // }
    }
  }

  bool isOwnMessage(MessageSchema message) {
    if (message.receiverId == AccountHelper.getUserData().serverId) {
      return false;
    }
    return true;
  }

  void getMessage(ConversationSchema? conversationSchema, String sId) async {
    try {
      messages.assignAll(conversationSchema?.messages.toList() ?? []);
      Logger().i(messages.length);
    } catch (e) {
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
