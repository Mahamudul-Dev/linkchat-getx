import 'package:get/get.dart';
import 'package:linkchat/app/data/demo/demo.dart';
import 'package:linkchat/app/data/models/models.dart';

class FollowersController extends GetxController {
  List<UserModel> get followers => profiles.obs;
}
