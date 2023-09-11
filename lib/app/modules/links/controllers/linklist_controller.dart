import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:logger/logger.dart';

import '../../../data/models/user_model.dart';
import '../../../data/utils/app_strings.dart';
import '../../../database/helpers/helpers.dart';

class LinklistController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Rx<TabController> tabController =
      TabController(length: 2, vsync: this).obs;

  final dio = Dio();

  Rx<Future<List<ShortProfileModel>>?> linkedList =
      Rx<Future<List<ShortProfileModel>>?>(null);
  Rx<Future<List<ShortProfileModel>>?> pendingLinkList =
      Rx<Future<List<ShortProfileModel>>?>(null);

  Future<List<ShortProfileModel>> getLinkedList() async {
    List<ShortProfileModel> result = [];
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + AccountHelper.getUserData().serverId),
          headers: authorization(AccountHelper.getLoginInfo().token!));

      if (response.statusCode == 200) {
        final data = UserModel.fromJson(jsonDecode(response.body));
        if (data.data.first.linked.isNotEmpty) {
          result = data.data.first.linked;
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

  Future<List<ShortProfileModel>> getPendingLinkList() async {
    List<ShortProfileModel> result = [];
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + AccountHelper.getUserData().serverId),
          headers: authorization(AccountHelper.getLoginInfo().token!));

      if (response.statusCode == 200) {
        final data = UserModel.fromJson(jsonDecode(response.body));
        if (data.data.first.pendingLink.isNotEmpty) {
          result = data.data.first.pendingLink;
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

  Future<String> getButtonStatus(String sId) async {
    String buttonStatus = 'Follow';
    ShortProfileModel? user;
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + AccountHelper.getUserData().serverId),
          headers: authorization(AccountHelper.getLoginInfo().token!));

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
    ShortProfileModel? user;
    final data = {
      "userId": AccountHelper.getUserData().serverId,
    };
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + AccountHelper.getUserData().serverId),
          headers: authorization(AccountHelper.getLoginInfo().token!));
      Logger().i(response.statusCode);
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
              final response = await dio.put(BASE_URL + UNLINK + sId,
                  options: Options(
                      headers:
                          authorization(AccountHelper.getLoginInfo().token!)),
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
            Logger().i(user.userName);
          } catch (e) {
            user = null;
          }

          if (user != null) {
            // TODO: call link api
            Logger().i('inside link api call');
            try {
              final response = await http.put(
                  Uri.parse(BASE_URL + MAKE_LINK + sId),
                  headers: authorization(AccountHelper.getLoginInfo().token!));
              Logger().e(response.statusCode);
              if (response.statusCode == 200) {
                Get.snackbar('Success!', response.body.toString());
                return 'Unlink';
              } else {
                Get.snackbar('Sorry!', response.body.toString());
                Logger().e(response.body);
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
              options: Options(
                  headers: authorization(AccountHelper.getLoginInfo().token!)),
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
