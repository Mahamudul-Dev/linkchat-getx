import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:flutter/material.dart';

class RandomCallController extends GetxController {
 GZXDropdownMenuController dropdownMenuController =
      GZXDropdownMenuController();
  GlobalKey<State<StatefulWidget>> dropdownKey =
      GlobalKey<State<StatefulWidget>>();
  RxBool showAdvanceSheet = true.obs;
  // country selection
  Country? selectedCountry;
  // age selection
  var defaultAgeStart = 18.obs;
  var defaultAgeEnd = 25.obs;
  var ageList = [
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70
  ].obs;

  // gender selection
  var defaultGender = 'Female'.obs;
  var genderList = ['Female', 'Male', 'Others'].obs;

  // media controller
  RxBool videoEnable = false.obs;
  RxBool microphoneEnable = false.obs;
  RxBool audioEnable = false.obs;

  // connection controller
  RxBool isConnected = false.obs;
  RxBool isConnecting = true.obs;
  
}
