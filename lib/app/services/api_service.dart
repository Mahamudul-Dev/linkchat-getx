import 'package:dio/dio.dart';
import 'package:linkchat/app/data/models/get_multiple_profile_req_model.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/helpers/accounts_helper.dart';
import 'package:logger/logger.dart';

class ApiService {
  static final _dio = Dio();

  // get single profile
  static Future<UserModel?> getSingleProfile(String sId) async {
    late UserModel? profile;

    try {
      final res = await _dio.get(BASE_URL + USER + sId,
          options: Options(
              headers: authorization(AccountHelper.getUserData().serverId)));

      if (res.statusCode == 200) {
        profile = UserModel.fromJson(res.data);
      }
    } catch (e) {
      Logger().e(e);
    }

    return profile;
  }

  // get multiple profile
  static Future<GetMultipleProfileModel> getMultipleProfile(
      GetMultipleProfileReqModel sIdList) async {
    late GetMultipleProfileModel profile;
    try {
      final res = await _dio.post(BASE_URL + MULTIPLE_USER,
          data: sIdList.toJson(),
          options: Options(
              headers: authorization(AccountHelper.getUserData().serverId)));

      if (res.statusCode == 200) {
        profile = GetMultipleProfileModel.fromJson(res.data);
      }
    } catch (e) {
      Logger().e(e);
    }

    return profile;
  }
  //
}
