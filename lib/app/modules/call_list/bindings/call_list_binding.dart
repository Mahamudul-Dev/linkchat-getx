import 'package:get/get.dart';
import '../controllers/call_list_controller.dart';

class CallListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallListController>(
      () => CallListController(),
    );
  }
}
