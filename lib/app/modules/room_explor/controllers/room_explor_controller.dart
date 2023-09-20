import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/models/room_res_model.dart';
import '../../../data/utils/utils.dart';
import '../../../database/helpers/account_helper.dart';

class RoomExplorController extends GetxController {
  final dio = Dio();
  RxBool isLoading = false.obs;
  TextEditingController joiningPinController = TextEditingController();

  Future<RoomResModel> getPublicRooms() async {
    late RoomResModel responseModel;
    try {
      final response = await dio.get(BASE_URL + GET_PUBLIC_ROOM,
          options: Options(
              headers: authorization(AccountHelper.getLoginInfo().token!)));

      if (response.statusCode == 200) {
        responseModel = RoomResModel.fromJson(response.data);
      }

      Logger().i(response.data);
    } catch (e) {
      Logger().e(e);
    }
    return responseModel;
  }

  Future<void> joinRoom(int roomCode) async {
    Get.back();
    isLoading.value = true;
    final bodyData = {'joinCode': roomCode};
    try {
      final response = await dio.post(BASE_URL + JOIN_ROOM,
          options: Options(
              headers: authorization(AccountHelper.getLoginInfo().token!)),
          data: bodyData);

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', 'You succesfully joined the room');
      } else if (response.statusCode == 400) {
        isLoading.value = false;
        Get.snackbar('Opps', response.data['error']);
      } else {
        isLoading.value = false;
        Get.snackbar('Opps', 'There was a error, please try later');
      }
    } catch (e) {
      isLoading.value = false;
      Logger().e(e);
    }
  }
}
