import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/room_chat/controllers/room_chat_controller.dart';
import 'package:logger/logger.dart';

import '../../data/models/room_res_model.dart';
import '../objectbox_singleton.dart';
import '../room_schema.dart';

class RoomChatHelper {
  static final roomSchemaBox = ObjectBoxSingleton().store.box<RoomEntity>();

  static Future<void> saveRoomInLocal(RoomModel room) async {
    final schema = RoomEntity(
        groupId: room.id,
        creatorId: room.creatorId,
        groupName: room.groupName,
        groupImage: room.groupImage ?? PLACEHOLDER_IMAGE,
        joinCode: room.joinCode);
    roomSchemaBox.putAsync(schema);
    RoomChatController.joinedRooms.add(room);
    Logger().i('Data Saved Successfully');
  }

  static Future<List<RoomEntity>> getJoinedRooms() async {
    return roomSchemaBox.getAllAsync();
  }
}
