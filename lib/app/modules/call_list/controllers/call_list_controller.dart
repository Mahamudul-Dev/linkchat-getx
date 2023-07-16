import 'package:get/get.dart';

import 'package:linkchat/app/data/demo/call_demo.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';
import 'package:linkchat/app/modules/home/controllers/home_controller.dart';
import 'package:star_menu/star_menu.dart';

class CallListController extends GetxController {
  StarMenuController starMenuController = StarMenuController();
  List<CallModel> get callHistory => calls.obs;

  UserModel getUserInfo(int index) {
    if (callHistory[index].callerId ==
        Get.find<HomeController>().currentUser) {
      var user = Get.find<FollowersController>().followers.singleWhere(
          (element) => element.data!.first.uid == callHistory[index].receiverId);
      return user;
    } else {
      var user = Get.find<FollowersController>()
          .followers
          .singleWhere((element) => element.data!.first.uid == callHistory[index].callerId);

      return user;
    }
    
  }
  
}
