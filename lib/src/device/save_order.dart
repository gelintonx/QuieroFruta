import 'package:shared_preferences/shared_preferences.dart';

class SaveOrder {
  final _prefs = SharedPreferences.getInstance();

  Future<void> saveOrder(String branch) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList('order', ['Hola', 'xD']);
  }

  Future getLastOrder() async {
    final SharedPreferences prefs = await _prefs;
    prefs.getStringList('order');
  }
}
