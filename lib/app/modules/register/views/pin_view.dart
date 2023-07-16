import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkchat/app/modules/register/controllers/register_controller.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class PinView extends GetView <RegisterController> {
  const PinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AssetManager.OTP_ANIM, height: 120, width: 120, repeat: false),
                Text('Setup PIN', style: TextStyle(fontSize: 26.sp, color: accentColor, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      controller: controller.userPinController.value,
                      onCompleted: (value)=> controller.pinText.value = value,
                    defaultPinTheme: PinTheme(
                      width: 55,
                      height: 55,
                      textStyle: TextStyle(
                          fontSize: 20.sp,
                          color: accentColor,
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: ThemeProvider().isSavedLightMood() ? white : darkAsh,
                        border: Border.all(
                            color: ThemeProvider().isSavedLightMood() ? const Color.fromARGB(255, 202, 244, 254) : accentColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ],
                ),
              ],
            ),
            floatingActionButton: Obx(() => controller.pinText.value != "" ? FloatingActionButton.extended(backgroundColor: accentColor, onPressed: (){
              
        Future.delayed(const Duration(seconds: 2), ()=> controller.next(isEmailView: false));
            }, label: const Text('Set', style: TextStyle(fontWeight: FontWeight.w600, color: brightWhite),)) : const SizedBox.shrink()),
    );
  }
}
