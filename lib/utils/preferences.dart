import 'package:shared_preferences/shared_preferences.dart';

enum Preference { server, license, savedInvoiceId, apiKey, userRole, token }

class Preferences {
  static String _preferenceName(Preference preference) {
    return preference.toString().split('.').last;
  }

  static Future<String> getFullApiUrl() async {
    return get(Preference.server);
  }

  static Future<String> getToken() async {
    return get(Preference.token);
  }

  static removeToken() async {
    Preferences.remove(Preference.token);
  }

  static Future<String> get(Preference preference) async {
    var preferenceStr = _preferenceName(preference);

    var pref = await SharedPreferences.getInstance();

    return Future<String>.value(pref.getString(preferenceStr) ?? '');
  }

  static Future set(Preference preference, dynamic value) async {
    var preferenceStr = _preferenceName(preference);

    var pref = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case int:
        return pref.setInt(preferenceStr, value);
      case double:
        return pref.setDouble(preferenceStr, value);
      case String:
        return pref.setString(preferenceStr, value);
      case bool:
        return pref.setBool(preferenceStr, value);
      default:
        throw "Preferences.set unsupported type for $preferenceStr";
    }
  }

  static Future remove(Preference preference) async {
    var preferenceStr = _preferenceName(preference);

    var pref = await SharedPreferences.getInstance();
    pref.remove(preferenceStr);
  }
}
