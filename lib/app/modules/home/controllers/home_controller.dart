import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/demo/demo.dart';

import 'package:flutter/material.dart';
import 'package:linkchat/app/modules/call_list/views/call_list_view.dart';
import 'package:linkchat/app/modules/chat/views/chat_view.dart';
import 'package:linkchat/app/modules/dialer/views/dialer_view.dart';
import 'package:linkchat/app/modules/random_call/views/random_call_view.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  UserModel get currentUser => profiles.first;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> pages = [
    const ChatView(),
    const CallListView(),
    const RandomCallView(),
    const DialerView()
  ];

  // bottom navigation
  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void openNavigationDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}
