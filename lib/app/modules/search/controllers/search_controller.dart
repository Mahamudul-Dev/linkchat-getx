import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:logger/logger.dart';
import '../../../data/demo/search_result_demo.dart';
import '../../../data/models/models.dart';

class SearchViewController extends GetxController with GetSingleTickerProviderStateMixin{
  Rx<TextEditingController> searchTextController = TextEditingController().obs;
  late Rx<TabController> tabController = TabController(length: 3, vsync: this).obs;
  RxBool isLoading = true.obs;




  Future<SearchResultModel> searchUser({String queryText = 'A'}) {
    final data = SearchResultModel.fromJson(searchResult);
    return Future.value(data);
  }

  Future<RxString> getButtonStatus(String sId) async {
    RxString buttonStatus = 'Follow'.obs;
    final currentUserId = DatabaseHelper().getLoginInfo().id;
    final response = await http.get(Uri.parse(BASE_URL+USER+currentUserId!), headers: authorization(DatabaseHelper().getLoginInfo().token?? ''));

    try {
      if(response.statusCode == 200) {
        final currentUser = UserModel.fromJson(jsonDecode(response.body));
        /// *** need to set button status based on user followers list, pending list, linked list *** ///
        if(currentUser.data?.first.linked?.singleWhere((user) => user.sId == sId) != null){
          buttonStatus.value = 'Unlink';
          return buttonStatus;
        } if(currentUser.data?.first.pendingFollowers?.singleWhere((user) => user.sId == sId) != null){
          buttonStatus.value = 'Link';
          return Future.value(buttonStatus);
        }
        if(currentUser.data?.first.pendingFollowing?.singleWhere((user) => user.sId == sId) != null){
          buttonStatus.value = 'Withdraw';
          return Future.value(buttonStatus);
        }

      }
    } catch (e) {
      Logger().e(e);
    }
    return Future.value(buttonStatus);
  }

}
