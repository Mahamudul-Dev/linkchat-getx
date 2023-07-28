import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/random_call/controllers/random_call_controller.dart';
import 'package:linkchat/app/modules/random_call/views/random_call_setting_sheet_view.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RandomCallView extends GetView<RandomCallController> {
  const RandomCallView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                AssetManager.GLOBE_LOADING,
                height: 200,
              ),
              const SizedBox(height: 10),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('Finding best matches...',
                      speed: const Duration(milliseconds: 80),
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: ThemeProvider().isSavedLightMood().value
                              ? black
                              : brightWhite))
                ],
                repeatForever: true,
              )
            ],
          ),
        ),
        bottomSheet: Obx(() {
          if (controller.showAdvanceSheet.value) {
            return const RandomCallSettingSheetView();
          } else {
            return const SizedBox.shrink();
          }
        })
    );
  }
}
