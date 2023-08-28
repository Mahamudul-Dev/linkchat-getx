import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../data/utils/app_strings.dart';
import '../../../../style/style.dart';
import '../../../../widgets/widgets.dart';
import '../../controllers/login_controller.dart';


class EmailLoginView extends GetView<LoginController> {
  const EmailLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Form(
              key: controller.loginFormKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    EMAIL_LOGIN_WELCOME_TEXT,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  EditTextFieldView(
                    iconData: Icons.email_rounded,
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController.value,
                    hintText: 'Enter your email address',
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'Email is required.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  EditTextFieldView(
                    iconData: Icons.password,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    controller: controller.pinController.value,
                    hintText: 'Type your pin',
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'Pin is required.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: ()=> controller.loginWithEmail(),
                          style: const ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll(accentColor)),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: brightWhite),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Obx(() {
              return controller.isLoading.value
                  ? Container(
                color: ThemeProvider().isSavedLightMood().value ? brightWhite : solidMate,
                child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: accentColor, size: 50.w),
                ),
              )
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
