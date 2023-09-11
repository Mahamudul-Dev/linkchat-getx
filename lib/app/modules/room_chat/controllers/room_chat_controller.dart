import 'package:get/get.dart';
import 'package:linkchat/app/data/models/user_model.dart';
import 'package:logger/logger.dart';

import '../../../database/helpers/helpers.dart';
import '../../../services/api_service.dart';
import '../../../services/socket_io_service.dart';

class RoomChatController extends GetxController {
  // final uuid = const Uuid();
  RxBool isLoading = false.obs;
  RxList<ShortProfileModel> allLinkList = <ShortProfileModel>[].obs;
  RxList<ShortProfileModel> linkList = <ShortProfileModel>[].obs;
  RxList<ShortProfileModel> selectedLink = <ShortProfileModel>[].obs;

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

  void createRoom() {
    SocketIOService.socket.emit('joinGroup', '');
  }
}
