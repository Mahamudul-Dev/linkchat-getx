import 'dart:convert';

import 'package:get/get.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';
import 'package:logger/logger.dart';
import '../../../data/models/models.dart';
import '../../../data/demo/demo.dart';
import '../../../data/utils/utils.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {

// user activity list section
  List<FollowerModel> activeUser = [];


// user chat section
  List<Chat> get chatList => chats.obs;



  Future<List<FollowerModel>> getAllActiveUsers() async {
    final userInfo = DatabaseHelper().getLoginInfo();
    List<FollowerModel> allFollowers = await Get.find<FollowersController>().getFollowers();
    activeUser = allFollowers.where((element) => element.isActive == true).toList();
    return activeUser;
  }

  @override
  void onInit() {
    getAllActiveUsers();
    super.onInit();
  }
}
