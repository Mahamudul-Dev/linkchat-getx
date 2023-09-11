import 'package:get/get.dart';

import '../controllers/room_explor_controller.dart';

class RoomExplorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomExplorController>(
      () => RoomExplorController(),
    );
  }
}
