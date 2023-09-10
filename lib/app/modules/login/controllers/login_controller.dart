import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/models.dart';
import '../../../database/helpers/helpers.dart';
import '../../../routes/app_pages.dart';
import '../../../data/utils/utils.dart';
import '../../../data/utils/app_strings.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> pinController = TextEditingController().obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  Future<void> loginWithEmail() async {
    Logger().i("Exicuting Login Function");

    if (loginFormKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'email': emailController.value.text.trim(),
        'password': pinController.value.text.trim()
      };

      try {
        isLoading.value = true;
        final response =
            await http.post(Uri.parse(BASE_URL + LOGIN), body: data);
        Logger().i(response.statusCode);
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          final result = EmailLoginResponseModel.fromJson(json);
          Logger().e(result);
          AccountHelper.saveEmailLoginInfo(result);
          try {
            final response = await http.get(
                Uri.parse(BASE_URL + USER + result.id.toString()),
                headers: {'Authorization': 'Bearer ${result.token}'});
            Logger().i(response.body);
            if (response.statusCode == 200) {
              final data = UserModel.fromJson(jsonDecode(response.body));
              Logger().e(data.toJson());
              AccountHelper.saveUserData(data.data.first);
              isLoading.value = false;
              Get.offAllNamed(Routes.HOME);
            } else {
              Logger().e(response.body);
              Get.snackbar('Opps!', response.body);
            }
          } catch (e) {
            Logger().e(e);
          }
        } else {
          isLoading.value = false;
          Logger().e(response.body);
          Get.snackbar('Opps', response.body);
        }
      } catch (e) {
        isLoading.value = false;
        Logger().e(e);
      }
    } else {
      isLoading.value = false;
      Get.snackbar('Opps!', EMAIL_LOGIN_FORM_VALIDATION_TEXT);
    }
  }
}
