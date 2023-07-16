import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:linkchat/app/modules/login/controllers/login_controller.dart';

import '../../../widgets/widgets.dart';
import '../../../data/utils/app_strings.dart';
import '../../../style/style.dart';

class EmailLoginView extends GetView<LoginController> {
  const EmailLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: solidMate,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Form(
              key: controller.loginFormKey,
              child: ListView(
                controller: scrollController,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            color: ThemeProvider().isSavedLightMood()
                                ? accentColor
                                : white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                      ),
                    ],
                  ),
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
                    keyboardType: TextInputType.emailAddress,
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
                          onPressed: () => controller.loginWithEmail(),
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
          );
        });
  }
}
