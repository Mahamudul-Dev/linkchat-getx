import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../data/utils/app_strings.dart';
import '../../../style/style.dart';
import '../../../widgets/widgets.dart';
import '../controllers/login_controller.dart';
import './email_login_view.dart';

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(AssetManager.APP_LOGO, fit: BoxFit.fill, height: 100, width: 100,)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  WideButton(
                    buttonIcon: AssetManager.TIKTOK_LOGO,
                    buttonText: TIKTOK_LOGIN_BUTTON_TEXT,
                    buttonColor: ThemeProvider().isSavedLightMood() ? cyanWhite : blackAccent,
                    onTap: ()=>Get.offNamed(Routes.REGISTER),
                  ),

                  const SizedBox(height: 15),
                  WideButton(
                    buttonIcon: AssetManager.MAIL_LOGO,
                    buttonText: EMAIL_LOGIN_BUTTON_TEXT,
                    buttonColor: ThemeProvider().isSavedLightMood() ? white : transparentBlack,
                    onTap: ()=>_showEmailLoginView(context),
                  ),
                  const Spacer(),
                  Text(ATTRIBUTE_TEXT, style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
            ),
            Obx(() {
              return controller.isLoading.value
                  ? Container(
                color: ThemeProvider().isSavedLightMood() ? brightWhite : solidMate,
                child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: accentColor, size: 50.w),
                ),
              )
                  : const SizedBox.shrink();
            })
          ],
        ),
      )
    );
  }

  _showEmailLoginView(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder:(context){
          return const EmailLoginView();
        });
  }
}
