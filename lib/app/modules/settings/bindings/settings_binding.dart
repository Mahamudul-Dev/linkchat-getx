import 'package:get/get.dart';
import 'package:linkchat/app/modules/block_list/controllers/block_list_controller.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockListController>(
      () => BlockListController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
