import 'package:linkchat/app/database/cach_db.dart';

class AuthService {

  bool checkLogedIn(){
    if (CacheDB.cacheDb.hasData('isLogedIn')) {
      if (CacheDB.cacheDb.read('isLogedIn') == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool isValidEmail(String email) {
  // Regular expression pattern for email validation
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

  // Create a RegExp object with the pattern
  final regExp = RegExp(pattern);

  // Check if the email matches the pattern
  return regExp.hasMatch(email);
}


}