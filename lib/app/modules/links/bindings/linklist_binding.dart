import 'package:get/get.dart';
import 'package:linkchat/app/modules/links/controllers/linklist_controller.dart';

class LinklistBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LinklistController>(
      LinklistController(),
    );
  }
}
