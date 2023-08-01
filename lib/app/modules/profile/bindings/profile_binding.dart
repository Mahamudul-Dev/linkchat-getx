import 'package:get/get.dart';
import 'package:linkchat/app/modules/search/controllers/search_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<SearchViewController>(
      () => SearchViewController(),
    );
  }
}
