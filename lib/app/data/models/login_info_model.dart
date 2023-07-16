class LoginInfoModel {
  final bool isLoggedIn;
  final String accessToken;
  final String userName;

  LoginInfoModel({this.isLoggedIn = true, required this.accessToken, required this.userName});


}