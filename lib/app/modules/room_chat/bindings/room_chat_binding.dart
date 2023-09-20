import 'package:get/get.dart';
import 'package:linkchat/app/modules/room_chat/controllers/room_conversation_controller.dart';

import '../controllers/room_chat_controller.dart';

class RoomChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomChatController>(
      () => RoomChatController(),
    );
    Get.lazyPut<RoomConversationController>(
      () => RoomConversationController(),
    );
  }
}
