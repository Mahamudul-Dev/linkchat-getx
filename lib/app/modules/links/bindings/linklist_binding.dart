import 'package:get/get.dart';
import 'package:linkchat/app/modules/links/controllers/linklist_controller.dart';
import 'package:linkchat/app/modules/search/controllers/search_controller.dart';

class LinklistBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LinklistController>(
      LinklistController(),
    );

    Get.put<SearchViewController>(
      SearchViewController(),
    );
  }
}
