import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/database/helpers/accounts_helper.dart';
import 'package:logger/logger.dart';

import '../../../data/models/user_model.dart';
import '../../../data/utils/utils.dart';

class FollowersController extends GetxController {

  Future<List<ShortProfile>> getFollowers() async {
    List<ShortProfile> result = [];
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + AccountHelper.getUserData().serverId),
          headers: authorization(AccountHelper.getLoginInfo().token!));
      if (response.statusCode == 200) {
        final data = UserModel.fromJson(jsonDecode(response.body));
        if (data.data.first.followers.isNotEmpty) {
          result = data.data.first.followers;
          return result;
        }
        return result;
      } else {
        Get.snackbar('Sorry!', 'Network Error');
        return result;
      }
    } catch (e) {
      Logger().e(e);
      return result;
    }
  }
}
