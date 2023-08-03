import 'package:get/get.dart';

import '../../chat/controllers/chat_controller.dart';
import '../controllers/message_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(
      () => MessageController(),
    );

    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
  }
}
