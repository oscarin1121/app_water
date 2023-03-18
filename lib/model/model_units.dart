import '../shared_preferences/shared_preferences.dart';

class UnidadesMedida {
  SharedPreferencesUser prefs = new SharedPreferencesUser();

  String get temperatura {
    if (prefs.UnidadesMedida == "standard") {
      return "°K";
    }
    if (prefs.UnidadesMedida == "metric") {
      return "°C";
    }

    return "°F";
  }

  String get velocidadViento {
    if (prefs.UnidadesMedida == "imperial") {
      return "mi/h";
    }

    return "m/s";
  }

  String get presion {
    return "hPa";
  }
}
