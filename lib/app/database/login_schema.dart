
import 'package:objectbox/objectbox.dart';

@Entity()
class LoginSchema {
  @Id()
  int objectId;
  String serverId;
  String userName;
  String email;
  String token;

  LoginSchema({this.objectId = 0, required this.serverId, required this.userName, required this.email, required this.token});
}