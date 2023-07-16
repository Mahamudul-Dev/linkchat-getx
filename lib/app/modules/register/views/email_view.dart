import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/services/auth_service.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/views/edit_text_field_view.dart';
import 'package:lottie/lottie.dart';
import '../controllers/register_controller.dart';

class EmailView extends GetView<RegisterController> {
  const EmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: [
                Lottie.asset(AssetManager.EMAIL_ANIM, repeat: false, height: 220.h, width: 250.w),
                Text(
                  'Enter Your \nEmail Address',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: accentColor),
                ),
                const SizedBox(
                  height: 80,
                ),
                EditTextFieldView(
                  iconData: Icons.email_rounded,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.userEmailController.value,
                  hintText: 'Enter your email address',
                  onChanged: (value){
                    if (AuthService().isValidEmail(value ?? '')) {
                      controller.typedEmail.value = value ?? '';
                    } else {
                      controller.typedEmail.value = '';
                    }
                  },
                  validator: (value) {
                    if (value == '' || value == null) {
                      return 'Email is required.';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => controller.typedEmail.isNotEmpty ? ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(accentColor)),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: brightWhite),
                  ),
                ) : const SizedBox.shrink())
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              if (AuthService()
                  .isValidEmail(controller.userEmailController.value.text.trim())) {
                
                controller.next(isEmailView: true);
              } else {
                Get.snackbar('Opps', 'Please enter a valid email address');
              }
            }
          },
          backgroundColor: accentColor,
          label: const Row(
            children: [
              Text(
                'Next',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: brightWhite),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: brightWhite,
              ),
            ],
          )),
    );
  }
}
