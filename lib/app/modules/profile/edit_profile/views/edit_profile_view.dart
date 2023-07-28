import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';
import '../../../../style/theme_provider.dart';
import '../../../../widgets/views/edit_text_field_view.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 20,
                ),

                // profile pic circle
                GestureDetector(
                  onTap: () => controller.getImage(),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: controller.imageFile != null
                        ? FileImage(controller.imageFile!)
                        : null,
                    child: controller.imageFile == null
                        ? Icon(
                      Icons.add_photo_alternate,
                      size: 40,
                      color: Colors.grey[600],
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),

                // full name field
                EditTextFieldView(
                  iconData: CupertinoIcons.person,
                  hintText: 'Your Full Name',
                  controller: controller.nameController,
                  labelText: 'Name',
                  keyboardType: TextInputType.name,
                ),

                // tagline field
                EditTextFieldView(
                    iconData: CupertinoIcons.pencil_outline,
                    hintText: 'Quick Tagline',
                    controller: controller.taglineController,
                    labelText: 'Tagline',
                    keyboardType: TextInputType.text),

                // date of birth field
                EditTextFieldView(
                  iconData: CupertinoIcons.calendar,
                  hintText: 'Your Date of Birth',
                  controller: controller.dobController,
                  labelText: 'Date of Birth',
                  readOnly: true,
                  onTap: () => controller.selectDateOfBirth(context),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                // gender selection
                Text(
                  'Select Gender',
                  style: TextStyle(color: accentColor, fontSize: 14.sp),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(8.0),
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: ThemeProvider().isSavedLightMood().value
                            ? white
                            : transparentBlack,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Obx(() {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: accentColor,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            borderRadius: BorderRadius.circular(8.0),
                            style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.w600,
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

                // user phone
                EditTextFieldView(
                  iconData: CupertinoIcons.phone,
                  hintText: 'Mobile Phone Number',
                  controller: controller.userPhoneController,
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.number,
                ),

                // user email
                EditTextFieldView(
                  iconData: CupertinoIcons.mail,
                  hintText: 'Your Email Address',
                  controller: controller.userEmailController,
                  labelText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                ),

                // user pin or fingerprint
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed:()=> Get.toNamed(Routes.SETUP_PIN, arguments: {'isSetup':true}),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(brightWhite),
                      elevation: MaterialStatePropertyAll(3)
                  ),
                  child: const Text(
                    'Change PIN',
                    style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: ()=> controller.updateProfile(), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(accentColor)), child: Text('Update', style: Theme.of(context).textTheme.labelMedium,)),
                  ],
                ),
                const SizedBox(height: 100,)
              ],
            ),
            Obx(() {
              return controller.isLoading.value
                  ? Container(
                color: ThemeProvider().isSavedLightMood().value ? cyanWhite : solidMate,
                child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: accentColor, size: 50.w),
                ),
              )
                  : const SizedBox.shrink();
            })
          ],
        )
      )
    );
  }
}
