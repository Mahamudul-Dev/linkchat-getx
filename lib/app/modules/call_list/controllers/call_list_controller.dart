import 'package:get/get.dart';

import '../../../data/demo/call_demo.dart';
import '../../../data/models/models.dart';
import '../../../database/database.dart';
import '../../../modules/followers/controllers/followers_controller.dart';
import 'package:star_menu/star_menu.dart';

class CallListController extends GetxController {
  StarMenuController starMenuController = StarMenuController();
  List<CallModel> get callHistory => calls.obs;


  
}
