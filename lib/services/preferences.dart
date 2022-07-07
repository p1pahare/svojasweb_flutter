import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences() {
    initialize();
  }
  SharedPreferences? _prefs;
  Future initialize() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    } else {
      return;
    }
  }

  Future saveIslogin({bool isLogin = false}) async {
    await initialize();
    await _prefs?.setBool('is_login', isLogin);
  }

  Future<bool> readIslogin() async {
    await initialize();
    return _prefs?.getBool('is_login') ?? false;
  }
}
