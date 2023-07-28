import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:logger/logger.dart';
import '../../../database/database.dart';

import '../../../data/models/models.dart';

class FollowersController extends GetxController {

  RxBool isLoading = false.obs;

  final _currentUserLoginInfo = DatabaseHelper().getLoginInfo();

  // fetch followers list form local database
  List<FollowerModel> followers = <FollowerModel>[].obs;

  Future<List<FollowerModel>> getFollowers() async {

    try{
      isLoading.value = true;
      final response = await http.get(Uri.parse(BASE_URL+USER+_currentUserLoginInfo.id!), headers: authorization(_currentUserLoginInfo.token!));
      if(response.statusCode == 200){
        final result = UserModel.fromJson(jsonDecode(response.body));
        Logger().i(response);
        followers.clear();
        followers.addAll(result.data!.first.followers!);
        isLoading.value = false;
        Logger().i(followers.first.profilePic);
        return followers;
      } else {
        Get.snackbar('Opps!', 'Please check your network connection & try again');
        isLoading.value = false;
        return followers;
      }
    } catch (e){
      isLoading.value = false;
      Logger().e(e);
    }
    return followers;
  }
  
}
