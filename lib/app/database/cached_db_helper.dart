import 'package:get_storage/get_storage.dart';

class CachedDbHelper {
  final suggestionBox = GetStorage();

// Function to save a string to GetStorage
  void saveSearchSuggestion(String suggestion) {
    List<String> savedSuggestion = suggestionBox.read('searchHistory') ?? [];
    savedSuggestion.add(suggestion);
    suggestionBox.write('searchHistory', savedSuggestion);
  }

// Function to get all saved strings as a list from GetStorage
  List<String> getSearchSuggestion() {
    return suggestionBox.read('searchHistory') ?? [];
  }
}
