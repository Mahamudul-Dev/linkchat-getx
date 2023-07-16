import 'package:get_storage/get_storage.dart';
import 'package:linkchat/app/database/cach_db.dart';


class AuthService {

  GetStorage box = GetStorage();



  bool isValidEmail(String email) {
  // Regular expression pattern for email validation
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

  // Create a RegExp object with the pattern
  final regExp = RegExp(pattern);

  // Check if the email matches the pattern
  return regExp.hasMatch(email);
  }

  bool checkLoggedIn(){
    if (CacheDB.cacheDb.hasData('loginInfo')) {
      Map<String,dynamic> userInfo = CacheDB.cacheDb.read('loginInfo');
      if (userInfo['accessToken'] != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void saveUserVerificationStatus(String otp, bool status){
    box.write('isVerified', status);
  }

  bool checkVerification(){
    final bool status = box.hasData('isVerified');
    if (status) {
      return true;
    } else {
      return false;
    }
  }



}