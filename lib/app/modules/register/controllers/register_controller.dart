// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/services/location_services.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import '../../../data/utils/app_strings.dart';
import '../../../modules/register/views/email_view.dart';
import '../../../modules/register/views/name_view.dart';
import '../../../modules/register/views/pin_view.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../../style/style.dart';
import '../../../data/utils/utils.dart';
import '../../../database/cach_db.dart';
class RegisterController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> taglineController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<TextEditingController> userPhoneController = TextEditingController().obs;
  Rx<TextEditingController> userEmailController = TextEditingController().obs;
  RxString typedEmail = ''.obs;
  Rx<TextEditingController> userPinController = TextEditingController().obs;
  Rx<TextEditingController> userOtpController = TextEditingController().obs;
  final otpText = ''.obs;
  final pinText = ''.obs;
  RxBool isLoading = false.obs;
  RxString loadingMessage = ''.obs;

  // register views
  final regViews = [const EmailView(), const PinView(), const NameView()];
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
      dobController.value.text =
          DateFormat('dd/MM/yyyy').format(picked); // Store the selected date
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

  void next({required bool isEmailView}) {
    isLoading.value = true;
    if (isEmailView) {
      if (AuthService().checkVerification()) {
        Future.delayed(const Duration(seconds: 2), () {
          currentView.value++;
          isLoading.value = false;
        });
      } else {
        Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              icon: const Icon(
                Icons.question_mark,
                color: accentColor,
              ),
              content: const Text(EMAIL_VERIFICATION_SKIP_ALERT),
              contentPadding: const EdgeInsets.all(15),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      verifyOtp(userEmailController.value.text);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            ThemeProvider().isSavedLightMood()
                                ? ash
                                : accentColor)),
                    child: Text(
                      'Continue verify',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeProvider().isSavedLightMood()
                              ? black
                              : brightWhite),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Future.delayed(const Duration(seconds: 2), () {
                        currentView.value++;
                        isLoading.value = false;
                        Get.back();
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            ThemeProvider().isSavedLightMood()
                                ? ash
                                : blackAccent)),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeProvider().isSavedLightMood()
                              ? black
                              : brightWhite),
                    )),
              ],
            ));
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        currentView.value++;
        isLoading.value = false;
      });
    }
  }

  void previous() {
    currentView.value--;
  }

  void verifyOtp(String email) {
    Get.toNamed(Routes.OTP_VERIFICATION, arguments: {'email': email});
  }

  Future<void> register() async {
    if(await LocationServices().checkLocationPermission()){
      if (formKey.currentState!.validate()) {
        loadingMessage.value = 'Creating your profile';
        String userCountry = await LocationServices().getUserCountry();
        Map<String, dynamic> user = {
          "uid": "123456",
          "userName": nameController.value.text,
          "email": userEmailController.value.text,
          "password": userPinController.value.text,
          "country": userCountry
        };

        try {
          final response = await http.post(Uri.parse(BASE_URL + REGISTER), body: user);
          if (response.statusCode == 200) {
            Logger().i(response.body);
            final responseData = jsonDecode(response.body);
            final result = NewUserRegResModel.fromJson(responseData);
            CacheDB().saveUserInfo(accessToken: result.token!, userName: result.newUser!.userName!);
            Map<String,dynamic> userInfo = CacheDB.cacheDb.read('loginInfo');
            Logger().i(userInfo['accessToken']);
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.snackbar('Opps!',response.body);
            currentView.value = 0;
            isLoading.value = false;
            Logger().e(
                'body text: ${response.body} status code: ${response.statusCode}');
          }
        } catch (e) {
          Logger().e(e);
          currentView.value = 0;
          isLoading.value = false;
        }
      }
    } else {
      Get.snackbar('Sorry', LOCATION_PERMISSION_NOT_GRANTED_MESSAGE);
    }
  }




  @override
  void onInit() {
    super.onInit();
    LocationServices().checkLocationPermission();
  }
}
