import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/user_model.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/room_schema.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:logger/logger.dart';

import '../../../data/models/create_room_res_model.dart';
import '../../../data/models/room_conversation_model.dart';
import '../../../data/models/room_res_model.dart';
import '../../../database/helpers/helpers.dart';
import '../../../services/api_service.dart';

class RoomChatController extends GetxController {
  // final uuid = const Uuid();
  RxBool isLoading = false.obs;
  RxList<ShortProfileModel> allLinkList = <ShortProfileModel>[].obs;
  RxList<ShortProfileModel> linkList = <ShortProfileModel>[].obs;
  RxList<ShortProfileModel> selectedLink = <ShortProfileModel>[].obs;
  TextEditingController groupNameController = TextEditingController();
  static RxList<RoomModel> joinedRooms = <RoomModel>[].obs;
  final dio = Dio();

  List<String> groupVisibilityItems = ["Public", "Private"];
  RxString selectedVisibility = 'Public'.obs;

  static RxList<RoomConversationModel> roomConversation =
      <RoomConversationModel>[].obs;

  @override
  void onInit() async {
    roomConversation.clear();
    final localRooms = RoomChatHelper.roomSchemaBox.getAll();

    for (var i = 0; i < localRooms.length; i++) {
      roomConversation.add(RoomConversationModel(
          roomName: localRooms[i].groupName,
          roomId: localRooms[i].groupId,
          messages: localRooms[i].messages.toList().obs));
    }

    try {
      isLoading.value = true;
      final profile = await ApiService.getSingleProfile(
          AccountHelper.currentUserBox.getAll().first.serverId);
      if (profile != null) {
        allLinkList.clear();
        linkList.clear();
        Logger().i(profile.data.first.linked);

        allLinkList.addAll(profile.data.first.linked);
        linkList.addAll(profile.data.first.linked);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Logger().e(e);
    }
    super.onInit();
  }

  Future<void> joinRoom(int roomCode) async {
    Get.back();
    isLoading.value = true;
    final bodyData = {'joinCode': roomCode};
    try {
      final response = await dio.post(BASE_URL + JOIN_ROOM,
          options: Options(
              headers: authorization(AccountHelper.getLoginInfo().token!)),
          data: bodyData);

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', 'You succesfully joined the room');
        // RoomChatHelper.saveRoomInLocal(response.data);
      } else if (response.statusCode == 400) {
        isLoading.value = false;
        Get.snackbar('Opps', response.data['error']);
      } else {
        isLoading.value = false;
        Get.snackbar('Opps', 'There was a error, please try later');
      }
    } catch (e) {
      isLoading.value = false;
      Logger().e(e);
    }
  }

  void queryLink(String query) {
    linkList.clear();
    if (query.isEmpty) {
      linkList.addAll(allLinkList);
    } else {
      linkList.addAll(allLinkList.where(
          (item) => item.userName.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void toggleItem(ShortProfileModel link) {
    if (selectedLink.contains(link)) {
      selectedLink.remove(link);
    } else {
      selectedLink.add(link);
    }
  }

  Future<void> createRoom() async {
    isLoading.value = true;
    Get.back();
    final selectedLinkIds = <String>[];
    for (var i = 0; i < selectedLink.length; i++) {
      selectedLinkIds.add(selectedLink[i].sId);
    }
    Logger().i(selectedLinkIds);
    final bodyData = {
      "groupName": groupNameController.text,
      "groupDescription": "N/A",
      "settings": {"groupVisibility": selectedVisibility.value},
      "members": selectedLinkIds
    };
    try {
      final response = await dio.post(BASE_URL + CREATE_ROOM,
          data: bodyData,
          options: Options(
              headers: authorization(AccountHelper.getLoginInfo().token!)));
      if (response.statusCode == 200) {
        isLoading.value = false;
        // SocketIOService.socket.emit('joinGroup', );
        Logger().i(response.data);
        final data = RoomCreateResModel.fromJson(response.data);
        RoomChatHelper.saveRoomInLocal(data.data);
        Get.toNamed(Routes.ROOM_CONVERSATION, arguments: {'room': data.data});
      }
    } catch (e) {
      isLoading.value = false;
      Logger().e(e);
    }
  }

  Future<RoomResModel> getPublicRooms() async {
    final response = await dio.get(BASE_URL + GET_PUBLIC_ROOM,
        options: Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)));

    late RoomResModel responseModel;

    if (response.statusCode == 200) {
      responseModel = RoomResModel.fromJson(response.data);
    }

    return responseModel;
  }

  Future<RoomResModel?> getAllJoinedRooms() async {
    final savedRoomsLocal = await RoomChatHelper.getJoinedRooms();
    RoomResModel? joinedRooms;

    List<String> listOfRoomId = [];

    for (var i = 0; i < savedRoomsLocal.length; i++) {
      listOfRoomId.add(savedRoomsLocal[i].groupId);
    }

    final bodyData = {"groupIds": listOfRoomId};

    final response = await dio.post(BASE_URL + GET_MULTIPLE_ROOM,
        options: Options(
            headers: authorization(AccountHelper.getLoginInfo().token!)),
        data: bodyData);
    Logger().i(response.data);
    if (response.statusCode == 200) {
      joinedRooms = RoomResModel.fromJson(response.data);
      joinedRooms.data.map((room) => roomConversation.add(RoomConversationModel(
          roomName: room.groupName,
          roomId: room.id,
          messages: <RoomMessageSchema>[].obs)));
      return joinedRooms;
    }
    return joinedRooms;
  }
}
