import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/models.dart';
import '../../../../data/models/multiple_profile_req_model.dart';
import '../../../../data/models/room_res_model.dart';
import '../../../../services/api_service.dart';
import '../../../links/controllers/linklist_controller.dart';

class RoomMemberViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  final _dio = Dio();
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

  Future<GetMultipleProfileModel?> getAllAdmin(List<String> adminsIds) async {
    isLoading.value = true;

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

  Future<List<ShortProfileModel>> getLinkedList() async {
    final linkedList = await linklistController.getLinkedList();
    isLoading.value = true;
    allLinked.clear();
    for (var i = 0; i < linkedList.length; i++) {
      allLinked.add(FollowersCheckObjectModel(
          serverId: linkedList[i].sId,
          uid: int.parse(linkedList[i].uid),
          userName: linkedList[i].userName,
          profilePic: linkedList[i].profilePic,
          tagline: linkedList[i].tagLine));
    }
    isLoading.value = false;
    return linkedList;
  }

  Future<void> addMember() async {}
  Future<void> removeMember() async {}
  Future<void> makeAdmin() async {}
  Future<void> removeAdmin() async {}
}
