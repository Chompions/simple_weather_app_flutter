import 'dart:convert';
import 'package:pre_test_submission/models/open_weather_misc/clouds.dart';
import 'package:pre_test_submission/models/open_weather_misc/wind.dart';
import 'package:pre_test_submission/models/open_weather_misc/weather.dart';

CurrentWeather currentWeatherFromJson(String json) => CurrentWeather.fromJson(jsonDecode(json));

class CurrentWeather {
  CurrentWeather({
    this.weather,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.name,
    this.dt,
  });

  List<Weather>? weather;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  String? name;
  int? dt;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        name: json["name"],
        dt: json["dt"],
      );
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );
}
