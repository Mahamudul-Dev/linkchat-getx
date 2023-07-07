import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/style/app_color.dart';

import '../controllers/dialer_controller.dart';

class DialerView extends GetView<DialerController> {
  const DialerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Obx(() => Text(
                controller.enteredNumber.value,
                style: const TextStyle(fontSize: 32.0),
              ),)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDialpadButton('1'),
              _buildDialpadButton('2'),
              _buildDialpadButton('3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDialpadButton('4'),
              _buildDialpadButton('5'),
              _buildDialpadButton('6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDialpadButton('7'),
              _buildDialpadButton('8'),
              _buildDialpadButton('9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDialpadButton('*'),
              _buildDialpadButton('0'),
              _buildDialpadButton('#'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.backspace, ()=>controller.eraseNumber(), false),
                _buildActionButton(Icons.phone, ()=>controller.makeCall(), true),
              ],
            ),
          ),
        ],
      ),
    )
        );
  }

  Widget _buildDialpadButton(String digit) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.addToNumber(digit),
        child: Container(
          height: 80.0,
          alignment: Alignment.center,
          child: Text(
            digit,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, void Function()? onPressed, bool isCall) {
    return Expanded(
      child: IconButton(
        icon: Icon(icon, color: isCall ? brightWhite : blackAccent),
        iconSize: 32.0,
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: isCall ? const MaterialStatePropertyAll(accentColor) : const MaterialStatePropertyAll(Colors.transparent)
        ),
      ),
    );
  }
}
