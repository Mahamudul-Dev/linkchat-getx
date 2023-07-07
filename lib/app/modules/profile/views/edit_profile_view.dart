import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';
import 'package:linkchat/app/widgets/widgets.dart';

class EditProfileView extends GetView <ProfileController>{
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete your profile'),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            'One more step to register.',
            style: TextStyle(
                fontSize: 20.sp,
                color: ThemeProvider().isSavedLightMood() ? black : accentColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
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
              keyboardType: TextInputType.none),

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
            height: 10,
          ),
          // gender selection
          Text(
            'Select Gender',
            style: TextStyle(color: accentColor, fontSize: 14.sp),
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
              'Setup PIN or Fingerprint',
              style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 100,)
        ],
      )),

      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: const Text('Save Profile'),backgroundColor: accentColor,),
    );
  }
}
