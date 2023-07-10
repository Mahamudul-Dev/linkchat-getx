// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/cach_db.dart';
import 'package:linkchat/app/modules/register/views/email_view.dart';
import 'package:linkchat/app/modules/register/views/name_view.dart';
import 'package:linkchat/app/modules/register/views/otp_view.dart';
import 'package:linkchat/app/modules/register/views/pin_view.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController taglineController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  Rx<TextEditingController> userPinController = TextEditingController().obs;
  Rx<TextEditingController> userOtpController = TextEditingController().obs;
  final otpText = ''.obs;
  final pinText = ''.obs;
  RxBool isLoading = false.obs;

  // register views
  final regViews = [
    const EmailView(), const OtpView(), const PinView(), const NameView()
  ];
  RxInt currentView = 0.obs;


  // gender selection
  var defaultGender = 'Female'.obs;
  var genderList = ['Female', 'Male', 'Others'].obs;


  Future<void> getImage() async {
    late PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final picker = ImagePicker();
      final selectedFile = await picker.pickImage(source: ImageSource.gallery);
      if (selectedFile != null) {
        _cropImage(selectedFile.path);
      }
      
    } else if (status.isDenied) {
      // Handle denied permission
      Get.snackbar('Opps',
          'You need to give us permission for update your profile photo');
    } else if (status.isPermanentlyDenied) {
      // Handle permanently denied permission
      Get.snackbar('Sorry',
          'You can not update your profile photo. Please retry after giving the permission');
    }
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(picked); // Store the selected date
    }
  }

  Future<void> _cropImage(String filePath) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: filePath,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    uiSettings: [
      AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      toolbarColor: accentColor,
      toolbarWidgetColor: white,
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: false,
    ),
    IOSUiSettings(
      title: 'Crop Image',
      aspectRatioLockEnabled: false,
    )
    ],
  );

  if (croppedFile != null) {
    imageFile.value = File(croppedFile.path);
  }
}
  void next(){
    currentView.value ++;
      isLoading.value = false;
  }
  void previous(){
    currentView.value --;
  }

  void verifyOtp(){
    next();
  }


  void register() async {
    if (formKey.currentState!.validate()) {
      Map<String,dynamic> user = {
      "uid": 123,
      "userName": nameController.text,
      "userEmail": userEmailController.text.trim(),
      "userPhone": userPhoneController.text.trim(),
      "userProfilePic": imageFile.value,
      "tagline": taglineController.text,
      "bio": "",
      "dob": dobController.text,
      "gender": defaultGender.value,
      "country": "United States",
      "relationshipStatus": "",
      "isActive": true,
      "lastActive": "",
      "followers": [],
      "following":[]
    }; 
    final response = await http.post(Uri.parse(BASE_URL+REGISTER), body: user);
    if (response.statusCode == 200) {
      CacheDB.cacheDb.writeIfNull('isLogedIn', true);
      Get.offAll(Routes.HOME);
    } else {
      Logger().e('body text: ${response.body} status code: ${response.statusCode}');
    }
    }

  }
}
