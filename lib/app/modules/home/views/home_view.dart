import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/home/views/bottom_nav_bar_view.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: const NavigationDrawerView(),
      body: Obx(() => controller
          .pages[controller.currentIndex.value]),
      bottomNavigationBar: const BottomNavBarView(),
    );
  }
}
