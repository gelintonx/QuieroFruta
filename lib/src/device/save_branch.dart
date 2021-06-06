import 'package:shared_preferences/shared_preferences.dart';

class SaveBranch {
  final _prefs = SharedPreferences.getInstance();

  Future<void> saveBranch(String branch) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('branch', branch);
  }

  Future<String> getBranch() async {
    final SharedPreferences prefs = await _prefs;
    final response = prefs.getString('branch');
    return response;
  }
}
