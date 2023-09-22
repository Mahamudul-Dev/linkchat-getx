import 'package:get/get.dart';
import 'room_member_controller.dart';

class RoomMemberViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RoomMemberViewController());
  }
}
