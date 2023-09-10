import 'package:get/get.dart';

import '../controllers/room_chat_controller.dart';
import '../controllers/room_conversation_controller.dart';

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
