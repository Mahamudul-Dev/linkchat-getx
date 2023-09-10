import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:googleapis/drive/v2.dart' as gv2;
import 'package:googleapis/drive/v3.dart' as gapi;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/data/models/drive_credentials_model.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:path/path.dart' as path;
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleDriveService {
  static final DriveCredentialsModel credentials = DriveCredentialsModel.fromJson(GOOGLE_DRIVE_CLIENT_CREDENTIALS);
  static final secureBox = GetStorage();

  static Future<http.Client> getHttpClient() async {
    final savedCredentials = await getCredentials();
    Logger().i('credentials: $savedCredentials');

    if(savedCredentials?['type']==null || savedCredentials?['data'] == null){
      final authClient = await clientViaUserConsent(ClientId(credentials.installed.clientId, GOOGLE_DRIVE_CLIENT_KEY), ['https://www.googleapis.com/auth/drive.file'], (uri) { launchUrl(Uri.parse(uri)); }, baseClient: http.Client());
      return authClient;
    } else {
      return authenticatedClient(http.Client(), AccessCredentials(AccessToken(savedCredentials!['type'], savedCredentials['data'], DateTime.parse(savedCredentials['expiry'])), savedCredentials['refreshToken'], ['https://www.googleapis.com/auth/drive.file']));
    }


  }

  static Future<void> uploadFile(File file, String email) async{
    final client = await getHttpClient();
    final drive = gapi.DriveApi(client);
    final response = await drive.files.create(gapi.File()..name= path.basename(file.absolute.path), uploadMedia: gv2.Media(file.openRead(), file.lengthSync()), includePermissionsForView: 'anyone');
    Logger().i(response.toJson());
    Logger().i(response.webViewLink);
    String shareableLink = '';
    if(response.id != null){
      await drive.permissions.create(gapi.Permission(allowFileDiscovery: true, emailAddress: email, role: 'reader', type: 'user'), response.id!, sendNotificationEmail: false, supportsAllDrives: true);
      shareableLink = response.webViewLink ?? '';
    }
    Logger().i('Link: $shareableLink');
  }

  static Future<void> saveCredentials(AccessToken token, String refreshToken) async {
    await secureBox.write('type', token.type);
    await secureBox.write('data', token.data);
    await secureBox.write('expiry', token.expiry.toIso8601String());
    await secureBox.write('refreshToken', refreshToken);
  }

  static Future<Map<String,dynamic>?> getCredentials()async{
    final type = await secureBox.read('type');
    final data = await secureBox.read('data');
    final expiry = await secureBox.read('expiry');
    final refreshToken = await secureBox.read('refreshToken');
    final credentials = {
      'type':type,
      'data':data,
      'expiry':expiry,
      'refreshToken':refreshToken
    };
    return credentials;
  }

  static Future<void> removeCredentials() async {
    secureBox.erase();
  }
}