import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/database/database.dart';
import 'package:logger/logger.dart';

import '../../../data/demo/demo.dart';
import '../../../data/models/models.dart';
import '../../../data/utils/utils.dart';

class ChatController extends GetxController {
// user activity list section
  List<FollowerModel> activeUser = [];
  RxList<ConversationSchema> conversations = <ConversationSchema>[].obs;

// user chat section
  List<Chat> get chatList => chats.obs;
  final dbHelper = DatabaseHelper();

  Future<List<FollowerModel>> getAllActiveUsers() async {
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + dbHelper.getUserData().serverId),
          headers: authorization(dbHelper.getLoginInfo().token!));

      if (response.statusCode == 200) {
        activeUser = UserModel.fromJson(jsonDecode(response.body))
            .data
            .first
            .linked
            .where((element) => element.isActive == true)
            .toList();
        return activeUser;
      }

      return activeUser;
    } catch (e) {
      Logger().e(e);
      return activeUser;
    }
  }

  void getConversation() async {
    conversations.addAll(dbHelper.getConversation());
  }

  @override
  void onInit() {
    getAllActiveUsers();
    getConversation();
    super.onInit();
  }
}
