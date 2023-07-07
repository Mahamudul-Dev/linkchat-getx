import 'package:get/get.dart';

class DialerController extends GetxController {
  RxString enteredNumber = ''.obs;


  void addToNumber(String digit) {
    enteredNumber.value += digit;
  }

  void eraseNumber() {
      if (enteredNumber.isNotEmpty) {
        enteredNumber.value = enteredNumber.value.substring(0, enteredNumber.value.length - 1);
      }
  }

  void makeCall() {
    // Implement your call functionality here
    
  }
}
