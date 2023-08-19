import 'package:get/get.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';

import '../../search/controllers/search_controller.dart';
import '../controllers/followers_controller.dart';

class FollowersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowersController>(
      () => FollowersController(),
    );

    Get.lazyPut<SearchViewController>(
      () => SearchViewController(),
    );

    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
