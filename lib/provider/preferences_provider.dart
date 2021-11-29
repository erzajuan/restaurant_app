import 'package:flutter/foundation.dart';
import 'package:resstaurant_api/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getDailyRestoPreferences();
  }

  bool _isDailyRestoActive = false;
  bool get isDailyRestoActive => _isDailyRestoActive;

  void _getDailyRestoPreferences() async {
    _isDailyRestoActive = await preferencesHelper.isDailyRestoActive;
    notifyListeners();
  }

  void enableDailyResto(bool value) {
    preferencesHelper.setDailyResto(value);
    _getDailyRestoPreferences();
  }
}
