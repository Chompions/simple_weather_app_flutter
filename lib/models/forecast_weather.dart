import 'dart:convert';
import 'package:pre_test_submission/models/open_weather_misc/clouds.dart';
import 'package:pre_test_submission/models/open_weather_misc/wind.dart';
import 'package:pre_test_submission/models/open_weather_misc/weather.dart';

ForecastWeather forecastWeatherFromJson(String json) => ForecastWeather.fromJson(jsonDecode(json));

class ForecastWeather {
  ForecastWeather({
    this.list,
    this.city,
  });

  List<ForecastItem>? list;
  City? city;

  factory ForecastWeather.fromJson(Map<String, dynamic> json) => ForecastWeather(
        list: List<ForecastItem>.from(json["list"].map((x) => ForecastItem.fromJson(x))),
        city: City.fromJson(json["city"]),
      );
}

class City {
  City({
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );
}

class Coord {
  Coord({
    this.lat,
    this.lon,
  });

  num? lat;
  num? lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"],
        lon: json["lon"],
      );
}

class ForecastItem {
  ForecastItem({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.dtTxt,
  });

  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  num? pop;
  DateTime? dtTxt;

  factory ForecastItem.fromJson(Map<String, dynamic> json) => ForecastItem(
        dt: json["dt"],
        main: Main.fromJson(json["main"]),
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"],
        dtTxt: DateTime.parse(json["dt_txt"]),
      );
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  num? tempKf;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"],
        feelsLike: json["feels_like"],
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"],
      );
}
