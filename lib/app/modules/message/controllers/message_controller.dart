import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/conversation_model.dart';
import 'package:logger/logger.dart';
import 'package:chatview/chatview.dart' as chat;

import '../../../database/conversatin_schema.dart';
import '../../../database/helpers/helpers.dart';
import '../../../services/socket_io_service.dart';

class MessageController extends GetxController {
  Rx<TextEditingController> textMessageController = TextEditingController().obs;
  RxString textMessage = ''.obs;
  static ScrollController scrollController = ScrollController();

  static RxList<MessageSchema> messages = <MessageSchema>[].obs;
  Stream<ConversationSchema>? conversationStream;

  // ---------------

  final currentUser = chat.ChatUser(
    id: '1',
    name: 'Flutter',
    profilePhoto:
        'https://img.freepik.com/free-photo/businessman-profile-looking-left_1098-295.jpg',
  );
  final chatController = chat.ChatController(
    initialMessageList: [
      chat.Message(
        message: 'Hey There',
        createdAt: DateTime.now(),
        sendBy: '1',
      )
    ],
    scrollController: ScrollController(),
    chatUsers: [
      chat.ChatUser(
        id: '2',
        name: 'Simform',
        profilePhoto:
            'https://img.freepik.com/premium-photo/successful-young-business-man-standing-with-his-colleagues-b_252847-33570.jpg',
      ),
      chat.ChatUser(
        id: '3',
        name: 'Jhon',
        profilePhoto:
            'https://img.freepik.com/free-photo/businessman-profile-looking-left_1098-295.jpg',
      ),
      chat.ChatUser(
        id: '4',
        name: 'Mike',
        profilePhoto:
            'https://img.freepik.com/premium-photo/confident-handsome-successful-man-smiling-looking-determined_911620-15196.jpg',
      )
    ],
  );

  void _showHideTypingIndicator() {
    chatController.setTypingIndicator = !chatController.showTypingIndicator;
  }

  // ---------------

  bool isOwnMessage(MessageSchema message) {
    if (message.receiverId == AccountHelper.getUserData().serverId) {
      return false;
    }
    return true;
  }

  void sendMessage(String receiverId) {
    final sendMessage = ReceiveMessageModel(
        message: MessageModel(
            text: textMessageController.value.text, attachments: []),
        users: [AccountHelper.getUserData().serverId, receiverId],
        sender: AccountHelper.getUserData().serverId,
        receiver: receiverId,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString());
    //SocketIOService.socket.emit('privateMessage',sendMessage.toJson());
    Logger().i(sendMessage.toJson());
    SocketIOService.socket.emit('privateMessage', sendMessage.toJson());
    final message = MessageSchema(
        content: textMessageController.value.text,
        attachments: [],
        receiverId: receiverId,
        timestamp: DateTime.now(),
        senderServerId: AccountHelper.getUserData().serverId);
    P2PChatHelper.saveConversation(message);
    messages.add(message);

    textMessageController.value.clear();
    textMessage.value = '';
    scrollToBottom();
  }

  void getMessage(ConversationSchema? conversationSchema) {
    try {
      messages.assignAll(conversationSchema?.messages.toList() ?? []);
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
