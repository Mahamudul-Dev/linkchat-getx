import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../data/models/multiple_profile_req_model.dart';
import '../data/models/room_res_model.dart';
import '../database/helpers/helpers.dart';

class ApiService {
  static final _dio = Dio();

  // get single profile
  static Future<UserModel?> getSingleProfile(String sId) async {
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

  // get multiple profile
  static Future<GetMultipleProfileModel?> getMultipleProfile(
      GetMultipleProfileReqModel sIdList) async {
    GetMultipleProfileModel? profile;
    Logger().i(sIdList.toJson());
    try {
      final res = await _dio.post(
        BASE_URL + MULTIPLE_USER,
        data: sIdList.toJson(),
        options: Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)),
      );
      Logger().i(res.data);
      Logger().i(jsonEncode(sIdList.toJson()));

      if (res.statusCode == 200) {
        profile = GetMultipleProfileModel.fromJson(res.data);
      }
    } catch (e) {
      Logger().e(e);
    }

    return profile;
  }
  // get all joined room
  // Future<RoomResModel> getAllJoinedRoom() async {
  //   final response = await _dio.post(path)
  // }
}
