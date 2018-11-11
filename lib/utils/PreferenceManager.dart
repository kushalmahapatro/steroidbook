import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> setCountryCodePrefs(String countryCode) async {
    SharedPreferences prefs = await _prefs;
    bool result = await prefs.setString("country", countryCode ?? "");
    return result;
  }

  Future<String> getCountryCodePrefs() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString("country") ?? "";
  }
}
