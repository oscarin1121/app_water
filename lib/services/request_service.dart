import 'package:app_water/model/city_model.dart';
import 'package:app_water/model/weather_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../helpers/alertDialog.dart';
import '../model/forecast_model.dart';
import '../shared_preferences/shared_preferences.dart';

Future<bool?> weatherRequest() async {
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  Position position = await Geolocator.getCurrentPosition();
  String url =
      "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&lang=es&appid=f5f6a4b66ebce196e358a38dda539e14&units=${prefs.UnidadesMedida}";
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    return false;
  }
  prefs.weatherData = weatherModelFromJson(response.body);

  url =
      "https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&lang=es&appid=f5f6a4b66ebce196e358a38dda539e14&units=${prefs.UnidadesMedida}";
  response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    return false;
  }
  ForecastModel forecastModel = forecastModelFromJson(response.body);
  for (var i = 0; i < forecastModel.list.length; i++) {
    final element = forecastModel.list[i].dtTxt;
    DateTime utcDateTime = DateTime.utc(
        element.year, element.month, element.day, element.hour, element.minute);
    forecastModel.list[i].dtTxt = utcDateTime.toLocal();
  }
  prefs.forecastData = forecastModel;
  return true;
}

Future<List<CityModel>?> searchCitys() async {
  SharedPreferencesUser prefs = new SharedPreferencesUser();
  final List<CityModel> items = [];
  for (var i = 0; i < prefs.listCitys!.length; i++) {
    final element = prefs.listCitys?[i];
    final elementSeparate = element?.split("-");
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${elementSeparate?[0]},${elementSeparate?[1]}&appid=f5f6a4b66ebce196e358a38dda539e14&units=${prefs.UnidadesMedida}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      items.add(cityModelFromJson((response.body)));
    } else {
      throw Exception('Failed to load city');
    }
  }
  return items;
}
Future checkConection(context,checkSplash) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // conexión Wi-Fi disponible
      alertaSimple(context, "No se tiene conexion a internet",
          "Verifique la conexion a intener y vuelva a ingresar", "Salir");
    } else if(checkSplash){
      return Navigator.pushReplacementNamed(context, 'HomePage');
    }
  }