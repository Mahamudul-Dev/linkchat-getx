import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkchat/app/modules/register/controllers/register_controller.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/asset_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import 'package:get/get.dart';

class OtpView extends GetView <RegisterController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OTP', style: TextStyle(color: accentColor),),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Lottie.asset(AssetManager.OTP_ANIM, height: 120, width: 120),
                Text('Please check your email, \nWe send a otp in ${controller.userEmailController.value.text.trim()}', style: TextStyle(fontSize: 16.sp), textAlign: TextAlign.center,),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      controller: controller.userOtpController.value,
                      onCompleted: (value)=> controller.otpText.value = value,
                    defaultPinTheme: PinTheme(
                      width: 55,
                      height: 55,
                      textStyle: TextStyle(
                          fontSize: 20.sp,
                          color: accentColor,
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 236, 236),
                        border: Border.all(
                            color: const Color.fromARGB(255, 202, 244, 254)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: TextButton(onPressed: ()=> controller.previous(), child: Text('Previous', style: TextStyle(color: accentColor, fontWeight: FontWeight.w600, fontSize: 16.sp),)),
            )
          ],
        ),
      floatingActionButton: Obx(() => controller.otpText.value != "" ? FloatingActionButton.extended(backgroundColor: accentColor, onPressed: (){
        
        Future.delayed(const Duration(seconds: 2), ()=> controller.next(isEmailView: false));
      }, label: const Text('Verify', style: TextStyle(fontWeight: FontWeight.w600, color: brightWhite),)) : const SizedBox.shrink()),
    );
  }
}
