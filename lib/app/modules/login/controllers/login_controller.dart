import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:linkchat/app/data/models/email_login_response_model.dart';
import 'package:linkchat/app/database/cach_db.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import '../../../data/utils/utils.dart';
import '../../../data/utils/app_strings.dart';

class LoginController extends GetxController {

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> pinController = TextEditingController().obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  void loginWithEmail() async {

    if(loginFormKey.currentState!.validate()){
      Map<String,dynamic> data = {
        'email':emailController.value.text.trim(),
        'password':pinController.value.text.trim()
      };
      Get.back();

      try{
        isLoading.value = true;
        final response = await http.post(Uri.parse(BASE_URL + LOGIN), body: data);
        if(response.statusCode == 200){
          final json = jsonDecode(response.body);
          final result = EmailLoginResponseModel.fromJson(json);
          Logger().e(result);
          CacheDB().saveUserInfo(accessToken: result.token!, userName: result.userName!);
          Logger().e(CacheDB.cacheDb.read('loginInfo'));
          isLoading.value = false;

          Get.offAllNamed(Routes.HOME);
        } else {
          isLoading.value = false;
          Logger().e(response.body);
        }

      } catch(e){
        isLoading.value = false;
        Logger().e(e);
      }

    } else {
      isLoading.value = false;
      Get.snackbar('Opps!', EMAIL_LOGIN_FORM_VALIDATION_TEXT);
    }

  }
 
}
