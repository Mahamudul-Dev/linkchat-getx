import 'package:get/get.dart';

import '../controllers/room_explore_controller.dart';

class RoomExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomExploreController>(
      () => RoomExploreController(),
    );
  }
}
