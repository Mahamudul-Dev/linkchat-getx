import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/demo/demo.dart';
import 'package:linkchat/app/data/utils/utils.dart';

class ChatController extends GetxController {

// user activity list section
  List<UserModel> get activeUser =>
      profiles.where((element) => element.isActive).toList();

// user chat section
  List<Chat> get chatList => chats.obs;

  String getPlaceHolder(String gender) {
    if (gender == 'Male') {
      return placeholderImageMale;
    } else {
      return placeholderImageFemale;
    }
  }
}
