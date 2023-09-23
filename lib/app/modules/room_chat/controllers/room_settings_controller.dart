import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RoomSettingsController extends GetxController{

  List<String> groupVisibilityItems = ["Public", "Private"];
  RxString selectedVisibility = 'Public'.obs;
  List<String> anyoneCanAddMemberItems = ["True", "False"];
  RxString selectedAnyoneCanAddMember = 'True'.obs;
  List<String> anyoneCanModifyRoomItems = ["True", "False"];
  RxString selectedAnyoneCanModifyRoom = 'True'.obs;
  List<String> whoCanMessageItems = ["Only Admin", "Anyone"];
  RxString selectedWhoCanMessage = 'Anyone'.obs;

  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomDescriptionController = TextEditingController();

}