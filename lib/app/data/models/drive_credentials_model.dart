import 'dart:convert';

class DriveCredentialsModel {
  Installed installed;

  DriveCredentialsModel({
    required this.installed,
  });

  factory DriveCredentialsModel.fromRawJson(String str) => DriveCredentialsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriveCredentialsModel.fromJson(Map<String, dynamic> json) => DriveCredentialsModel(
    installed: Installed.fromJson(json["installed"]),
  );

  Map<String, dynamic> toJson() => {
    "installed": installed.toJson(),
  };
}

class Installed {
  String clientId;
  String projectId;
  String authUri;
  String tokenUri;
  String authProviderX509CertUrl;

  Installed({
    required this.clientId,
    required this.projectId,
    required this.authUri,
    required this.tokenUri,
    required this.authProviderX509CertUrl,
  });

  factory Installed.fromRawJson(String str) => Installed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Installed.fromJson(Map<String, dynamic> json) => Installed(
    clientId: json["client_id"] ?? '',
    projectId: json["project_id"] ?? '',
    authUri: json["auth_uri"] ?? '',
    tokenUri: json["token_uri"]?? '',
    authProviderX509CertUrl: json["auth_provider_x509_cert_url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "project_id": projectId,
    "auth_uri": authUri,
    "token_uri": tokenUri,
    "auth_provider_x509_cert_url": authProviderX509CertUrl,
  };
}
