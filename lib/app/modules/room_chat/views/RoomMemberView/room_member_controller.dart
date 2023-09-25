import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/models.dart';
import '../../../../data/models/multiple_profile_req_model.dart';
import '../../../../data/models/room_res_model.dart';
import '../../../../services/api_service.dart';
import '../../../links/controllers/linklist_controller.dart';

class RoomMemberViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  RxBool isLinkedScreenLoading = false.obs;
  RxBool memberScreenIsLoading = false.obs;
  RxBool adminScreenIsLoading = false.obs;

  late Rx<TabController> tabController =
      TabController(length: 2, vsync: this).obs;
  final linklistController = LinklistController();

  RxBool selectableMemberList = false.obs;
  RxBool selectableAdminList = false.obs;
  RxBool selectableLinkedList = false.obs;

  RxList<FollowersCheckObjectModel> allMemberList =
      <FollowersCheckObjectModel>[].obs;
  RxList<FollowersCheckObjectModel> allAdminList =
      <FollowersCheckObjectModel>[].obs;
  RxList<FollowersCheckObjectModel> selectedMemberList =
      <FollowersCheckObjectModel>[].obs;
  RxList<FollowersCheckObjectModel> selectedAdminList =
      <FollowersCheckObjectModel>[].obs;

  RxList<FollowersCheckObjectModel> allLinked =
      <FollowersCheckObjectModel>[].obs;
  RxList<FollowersCheckObjectModel> selectedLinked =
      <FollowersCheckObjectModel>[].obs;

  Future<void> initScreen(
      List<String> adminsIds, List<String> membersIds, RoomModel room) async {
    await getAllAdmin(adminsIds);
    await getAllMember(membersIds, room);
  }

  Future<GetMultipleProfileModel?> getAllAdmin(List<String> adminsIds) async {
    isLoading.value = true;
    if (selectedAdminList.isEmpty) {
      selectableAdminList.value = false;
    }

    final profiles = await ApiService.getMultipleProfile(
        GetMultipleProfileReqModel(idList: adminsIds));

    if (profiles!.profiles.isNotEmpty) {
      allAdminList.clear();
      for (var i = 0; i < profiles.profiles.length; i++) {
        allAdminList.add(FollowersCheckObjectModel(
            serverId: profiles.profiles[i].sId,
            uid: int.parse(profiles.profiles[i].uid),
            userName: profiles.profiles[i].userName,
            profilePic: profiles.profiles[i].profilePic,
            tagline: profiles.profiles[i].tagLine));
      }
    }
    isLoading.value = false;
    return profiles;
  }

  Future<GetMultipleProfileModel?> getAllMember(
      List<String> membersIds, RoomModel room) async {
    isLoading.value = true;
    if (selectedMemberList.isEmpty) {
      selectableMemberList.value = false;
    }
    final profiles = await ApiService.getMultipleProfile(
        GetMultipleProfileReqModel(idList: membersIds));

    if (profiles!.profiles.isNotEmpty) {
      allMemberList.clear();
      for (var i = 0; i < profiles.profiles.length; i++) {
        if (!room.admins.contains(profiles.profiles[i].sId)) {
          allMemberList.add(FollowersCheckObjectModel(
              serverId: profiles.profiles[i].sId,
              uid: int.parse(profiles.profiles[i].uid),
              userName: profiles.profiles[i].userName,
              profilePic: profiles.profiles[i].profilePic,
              tagline: profiles.profiles[i].tagLine));
        }
      }
    }
    isLoading.value = false;
    return profiles;
  }

  void selectionMemberToggle(FollowersCheckObjectModel member, int index) {
    allMemberList[index].isChecked.value =
        !allMemberList[index].isChecked.value;
    if (allMemberList[index].isChecked.value == true) {
      selectedMemberList.add(allMemberList[index]);
      if (selectedMemberList.isNotEmpty) {
        selectableMemberList.value = true;
      } else {
        selectableMemberList.value = false;
      }
    } else if (allMemberList[index].isChecked.value == false) {
      selectedMemberList.removeWhere(
          (element) => element.serverId == allMemberList[index].serverId);
      if (selectedMemberList.isNotEmpty) {
        selectableMemberList.value = true;
      } else {
        selectableMemberList.value = false;
      }
    }
  }

  void selectionLinkedToggle(FollowersCheckObjectModel member, int index) {
    allLinked[index].isChecked.value = !allLinked[index].isChecked.value;
    if (allLinked[index].isChecked.value == true) {
      selectedLinked.add(allLinked[index]);
      if (selectedLinked.isNotEmpty) {
        selectableLinkedList.value = true;
      } else {
        selectableLinkedList.value = false;
      }
    } else if (allLinked[index].isChecked.value == false) {
      selectedLinked.removeWhere(
          (element) => element.serverId == allLinked[index].serverId);
      if (selectedLinked.isNotEmpty) {
        selectableLinkedList.value = true;
      } else {
        selectableLinkedList.value = false;
      }
    }
  }

  void selectionAdminToggle(FollowersCheckObjectModel member, int index) {
    allAdminList[index].isChecked.value = !allAdminList[index].isChecked.value;
    if (allAdminList[index].isChecked.value == true) {
      selectedAdminList.add(allAdminList[index]);
      if (selectedAdminList.isNotEmpty) {
        selectableAdminList.value = true;
      } else {
        selectableAdminList.value = false;
      }
    } else if (allAdminList[index].isChecked.value == false) {
      selectedAdminList.removeWhere(
          (element) => element.serverId == allAdminList[index].serverId);
      if (selectedAdminList.isNotEmpty) {
        selectableAdminList.value = true;
      } else {
        selectableAdminList.value = false;
      }
    }
  }

  Future<List<ShortProfileModel>> getLinkedList(RoomModel room) async {
    final linkedList = await linklistController.getLinkedList();
    isLoading.value = true;
    allLinked.clear();
    for (var i = 0; i < linkedList.length; i++) {
      if (!room.members.contains(linkedList[i].sId)) {
        allLinked.add(FollowersCheckObjectModel(
            serverId: linkedList[i].sId,
            uid: int.parse(linkedList[i].uid),
            userName: linkedList[i].userName,
            profilePic: linkedList[i].profilePic,
            tagline: linkedList[i].tagLine));
      }
    }
    isLoading.value = false;
    return linkedList;
  }

  Future<void> addMember(String roomId) async {
    isLinkedScreenLoading.value = true;
    List<String> linkedIdList = [];

    for (var i = 0; i < selectedLinked.length; i++) {
      linkedIdList.add(selectedLinked[i].serverId);
    }
    Logger().i(linkedIdList);

    final response = await ApiService.addMemberToRoom(roomId, linkedIdList);
    if (response.statusCode == 200) {
      for (var i = 0; i < linkedIdList.length; i++) {
        allMemberList.add(allLinked
            .singleWhere((element) => element.serverId == linkedIdList[i]));
        allLinked.remove(allLinked
            .singleWhere((element) => element.serverId == linkedIdList[i]));
      }
      isLinkedScreenLoading.value = false;
      Get.snackbar('Success', 'Member added to the room');
      linkedIdList.clear();
      selectedLinked.clear();
      selectableLinkedList.value = false;
      Get.back();
    } else if (response.statusCode == 404) {
      isLinkedScreenLoading.value = false;
      Get.snackbar('Opps', response.data);
      linkedIdList.clear();
      selectedMemberList.clear();
    } else {
      isLinkedScreenLoading.value = false;
      Get.snackbar('Opps', 'There was a error, please check your connection');
      linkedIdList.clear();
      selectedMemberList.clear();
    }
  }

  Future<void> removeMember(RoomModel room) async {
    memberScreenIsLoading.value = true;
    List<String> memberIdList = [];
    List<String> newMemberIdsList = [];

    for (var i = 0; i < selectedMemberList.length; i++) {
      memberIdList.add(selectedMemberList[i].serverId);
    }
    Logger().i(memberIdList);

    final response =
        await ApiService.removeMemberFromRoom(room.id, memberIdList.first);
    if (response.statusCode == 200) {
      for (var i = 0; i < memberIdList.length; i++) {
        allMemberList.remove(allMemberList
            .singleWhere((element) => element.serverId == memberIdList[i]));
      }

      for (var i = 0; i < allMemberList.length; i++) {
        newMemberIdsList.add(allMemberList[i].serverId);
      }

      memberScreenIsLoading.value = false;
      Get.snackbar('Success', 'Member removed from the room');
      memberIdList.clear();
      selectedMemberList.clear();
      selectableMemberList.value = false;
      await getAllMember(newMemberIdsList, room);
    } else if (response.statusCode == 404) {
      memberScreenIsLoading.value = false;
      Get.snackbar('Opps', response.data);
      memberIdList.clear();
      selectedAdminList.clear();
    } else {
      memberScreenIsLoading.value = false;
      Get.snackbar('Opps', 'There was a error, please check your connection');
      memberIdList.clear();
      selectedAdminList.clear();
    }
  }

  Future<void> makeAdmin(String roomId) async {
    memberScreenIsLoading.value = true;
    List<String> memberList = [];

    for (var i = 0; i < selectedMemberList.length; i++) {
      memberList.add(selectedMemberList[i].serverId);
    }
    Logger().i(memberList);

    final response = await ApiService.addAdminToRoom(roomId, memberList);
    if (response.statusCode == 200) {
      for (var i = 0; i < memberList.length; i++) {
        allAdminList.add(allMemberList
            .singleWhere((element) => element.serverId == memberList[i]));
        allMemberList.remove(allMemberList
            .singleWhere((element) => element.serverId == memberList[i]));
      }
      memberScreenIsLoading.value = false;
      Get.snackbar('Success', 'Admin added to the room');
      memberList.clear();
      selectedMemberList.clear();
      selectableMemberList.value = false;
    } else if (response.statusCode == 404) {
      memberScreenIsLoading.value = false;
      Get.snackbar('Opps', response.data);
      memberList.clear();
      selectedMemberList.clear();
    } else {
      memberScreenIsLoading.value = false;
      Get.snackbar('Opps', 'There was a error, please check your connection');
      memberList.clear();
      selectedMemberList.clear();
    }
  }

  Future<void> removeAdmin(RoomModel room) async {
    adminScreenIsLoading.value = true;
    List<String> adminList = [];
    List<String> newAdminList = [];

    for (var i = 0; i < selectedAdminList.length; i++) {
      adminList.add(selectedAdminList[i].serverId);
    }
    Logger().i(adminList);

    final response =
        await ApiService.removeAdminFromRoom(room.id, adminList.first);
    if (response.statusCode == 200) {
      for (var i = 0; i < adminList.length; i++) {
        allMemberList.add(allAdminList
            .singleWhere((element) => element.serverId == adminList[i]));
        allAdminList.remove(allAdminList
            .singleWhere((element) => element.serverId == adminList[i]));
      }

      for (var i = 0; i < allAdminList.length; i++) {
        newAdminList.add(allAdminList[i].serverId);
      }

      memberScreenIsLoading.value = false;
      Get.snackbar('Success', 'Admin removed from the room');
      await getAllAdmin(newAdminList);
      adminList.clear();
      selectedAdminList.clear();
      selectableAdminList.value = false;
    } else if (response.statusCode == 404) {
      memberScreenIsLoading.value = false;
      Get.snackbar('Opps', response.data);
      adminList.clear();
      selectedAdminList.clear();
    } else {
      memberScreenIsLoading.value = false;
      Get.snackbar('Opps', 'There was a error, please check your connection');
      adminList.clear();
      selectedAdminList.clear();
    }
  }
}
