import 'package:get_storage/get_storage.dart';
import 'package:linkchat/app/data/models/login_info_model.dart';

class CacheDB {

  static final cacheDb = GetStorage();

  void saveUserInfo({ required String accessToken, required String userName}){
    cacheDb.write('loginInfo', LoginInfoModel(accessToken: accessToken, userName: userName));
  }

  LoginInfoModel getCurrentUserToken(){
    return cacheDb.read('loginInfo');
  }

}