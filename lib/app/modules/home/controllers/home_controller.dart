import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/modules/call_list/views/call_list_view.dart';
import 'package:linkchat/app/modules/chat/views/chat_view.dart';
import 'package:linkchat/app/modules/dialer/views/dialer_view.dart';
import 'package:linkchat/app/modules/random_call/views/random_call_view.dart';
import 'package:logger/logger.dart';

import '../../../database/cached_db_helper.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  final helper = CachedDbHelper();

  @override
  void onInit() {
    super.onInit();
    Logger().i(DatabaseHelper().getUserData());
    Logger().i(helper.getSearchSuggestion());
  }

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
