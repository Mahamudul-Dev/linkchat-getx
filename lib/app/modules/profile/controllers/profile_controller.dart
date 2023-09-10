import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:logger/logger.dart';

import '../../../data/models/models.dart';
import '../../../data/utils/utils.dart';
import '../../../database/database.dart';
import '../../../database/helpers/helpers.dart';

class ProfileController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final dio = Dio();

  String formatNumber(int number) {
    final format = NumberFormat.compact();
    return format.format(number);
  }

  ProfileSchema get getCurrentProfile => AccountHelper.getUserData();

  Future<UserModel?> getProfileDetails(String sId) async {
    UserModel? userModel;
    try {
      final response = await http.get(Uri.parse(BASE_URL + USER + sId),
          headers: authorization(AccountHelper.getLoginInfo().token!));
      Logger().i(response.statusCode);
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(jsonDecode(response.body));
        return userModel;
      } else {
        Logger().e(response.body);
        return userModel;
      }
    } catch (e) {
      Logger().e(e);
      return userModel;
    }
  }

  Future<bool> checkLinked(String sId) async {
    UserModel? user;
    ShortProfile? linkedFollower;
    try {
      user = await getProfileDetails(sId);
    } catch (e) {
      user = null;
      Logger().e(e);
    }

    if (user != null && user.toJson() != {}) {
      try {
        final id = user.data.first.linked
            .singleWhere(
                (element) => element.id == AccountHelper.getUserData().serverId)
            .id;

        user = await ApiService.getSingleProfile(id);
      } catch (e) {
        linkedFollower = null;
      }
      if (linkedFollower != null && linkedFollower.toJson() != {}) {
        return Future.value(true);
      }
    }

    return Future.value(false);
  }
}
