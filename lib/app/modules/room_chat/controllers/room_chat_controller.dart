import 'package:get/get.dart';
import 'package:linkchat/app/data/models/get_multiple_profile_req_model.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/models.dart';
import '../../../database/helpers/helpers.dart';
import '../../../services/socket_io_service.dart';

class RoomChatController extends GetxController {
  final uuid = const Uuid();
  RxBool isLoading = false.obs;
  RxList<ShortProfile> allLinkList = <ShortProfile>[].obs;
  RxList<ShortProfile> linkList = <ShortProfile>[].obs;
  RxList<ShortProfile> selectedLink = <ShortProfile>[].obs;

  @override
  void onInit() async {
    try {
      isLoading.value = true;
      final profile = await ApiService.getSingleProfile(
          AccountHelper.currentUserBox.getAll().first.serverId);
      if (profile != null) {
        allLinkList.clear();
        linkList.clear();
        Logger().i(profile.data.first.linked);

        List<String> allLinkListIds = [];
        List<String> linkListIds = [];
        // List<String> selectedLinkIds = [];

        final linklistProfiles = await ApiService.getMultipleProfile(
            GetMultipleProfileReqModel(idList: linkListIds));

        final allLinklistProfiles = await ApiService.getMultipleProfile(
            GetMultipleProfileReqModel(idList: allLinkListIds));

        allLinkList.addAll(allLinklistProfiles.linkedList);
        linkList.addAll(linklistProfiles.linkedList);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Logger().e(e);
    }
    super.onInit();
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

  void toggleItem(ShortProfile link) {
    if (selectedLink.contains(link)) {
      selectedLink.remove(link);
    } else {
      selectedLink.add(link);
    }
  }

  void createRoom() {
    SocketIOService.socket.emit('joinGroup', uuid.v1());
  }
}
