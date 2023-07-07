import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/random_call/controllers/random_call_controller.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

class RandomCallSettingSheetView extends GetView<RandomCallController> {
  const RandomCallSettingSheetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        backgroundColor: solidMate,
        enableDrag: false,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: ThemeProvider().isSavedLightMood() ? white : blackAccent,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
            child: ListView(
              children: [
                Text(
                  'Describe your interest',
                  style: TextStyle(
                      color: ThemeProvider().isSavedLightMood()
                          ? black
                          : brightWhite,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
                Lottie.asset(ThemeProvider().isSavedLightMood()
                    ? AssetManager.FULL_MAP_BLACK
                    : AssetManager.FULL_MAP_WHITE),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: Text(
                    'Age Range',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: ThemeProvider().isSavedLightMood()
                            ? black
                            : brightWhite),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(8.0),
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: ThemeProvider().isSavedLightMood()
                                ? brightWhite
                                : transparentBlack,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Obx(() {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                borderRadius: BorderRadius.circular(8.0),
                                style: TextStyle(
                                    color: ThemeProvider().isSavedLightMood()
                                        ? black
                                        : brightWhite,
                                    fontSize: 14.sp),
                                value: controller.defaultAgeStart.value,
                                items: controller.ageList
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(
                                      value.toString(),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.defaultAgeStart.value =
                                      value as int;
                                }),
                          );
                        }),
                      ),
                    ),
                    Text(
                      'to',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: ThemeProvider().isSavedLightMood()
                              ? black
                              : brightWhite),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(8.0),
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: ThemeProvider().isSavedLightMood()
                                ? white
                                : transparentBlack,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Obx(() {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                borderRadius: BorderRadius.circular(8.0),
                                style: TextStyle(
                                    color: ThemeProvider().isSavedLightMood()
                                        ? black
                                        : brightWhite,
                                    fontSize: 14.sp),
                                value: controller.defaultAgeEnd.value,
                                items: controller.ageList
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.defaultAgeEnd.value = value as int;
                                }),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: Text(
                    'Select country',
                    style: TextStyle(
                        color: ThemeProvider().isSavedLightMood()
                            ? black
                            : brightWhite,
                        fontSize: 14.sp),
                  ),
                ),
                CountryPickerFieldView(controller: controller,),
                const SizedBox(
                  height: 15.0,
                ),
                // gender selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Select Gender',
                      style: TextStyle(
                          color: ThemeProvider().isSavedLightMood()
                              ? black
                              : brightWhite,
                          fontSize: 14.sp),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(8.0),
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: ThemeProvider().isSavedLightMood()
                                ? white
                                : transparentBlack,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Obx(() {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                borderRadius: BorderRadius.circular(8.0),
                                style: TextStyle(
                                    color: ThemeProvider().isSavedLightMood()
                                        ? black
                                        : brightWhite,
                                    fontSize: 14.sp),
                                value: controller.defaultGender.value,
                                items: controller.genderList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.defaultGender.value =
                                      value.toString();
                                }),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildControllBar(context),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(onPressed: (){}, backgroundColor: accentColor, icon: const Icon(Icons.search_rounded, color: brightWhite, size: 25,), label: const Text('Match', style: TextStyle(color: brightWhite, fontWeight: FontWeight.bold),))
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget buildControllBar(BuildContext context) {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(11),
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ThemeProvider().isSavedLightMood() ? white : transparentBlack),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                controller.videoEnable.value =
                    !controller.videoEnable.value;
              },
              icon: Obx(
                () => FaIcon(
                  controller.videoEnable.value
                      ? FontAwesomeIcons.video
                      : FontAwesomeIcons.videoSlash,
                  color: accentColor,
                ),
              )),
          IconButton(
              onPressed: () {
                controller.audioEnable.value =
                    !controller.audioEnable.value;
              },
              icon: Obx(
                () => FaIcon(
                  controller.audioEnable.value
                      ? Icons.record_voice_over
                      : Icons.voice_over_off_rounded,
                  size: 30,
                  color: accentColor,
                ),
              )),
          IconButton(
              onPressed: () {
                controller.microphoneEnable.value =
                    !controller.microphoneEnable.value;
              },
              icon: Obx(
                () => FaIcon(
                  controller.microphoneEnable.value
                      ? FontAwesomeIcons.microphone
                      : FontAwesomeIcons.microphoneSlash,
                  color: accentColor,
                ),
              ))
        ],
      ),
    ),
  );
}
}
