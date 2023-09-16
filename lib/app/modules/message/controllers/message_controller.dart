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
  static ScrollController scrollController = ScrollController();
  static Rx<chat.ChatController?> chatViewController =
      Rx<chat.ChatController?>(null);
  static RxList<MessageSchema> messages = <MessageSchema>[].obs;

  UserModel? receiverProfile;
  // Stream<ConversationSchema>? conversationStream;

  // ---------------

  void onSendTap(String message, chat.ReplyMessage replyMessage,
      chat.MessageType messageType, String receiverId) {
    final id = messages.isNotEmpty ? messages.last.id + 1 : 0;
    final messageSchema = MessageSchema(
        id: id,
        message: message,
        createdAt: DateTime.now().toIso8601String(),
        senderId: AccountHelper.getUserData().serverId,
        receiverId: receiverId,
        messageType: messageType.name,
        voiceMessageDuration: '',
        status: chat.MessageStatus.pending.name);

    P2PChatHelper.saveConversation(messageSchema);

    chatViewController.value?.addMessage(
      chat.Message(
        id: id.toString(),
        createdAt: DateTime.now(),
        message: message,
        sendBy: AccountHelper.getUserData().serverId,
        replyMessage: replyMessage,
        messageType: messageType,
      ),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      chatViewController.value?.initialMessageList.last.setStatus =
          chat.MessageStatus.undelivered;
    });
    Future.delayed(const Duration(seconds: 1), () {
      chatViewController.value?.initialMessageList.last.setStatus =
          chat.MessageStatus.read;
    });
  }

  // ---------------

  bool isOwnMessage(MessageSchema message) {
    if (message.receiverId == AccountHelper.getUserData().serverId) {
      return false;
    }
    return true;
  }

  // void sendMessage(String receiverId) {
  //   final sendMessage = MessageModel(
  //       message: MessageModel(
  //           text: textMessageController.value.text, attachments: []),
  //       users: [AccountHelper.getUserData().serverId, receiverId],
  //       sender: AccountHelper.getUserData().serverId,
  //       receiver: receiverId,
  //       createdAt: DateTime.now().toString(),
  //       updatedAt: DateTime.now().toString());
  //   //SocketIOService.socket.emit('privateMessage',sendMessage.toJson());
  //   Logger().i(sendMessage.toJson());
  //   SocketIOService.socket.emit('privateMessage', sendMessage.toJson());
  //   final message = MessageSchema(
  //       content: textMessageController.value.text,
  //       attachments: [],
  //       receiverId: receiverId,
  //       timestamp: DateTime.now(),
  //       senderServerId: AccountHelper.getUserData().serverId);
  //   P2PChatHelper.saveConversation(message);
  //   messages.add(message);

  //   textMessageController.value.clear();
  //   textMessage.value = '';
  //   scrollToBottom();
  // }

  void getMessage(ConversationSchema? conversationSchema, String sId) async {
    try {
      messages.assignAll(conversationSchema?.messages.toList() ?? []);

      receiverProfile = await ApiService.getSingleProfile(sId);
      chatViewController.value = chat.ChatController(
        initialMessageList: messages.isEmpty
            ? <chat.Message>[]
            : messages
                .map((element) => chat.Message(
                    message: element.message ?? '',
                    id: element.id.toString(),
                    createdAt: DateTime.parse(element.createdAt!),
                    sendBy: element.senderId!))
                .toList(),
        scrollController: ScrollController(),
        chatUsers: [
          chat.ChatUser(
            id: sId,
            name: receiverProfile?.data.first.userName ?? 'Unknown',
            profilePhoto: receiverProfile?.data.first.profilePic,
          )
        ],
      );
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
    // scrollToBottom();
    super.onInit();
  }
}
