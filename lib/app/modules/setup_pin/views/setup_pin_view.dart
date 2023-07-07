import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/style/style.dart';

import 'package:pinput/pinput.dart';
import '../controllers/setup_pin_controller.dart';

class SetupPinView extends GetView<SetupPinController> {
  const SetupPinView({Key? key}) : super(key: key);
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
