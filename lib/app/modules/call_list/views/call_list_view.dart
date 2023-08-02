import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

import '../controllers/call_list_controller.dart';

class CallListView extends GetView<CallListController> {
  const CallListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Call History'),
            bottom: const SearchBarView(
              height: 45,
              hint: 'Search calls...',
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(AssetManager.HISTORY_ANIM, height: 150),
              Text(
                'No incomming or outgoing call found!',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ThemeProvider().isSavedLightMood().value
                      ? black
                      : brightWhite,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              Get.toNamed(Routes.LINK_LIST, arguments: {'isChat': false}),
          label: Row(
            children: [
              Lottie.asset(AssetManager.CALL_ICON_ANIM, height: 30, width: 30),
              const Text(
                'Make Call',
                style:
                    TextStyle(color: brightWhite, fontWeight: FontWeight.bold),
              )
            ],
          ),
          backgroundColor: accentColor,
        ));
  }
}
