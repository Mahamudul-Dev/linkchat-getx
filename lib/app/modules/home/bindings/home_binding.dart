import 'package:get/get.dart';
import 'package:linkchat/app/modules/call_list/controllers/call_list_controller.dart';
import 'package:linkchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:linkchat/app/modules/dialer/controllers/dialer_controller.dart';
import 'package:linkchat/app/modules/random_call/controllers/random_call_controller.dart';

import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<ChatController>(
      () => ChatController(),
    );

    Get.lazyPut(
      () => ProfileController(),
    );

    Get.lazyPut<CallListController>(
      () => CallListController(),
    );

    Get.lazyPut<RandomCallController>(
      () => RandomCallController(),
    );

    Get.lazyPut<DialerController>(
      () => DialerController(),
    );
  }
}
