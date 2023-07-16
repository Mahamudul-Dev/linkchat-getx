import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => controller.regViews[controller.currentView.value]),
            Obx(() => controller.isLoading.value
                ? Container(
                    color: ThemeProvider().isSavedLightMood()
                        ? brightWhite
                        : solidMate,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.inkDrop(
                              color: accentColor, size: 50),
                          Obx(() => controller.loadingMessage.value.isNotEmpty
                              ? const SizedBox(height: 30)
                              : const SizedBox.shrink()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => controller.loadingMessage.value.isNotEmpty ? DefaultTextStyle(
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        WavyAnimatedText(controller.loadingMessage.value, textStyle:  const TextStyle(fontWeight: FontWeight.w600, color: accentColor)),
                                      ],
                                      isRepeatingAnimation: true,
                                      repeatForever: true,
                                    ),
                                  ) : const SizedBox.shrink())
                              
                            ],
                          )
                        ],
                      ),
                    ))
                : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
