import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/style/style.dart';

class BlockListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxBool toggleMarkAll = false.obs;
  RxBool isUnBlockUserChecked = false.obs;
  RxBool isBlockUserChecked = false.obs;

  List<Widget> tabs = [
    Tab(
      text: 'Blocked Users',
      icon: Icon(
        Icons.block_rounded,
        color: ThemeProvider().isSavedLightMood().value
            ? blackAccent
            : brightWhite,
      ),
    ),
    Tab(
      text: 'Followers',
      icon: Icon(
        Icons.people,
        color: ThemeProvider().isSavedLightMood().value
            ? blackAccent
            : brightWhite,
      ),
    ),
  ];
  List<FollowersCheckObjectModel> blockList = [
    FollowersCheckObjectModel(
        serverId: '123456',
        uid: 345678,
        userName: 'Mahamudul Hasan',
        profilePic:
            'https://images.pexels.com/photos/17490386/pexels-photo-17490386/free-photo-of-a-portrait-of-a-woman-in-sunlight.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        date: DateTime.now())
  ].obs;

  List<FollowersCheckObjectModel> markedFollowers =
      <FollowersCheckObjectModel>[].obs;

  List<FollowersCheckObjectModel> unMarkedFollowers =
      <FollowersCheckObjectModel>[].obs;

  void singleMark(int index, bool? value) {
    if (tabController.index == 0) {
      blockList[index].isChecked.value = value ?? false;
      if (blockList[index].isChecked.value) {
        isBlockUserChecked.value = true;
      } else {
        isBlockUserChecked.value = false;
      }
    } else {
      unMarkedFollowers[index].isChecked.value = value ?? false;
      if (unMarkedFollowers[index].isChecked.value) {
        isUnBlockUserChecked.value = true;
      } else {
        isUnBlockUserChecked.value = false;
      }
    }
  }

  void markAll() {
    if (tabController.index == 0) {
      for (int i = 0; i < blockList.length; i++) {
        blockList[i].isChecked.value = !blockList[i].isChecked.value;
      }
    } else {
      for (int i = 0; i < unMarkedFollowers.length; i++) {
        unMarkedFollowers[i].isChecked.value =
            !unMarkedFollowers[i].isChecked.value;
      }
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }
}
