import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../data/models/multiple_profile_req_model.dart';
import '../data/models/room_res_model.dart';
import '../database/helpers/helpers.dart';

class ApiService {
  static final _dio = dio.Dio();

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
        options: dio.Options(
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

  static Future<dio.Response> getRoomInfo(String roomId) async {
    final bodyData = {"groupId": roomId};

    final response = await _dio.post(BASE_URL + GET_SINGLE_ROOM,
        options: dio.Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)),
        data: bodyData);

    return response;
  }

  static Future<dio.Response> addAdminToRoom(
      String roomId, List<String> members) async {
    final bodyData = {"groupId": roomId, "memberIds": members};

    final response = await _dio.post(BASE_URL + ROOM_ADMIN_ADD,
        data: bodyData,
        options: dio.Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)));

    return response;
  }

  static Future<dio.Response> removeAdminFromRoom(
      String roomId, String adminId) async {
    final bodyData = {"groupId": roomId, "memberId": adminId};

    final response = await _dio.delete(BASE_URL + ROOM_ADMIN_REMOVE,
        data: bodyData,
        options: dio.Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)));

    return response;
  }

  static Future<dio.Response> addMemberToRoom(
      String roomId, List<String> memberIds) async {
    final bodyData = {"groupId": roomId, "memberIds": memberIds};

    final response = await _dio.post(BASE_URL + ROOM_MEMBER_ADD,
        data: bodyData,
        options: dio.Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)));

    return response;
  }

  static Future<dio.Response> removeMemberFromRoom(
      String roomId, String memberId) async {
    final bodyData = {"groupId": roomId, "memberId": memberId};

    final response = await _dio.delete(BASE_URL + ROOM_MEMBER_REMOVE,
        data: bodyData,
        options: dio.Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)));

    return response;
  }

  static Future<dio.Response> updateRoom(RoomModel room, File roomImage,
      String roomName, String groupDescription) async {
    dio.FormData bodyData = dio.FormData.fromMap({
      'groupName': roomName,
      'groupImage': await dio.MultipartFile.fromFile(
        roomImage.path,
        filename:
            'Room-Image-${room.groupName} ${DateTime.now().toIso8601String()}', // Replace with the desired file name
      ),
      'groupDescription': groupDescription
    });

    final response = await _dio.put(BASE_URL + UPDATE_ROOM + room.id,
        data: bodyData,
        options: dio.Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)));

    return response;
  }

  static Future<dio.Response> updateRoomSettings(
      Settings settings, String roomId) async {
    dio.FormData bodyData =
        dio.FormData.fromMap({'settings': settings.toJson()});

    final response = await _dio.put(BASE_URL + UPDATE_ROOM + roomId,
        data: bodyData,
        options: dio.Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)));

    return response;
  }
}
