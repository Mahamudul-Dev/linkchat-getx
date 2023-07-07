import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  String formatNumber(int number) {
    final format = NumberFormat.compact();
    return format.format(number);
  }




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
      dobController.text = DateFormat('dd/MM/yyyy').format(picked); // Store the selected date
    }
  }
}
