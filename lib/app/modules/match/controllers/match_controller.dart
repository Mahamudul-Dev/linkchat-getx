import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/match_model.dart';
import 'package:logger/logger.dart';

import '../../../data/models/models.dart';
import '../../../data/utils/utils.dart';
import '../../../database/database_helper.dart';

class MatchController extends GetxController {
  final dio = Dio();
  final dbHelper = DatabaseHelper();

  Future<MatchModel> getMatches() async {
    final body = {'userId': dbHelper.getUserData().serverId};
    final response = await dio.get(BASE_URL + GET_MATCH,
        data: body,
        options:
            Options(headers: authorization(dbHelper.getLoginInfo().token!)));
    Logger().i(response.statusCode);

    if (response.statusCode == 200) {
      Logger().i(response.data);
      return MatchModel.fromJson(response.data);
    } else {
      final data = MatchModel.fromJson(response.data);
      Get.snackbar('Sorry', data.message);
      return MatchModel.fromJson(response.data);
    }
  }

  String nameSpaceBreaker(String name) {
    // Split the input string into words
    List<String> words = name.split(' ');

    if (words.isNotEmpty) {
      String firstWord = words[0]; // Get the first word
      String secondWord = '';

      // Check if there is a second word before getting its first letter
      if (words.length > 1) {
        secondWord = words[1];
        // Extract the first letter of the second word
        if (secondWord.isNotEmpty) {
          secondWord = secondWord[0];
        }
      }

      String result = '$firstWord $secondWord';
      return result;
    } else {
      return '';
    }
  }

  String calculateAge(String dateOfBirth) {
    final dob = DateTime.parse(dateOfBirth);
    // Calculate the current date
    DateTime currentDate = DateTime.now();

    // Calculate the age
    int age = currentDate.year - dob.year;

    // Check if the birthday has already occurred this year
    if (currentDate.month < dob.month ||
        (currentDate.month == dob.month && currentDate.day < dob.day)) {
      age--; // Subtract 1 from the age if the birthday hasn't occurred yet
    }
    return age.toString();
  }
}
