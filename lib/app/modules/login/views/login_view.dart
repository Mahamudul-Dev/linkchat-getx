import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../data/utils/app_strings.dart';
import '../../../style/style.dart';
import '../../../widgets/widgets.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image(image: const AssetImage(AssetManager.LOGIN_PAGE_BG), fit: BoxFit.cover, filterQuality: FilterQuality.low, height: MediaQuery.of(context).size.height,),
            Container(color: const Color(0xd7000000),),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  WideButton(
                    buttonIcon: AssetManager.TIKTOK_LOGO,
                    buttonText: TIKTOK_LOGIN_BUTTON_TEXT,
                    buttonColor: ThemeProvider().isSavedLightMood().value ? cyanWhite : accentColor,
                    onTap: ()=>Get.offNamed(Routes.REGISTER),
                  ),

                  const SizedBox(height: 15),
                  WideButton(
                    buttonIcon: AssetManager.MAIL_LOGO,
                    buttonText: EMAIL_LOGIN_BUTTON_TEXT,
                    buttonColor: ThemeProvider().isSavedLightMood().value ? white : blackAccent,
                    onTap: ()=> Get.toNamed(Routes.EMAIL_LOGIN),
                  ),
                  const SizedBox(height: 15,),
                  Text(ATTRIBUTE_TEXT, style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}
