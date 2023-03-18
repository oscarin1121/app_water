// To parse this JSON data, do
//
//     final findCityModel = findCityModelFromJson(jsonString);

import 'dart:convert';

FindCityModel findCityModelFromJson(String str) =>
    FindCityModel.fromJson(json.decode(str));

String findCityModelToJson(FindCityModel data) => json.encode(data.toJson());

class FindCityModel {
  FindCityModel({
    required this.message,
    required this.cod,
    required this.count,
    required this.list,
  });

  String message;
  String cod;
  int count;
  List<ListElement> list;

  factory FindCityModel.fromJson(Map<String, dynamic> json) => FindCityModel(
        message: json["message"],
        cod: json["cod"],
        count: json["count"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "cod": cod,
        "count": count,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    required this.id,
    required this.name,
    required this.coord,
    required this.main,
    required this.dt,
    required this.wind,
    required this.sys,
    this.rain,
    this.snow,
    required this.clouds,
    required this.weather,
  });

  int id;
  String name;
  Coord coord;
  Main main;
  int dt;
  Wind wind;
  Sys sys;
  dynamic rain;
  dynamic snow;
  Clouds clouds;
  List<Weather> weather;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        main: Main.fromJson(json["main"]),
        dt: json["dt"],
        wind: Wind.fromJson(json["wind"]),
        sys: Sys.fromJson(json["sys"]),
        rain: json["rain"],
        snow: json["snow"],
        clouds: Clouds.fromJson(json["clouds"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord.toJson(),
        "main": main.toJson(),
        "dt": dt,
        "wind": wind.toJson(),
        "sys": sys.toJson(),
        "rain": rain,
        "snow": snow,
        "clouds": clouds.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  double lat;
  double lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
}

class Sys {
  Sys({
    required this.country,
  });

  String country;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  double speed;
  int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}
