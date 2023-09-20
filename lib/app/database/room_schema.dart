import 'package:objectbox/objectbox.dart';

@Entity()
class RoomEntity {
  // ObjectBox ID is automatically generated for each entity.
  int id;

  // Fields from your Room model
  String groupId;
  String creatorId;
  String groupName;
  String groupImage;
  int joinCode;

  RoomEntity({
    this.id = 0,
    required this.groupId,
    required this.creatorId,
    required this.groupName,
    required this.groupImage,
    required this.joinCode,
  });
}
