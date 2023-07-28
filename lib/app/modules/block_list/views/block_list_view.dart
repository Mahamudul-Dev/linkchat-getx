import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/block_list/controllers/block_list_controller.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlockListView extends GetView <BlockListController>{
  BlockListView({Key? key}) : super(key: key);
  final FollowersController followersController = Get.find<FollowersController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: controller.tabs.length,
          child: NestedScrollView(
              headerSliverBuilder: (context, bool boxScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: const Text('Block List'),
                    pinned: true,
                    floating: true,
                    snap: true,
                    backgroundColor: ThemeProvider().isSavedLightMood().value
                        ? brightWhite
                        : black,
                    actions: [
                      ElevatedButton.icon(
                        onPressed: () => controller.markAll(),
                        icon: const Icon(
                          Icons.done_all,
                          color: brightWhite,
                        ),
                        label: const Text(
                          'Mark All',
                          style: TextStyle(color: brightWhite),
                        ),
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(accentColor)),
                      )
                    ],
                    bottom: TabBar(
                      tabs: controller.tabs,
                      labelColor: ThemeProvider().isSavedLightMood().value
                          ? blackAccent
                          : brightWhite,
                      controller: controller.tabController,
                      indicatorColor: ThemeProvider().isSavedLightMood().value
                          ? black
                          : brightWhite,
                    ),
                  )
                ];
              },
              body: TabBarView(
                  controller: controller.tabController,
                  children: [buildBlockedList(), buildUnBlockedUserList()]))),
    );
  }
  Widget buildBlockedList() {
  return Scaffold(
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    ThemeProvider().isSavedLightMood().value ? white : blackAccent,
                backgroundImage: CachedNetworkImageProvider('https://images.pexels.com/photos/17490386/pexels-photo-17490386/free-photo-of-a-portrait-of-a-woman-in-sunlight.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
              ),
              title: Text(controller.blockList[index].userName),
              subtitle:
                  Text(timeago.format(controller.blockList[index].date)),
              trailing: Obx(() => Checkbox(
                    value: controller.blockList[index].isChecked.value,
                    onChanged: (value) => controller.singleMark(index, value),
                    checkColor: brightWhite,
                    activeColor: accentColor,
                  )),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: controller.blockList.length),
      floatingActionButton: Obx(() {
        return controller.isBlockUserChecked.value
            ? FloatingActionButton.extended(
                onPressed: () {},
                label: const Text('Unblock'),
                splashColor: brightWhite,
                backgroundColor: accentColor,
              )
            : const SizedBox.shrink();
      }));
}

Widget buildUnBlockedUserList() {
  return Scaffold(
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    ThemeProvider().isSavedLightMood().value ? white : blackAccent,
                backgroundImage: CachedNetworkImageProvider(
                    controller.unMarkedFollowers[index].profilePic),
              ),
              title: Text(controller.unMarkedFollowers[index].userName),
              subtitle: Text(
                  '@3205930'),
              trailing: Obx(() => Checkbox(
                    value: controller.unMarkedFollowers[index].isChecked.value,
                    onChanged: (value) => controller.singleMark(index, value),
                    checkColor: brightWhite,
                    activeColor: accentColor,
                  )),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: controller.unMarkedFollowers.length),
      floatingActionButton: Obx(() {
        return controller.isUnBlockUserChecked.value
            ? FloatingActionButton.extended(
                onPressed: () {},
                label: const Text('Add to block list'),
                icon: const Icon(Icons.add),
                splashColor: brightWhite,
                backgroundColor: accentColor,
              )
            : const SizedBox.shrink();
      }));
}
}
