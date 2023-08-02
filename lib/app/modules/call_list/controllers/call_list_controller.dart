import 'package:get/get.dart';
import 'package:star_menu/star_menu.dart';

import '../../../data/demo/call_demo.dart';
import '../../../data/models/models.dart';

class CallListController extends GetxController {
  StarMenuController starMenuController = StarMenuController();
  List<CallModel> get callHistory => calls.obs;
}
