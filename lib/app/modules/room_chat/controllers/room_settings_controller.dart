import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/services/api_service.dart';

import '../../../data/models/room_res_model.dart';

class RoomSettingsController extends GetxController {
  RxBool isLoading = false.obs;

  List<String> groupVisibilityItems = ["public", "private"];
  RxString selectedVisibility = 'public'.obs;
  List<String> anyoneCanAddMemberItems = ["true", "false"];
  RxString selectedAnyoneCanAddMember = 'true'.obs;
  List<String> anyoneCanModifyRoomItems = ["true", "false"];
  RxString selectedAnyoneCanModifyRoom = 'true'.obs;
  List<String> whoCanMessageItems = ["only admin", "everyone"];
  RxString selectedWhoCanMessage = 'everyone'.obs;

  TextEditingController roomMemberCountController = TextEditingController();

  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomDescriptionController = TextEditingController();

  Rx<File?> groupImageFile = Rx<File?>(null);

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      groupImageFile.value = File(result.files.single.path!);
    }
  }

  Future<void> updateRoomInfo(RoomModel room) async {
    isLoading.value = true;
    final response = await ApiService.updateRoom(room, groupImageFile.value!,
        roomNameController.text, roomDescriptionController.text);
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Room Information Updated');
      isLoading.value = false;
      Get.back();
    } else if (response.statusCode == 404) {
      Get.snackbar('Opps', response.data);
      isLoading.value = false;
    } else {
      Get.snackbar('Opps', 'There was a error. Please try latter');
      isLoading.value = false;
    }
  }

  Future<void> updateRoomSettings(String roomId) async {
    isLoading.value = true;
    final settings = Settings(
        groupVisibility: selectedVisibility.value,
        memberLimit: int.parse(roomMemberCountController.text),
        anyoneCanAddMember:
            selectedAnyoneCanAddMember.value == 'true' ? true : false,
        anyoneCanModifyGroup:
            selectedAnyoneCanModifyRoom.value == 'true' ? true : false,
        nudeProtection: false,
        whoCanMessage: selectedWhoCanMessage.value);
    final response = await ApiService.updateRoomSettings(settings, roomId);
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Room Settings Updated');
      isLoading.value = false;
    } else if (response.statusCode == 404) {
      Get.snackbar('Opps', response.data);
      isLoading.value = false;
    } else {
      Get.snackbar('Opps', 'There was a error. Please try latter');
      isLoading.value = false;
    }
  }
}
