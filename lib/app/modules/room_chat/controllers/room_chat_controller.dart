import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/models.dart';
import '../../../database/helpers/helpers.dart';
import '../../../services/socket_io_service.dart';
import '../../profile/controllers/profile_controller.dart';

class RoomChatController extends GetxController {
  final userProfileController = ProfileController();
  final uuid = Uuid();
  RxBool isLoading = false.obs;
  RxList<FollowerModel> allLinkList = <FollowerModel>[].obs;
  RxList<FollowerModel> linkList = <FollowerModel>[].obs;
  RxList<FollowerModel> selectedLink = <FollowerModel>[].obs;

  @override
  void onInit() async {
    try{
      isLoading.value = true;
      final profile = await userProfileController.getProfileDetails(AccountHelper.currentUserBox.getAll().first.serverId);
      if(profile != null){
        allLinkList.clear();
        linkList.clear();
        Logger().i(profile.data.first.linked);
        allLinkList.addAll(profile.data.first.linked);
        linkList.addAll(profile.data.first.linked);
        isLoading.value = false;
      }
    } catch(e){
      isLoading.value = false;
      Logger().e(e);
    }
    super.onInit();
  }

  void queryLink(String query){
    linkList.clear();
    if(query.isEmpty){
      linkList.addAll(allLinkList);
    } else {
      linkList.addAll(allLinkList.where((item) => item.userName.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void toggleItem(FollowerModel link) {
    if (selectedLink.contains(link)) {
      selectedLink.remove(link);
    } else {
      selectedLink.add(link);
    }
  }


  void createRoom(){
    SocketIOService.socket.emit('joinGroup', uuid.v1());
  }
}
