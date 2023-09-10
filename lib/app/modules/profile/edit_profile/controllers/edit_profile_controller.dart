import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../data/models/models.dart';
import '../../../../database/database.dart';
import '../../../../database/helpers/helpers.dart';

class EditProfileController extends GetxController {
  /*
  |- In this section is define for all functionality which is realeted with profile editing.
  |- Don't put any other functionality bellow of this block.
  |- If you got any kinds of issue in this code, contact with the developer: mahamudul.dev@gmail.com
  */
  File? imageFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController taglineController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fillValueFromDatabase();
    super.onInit();
  }

  // gender selection
  var defaultGender = 'N/A'.obs;
  var genderList = ['N/A', 'Female', 'Male', 'Rather Not Say'].obs;

  // relationship status selection
  var relationshipStatus = 'N/A'.obs;
  var relationshipStatusList = [
    'N/A',
    'Single',
    'Married',
    'Engaged',
    'Divorced',
    'Widowed',
    'Complicated'
  ].obs;

  Future<void> getImage() async {
    late PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final picker = ImagePicker();
      await picker.pickImage(source: ImageSource.gallery);
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
      dobController.text =
          DateFormat('dd/MM/yyyy').format(picked); // Store the selected date
    }
  }

  void fillValueFromDatabase() {
    final dbProfileData = Get.find<ProfileController>().getCurrentProfile;
    nameController.text = dbProfileData.name;
    taglineController.text = dbProfileData.tagline ?? '';
    dobController.text = dbProfileData.dob ?? '';
    userPhoneController.text = dbProfileData.phone ?? '';
    userEmailController.text = dbProfileData.email;
  }

  void updateProfile() async {
    isLoading.value = true;
    final userLoginInfo = AccountHelper.getLoginInfo();
    final Map<String, dynamic> data = {
      "userName": nameController.text,
      "email": userEmailController.text.trim(),
      "userPhone": userPhoneController.text.trim(),
      "tagLine": taglineController.text,
      "bio": bioController.text,
      "gender": defaultGender.value,
      "dob": dobController.text,
      "relationshipStatus": relationshipStatus.value,
      "updatedAt": DateTime.now().toString(),
    };
    final response = await http.put(
        Uri.parse(BASE_URL +
            UPDATE_PROFILE +
            Get.find<ProfileController>().getCurrentProfile.serverId),
        headers: {'Authorization': 'Bearer ${userLoginInfo.token}'},
        body: data);
    if (response.statusCode == 200) {
      final result = FullProfile.fromJson(jsonDecode(response.body));
      AccountHelper.saveUserData(result);
      Get.snackbar('Success', 'Profile updated successfully');
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar('Sorry', response.body);
    }
  }
}
