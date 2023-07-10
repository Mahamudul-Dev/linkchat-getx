import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/register/controllers/register_controller.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/views/edit_text_field_view.dart';

class NameView extends GetView <RegisterController> {
  const NameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On more step',),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Type Your Full Name', style: TextStyle(fontSize: 22.sp, color: accentColor, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              EditTextFieldView(iconData: CupertinoIcons.person, keyboardType: TextInputType.name, controller: controller.nameController,hintText: 'Type your name',)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
              controller.isLoading.value = true;
              Future.delayed(const Duration(seconds: 2), ()=> controller.register());
          },
          backgroundColor: accentColor,
          label: const Row(
            children: [
              Text(
                'Register',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: brightWhite),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: brightWhite,
              ),
            ],
          )),
    );

  }
}
