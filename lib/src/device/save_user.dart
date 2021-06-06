import 'package:shared_preferences/shared_preferences.dart';

class SaveUser {
  final _prefs = SharedPreferences.getInstance();

  Future<void> saveName(String name) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('name', name);
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await _prefs;
    final response = prefs.getString('name');
    return response;
  }

  Future<void> saveCostumerId(String costumerId) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('costumerId', costumerId);
  }

  Future<String> getCostumerId() async {
    final SharedPreferences prefs = await _prefs;
    final response = prefs.getString('costumerId');
    return response;
  }
}
