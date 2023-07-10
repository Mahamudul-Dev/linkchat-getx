import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
            Obx(() => controller.isLoading.value ? Container(color: brightWhite, child: Center(child: LoadingAnimationWidget.inkDrop(color: accentColor, size: 30),),) : const SizedBox.shrink())
          ],
        ),
      ),
    );
  
  }
}
