import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/services/auth_service.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/widgets/views/edit_text_field_view.dart';
import '../controllers/register_controller.dart';

class EmailView extends GetView<RegisterController> {
  const EmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Stack(
            children: [
              Form(
                key: controller.formKey,
                child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      children: [
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
                  controller: controller.userEmailController,
                  hintText: 'Enter your email address',
                  validator: (value) {
                    if (value == '' || value == null) {
                      return 'Email is required.';
                    } else {
                      return null;
                    }
                  },
                )
                      ],
                    ),
              ),

              Positioned(bottom: 10, left: 10, child: TextButton(onPressed: ()=> Get.offNamed(Routes.HOME), child: Text('Skip', style: TextStyle(fontSize: 19.sp, color: accentColor, fontWeight: FontWeight.bold),)))
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              if (AuthService().isValidEmail(controller.userEmailController.text.trim())) {
                controller.isLoading.value = true;
              Future.delayed(const Duration(seconds: 2), ()=> controller.next());
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
