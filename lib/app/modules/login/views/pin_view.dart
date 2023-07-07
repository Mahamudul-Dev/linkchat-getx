import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/login/controllers/login_controller.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:pinput/pinput.dart';

class PinView extends GetView<LoginController> {
  const PinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          
          Row(
            
            children: [
              Pinput(
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      color: accentColor,
                      fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(234, 239, 243, 1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
