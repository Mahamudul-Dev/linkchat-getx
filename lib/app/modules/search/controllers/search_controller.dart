import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/data/utils/app_strings.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:logger/logger.dart';

import '../../../data/models/models.dart';

class SearchViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<TextEditingController> searchTextController = TextEditingController().obs;
  late Rx<TabController> tabController =
      TabController(length: 3, vsync: this).obs;
  RxBool isLoading = true.obs;

  final dio = Dio();

  final currentUserLoginInfo = DatabaseHelper().getLoginInfo();
  final currentUser = DatabaseHelper().getUserData();

  Future<SearchResultModel> searchUser({String queryText = ''}) async {
    final body = {'_id': currentUserLoginInfo.id, 'query': queryText};
    final response = await dio.get(BASE_URL + SEARCH,
        data: body,
        options: Options(headers: authorization(currentUserLoginInfo.token!)));
    final data = SearchResultModel.fromJson(response.data);

    if (response.statusCode == 200) {
      return data;
    } else {
      Get.snackbar('Sorry', response.data.toString());
      return data;
    }
  }

  Future<String> getButtonStatus(String sId) async {
    String buttonStatus = 'Follow';
    FollowerModel? user;

    final response = await http.get(
        Uri.parse(BASE_URL + USER + currentUserLoginInfo.id!),
        headers: authorization(currentUserLoginInfo.token ?? ''));

    try {
      if (response.statusCode == 200) {
        final currentUser = UserModel.fromJson(jsonDecode(response.body));
        Logger().i(currentUser.data.first.pendingLink.length);
        Logger().i(currentUser.data.first.linked.isNotEmpty);

        if (currentUser.data.first.linked.isNotEmpty) {
          try {
            user = currentUser.data.first.linked
                .singleWhere((user) => user.sId == sId);
          } catch (e) {
            user = null;
          }

          if (user != null && user.toJson() != {}) {
            buttonStatus = 'Unlink';
            return buttonStatus;
          }
        }

        if (currentUser.data.first.pendingLink.isNotEmpty) {
          try {
            user = currentUser.data.first.pendingLink
                .singleWhere((user) => user.sId == sId);
          } catch (e) {
            user = null;
          }

          if (user != null && user.toJson() != {}) {
            buttonStatus = 'Link';
            return buttonStatus;
          }
        }
        return buttonStatus;
      }
    } catch (e) {
      Logger().e(e);
    }
    return buttonStatus;
  }

  Future<String> handleFollow(String sId, String userName) async {
    FollowerModel? user;
    final data = {
      "userId": currentUserLoginInfo.id,
    };

    final response = await http.get(
        Uri.parse(BASE_URL + USER + currentUserLoginInfo.id!),
        headers: authorization(currentUserLoginInfo.token ?? ''));

    try {
      if (response.statusCode == 200) {
        final currentUser = UserModel.fromJson(jsonDecode(response.body));

        if (currentUser.data.first.linked.isNotEmpty) {
          try {
            user = currentUser.data.first.linked
                .singleWhere((user) => user.sId == sId);
          } catch (e) {
            user = null;
          }

          if (user != null && user.toJson() != {}) {
            // TODO: call unlink api
            try {
              final response = await dio.post(BASE_URL + UNLINK + sId,
                  options: Options(
                      headers: authorization(currentUserLoginInfo.token!)),
                  data: data);
              if (response.statusCode == 200) {
                Get.snackbar('Success!', response.data.toString());
                return 'Link';
              }
            } catch (e) {
              Logger().e(e);
              return 'Unlink';
            }
          }
        }

        if (currentUser.data.first.pendingLink.isNotEmpty) {
          try {
            user = currentUser.data.first.pendingLink
                .singleWhere((user) => user.sId == sId);
          } catch (e) {
            user = null;
          }

          if (user != null && user.toJson() != {}) {
            // TODO: call link api
            try {
              final response = await dio.post(BASE_URL + MAKE_LINK + sId,
                  options: Options(
                      headers: authorization(currentUserLoginInfo.token!)),
                  data: data);
              if (response.statusCode == 200) {
                Get.snackbar('Success!', response.data.toString());
                return 'Unlink';
              } else {
                Get.snackbar('Sorry!', response.data.toString());
                return 'Link';
              }
            } catch (e) {
              Logger().e(e);
              return 'Link';
            }
          }
        }

        // TODO: call follow api

        try {
          final response = await dio.post(BASE_URL + MAKE_FOLLOW + sId,
              options:
                  Options(headers: authorization(currentUserLoginInfo.token!)),
              data: data);

          if (response.statusCode == 200) {
            Get.snackbar('Congrats!', FOLLOW_DONE_MSG + userName);
            return 'Unfollow';
          } else {
            Get.snackbar('Sorry!', response.data);
            return 'Follow';
          }
        } catch (e) {
          Logger().e(e);
          return 'Follow';
        }
      }
    } catch (e) {
      Logger().e(e);
      return 'Follow';
    }
    return 'Follow';
  }
}
