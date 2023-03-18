import 'dart:convert';

import 'package:app_water/model/forecast_model.dart';
import 'package:app_water/model/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUser {
  static final SharedPreferencesUser _instancia =
      new SharedPreferencesUser._internal();
  factory SharedPreferencesUser() {
    return _instancia;
  }
  SharedPreferencesUser._internal();
  late SharedPreferences _prefs;
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  set weatherData(WeatherModel? value) {
    _prefs.setString('weatherData', jsonEncode(value));
  }

  WeatherModel? get weatherData {
    return weatherModelFromJson(_prefs.getString('weatherData') ?? "");
  }

  set forecastData(ForecastModel? value) {
    _prefs.setString('forecastData', jsonEncode(value));
  }

  ForecastModel? get forecastData {
    return forecastModelFromJson(_prefs.getString('forecastData') ?? "");
  }

  set listCitys(List<String>? value) {
    _prefs.setStringList('listCitys', value!);
  }

  List<String>? get listCitys {
    return _prefs.getStringList('listCitys') ?? [];
  }

   String get UnidadesMedida {
    return _prefs.getString('UnidadesMedida') ?? 'standard';
  }

  set UnidadesMedida(String value) {
    _prefs.setString('UnidadesMedida', value);
  }
}
