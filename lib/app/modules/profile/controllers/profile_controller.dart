import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../database/database.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ProfileController extends GetxController {

  final ScrollController scrollController = ScrollController();


  String formatNumber(int number) {
    final format = NumberFormat.compact();
    return format.format(number);
  }

  ProfileSchema get getProfile => DatabaseHelper().getUserData();


}
