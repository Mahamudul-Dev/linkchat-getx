import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:linkchat/app/data/utils/app_strings.dart';
import 'package:linkchat/app/modules/chat/views/activity_list_horizontal_view.dart';
import 'package:linkchat/app/modules/chat/views/chat_list_tile_view.dart';
import 'package:linkchat/app/modules/home/controllers/home_controller.dart';
import 'package:linkchat/app/modules/search/views/SearchViewDelegate.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Chats'),
            leading: IconButton(
                onPressed: () {
                  Get.find<HomeController>().openNavigationDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: ThemeProvider().isSavedLightMood().value
                      ? black
                      : brightWhite,
                )),
            actions: [
              IconButton(
                  onPressed: () => showSearch(
                      context: context, delegate: SearchViewDelegate()),
                  icon: Obx(() => Icon(
                        Icons.search_rounded,
                        color: ThemeProvider().isSavedLightMood().value
                            ? black
                            : brightWhite,
                      ))),
              IconBadge(
                icon: const Icon(Icons.notifications),
                itemCount: 6,
                badgeColor: accentColor,
                itemColor: brightWhite,
                hideZero: true,
                onTap: () => Get.toNamed(Routes.NOTIFICATION),
              ),
            ],
            bottom: const SearchBarView(
              height: 45,
              hint: 'Search chats..',
            )),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerViewIsScrollable) {
          return [
            const SliverToBoxAdapter(
              child: ActivityListHorizontalView(),
            )
          ];
        }, body: Obx(() {
          return controller.chatList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(AssetManager.NO_CHAT_ANIM,
                          height: 150, width: 230),
                      Text(
                        NO_CHAT_MESSAGE,
                        style: TextStyle(
                            color: ash,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.chatList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        bool dismiss = false;
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    "Are you sure you want to delete the item"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        dismiss = true;
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        dismiss = false;
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No")),
                                ],
                              );
                            });
                        return dismiss;
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (diresction) =>
                          Get.snackbar('Deleted', 'Chat Deleted Successfully'),
                      child: ChatListTileView(
                        index: index,
                      ),
                    );
                  },
                );
        })),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              Get.toNamed(Routes.FOLLOWERS, arguments: {'isChat': true}),
          label: Row(
            children: [
              const Text(
                'Start Chat',
                style:
                    TextStyle(color: brightWhite, fontWeight: FontWeight.bold),
              ),
              Lottie.asset(AssetManager.ARROW_RIGHT_ANIM, width: 30, height: 20)
            ],
          ),
          backgroundColor: accentColor,
        ));
  }
}
