import 'package:get/get.dart';

import '../controllers/random_call_controller.dart';

class RandomCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RandomCallController>(
      () => RandomCallController(),
    );
  }
}
