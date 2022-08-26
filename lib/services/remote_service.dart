import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pre_test_submission/models/current_weather.dart';
import 'package:pre_test_submission/models/forecast_weather.dart';
import 'package:pre_test_submission/models/location.dart';
import 'package:pre_test_submission/views/error_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class RemoteService {
  BuildContext context;

  RemoteService(this.context);

  http.Client client = http.Client();

  Future<CurrentWeather> getCurrentWeather(Location location) async {
    try {
      Uri uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&lang=ID&units=metric&appid=${DotEnv.env['OPEN_WEATHER_API_KEY']}');

      http.Response response = await client.get(uri);
      if (response.statusCode == 200) {
        String json = response.body;
        return currentWeatherFromJson(json);
      } else {
        throw Exception("No data");
      }
    } catch (e) {
      showErrorDialog(context, "Failed to reach the weather: $e");
    }
    throw Exception("Failed to reach the weather");
  }

  Future<ForecastWeather> getForecastWeather(Location location) async {
    try {
      print(location.latitude);
      print(location.longitude);
      Uri uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&lang=ID&units=metric&appid=${DotEnv.env['OPEN_WEATHER_API_KEY']}');

      http.Response response = await client.get(uri);
      if (response.statusCode == 200) {
        String json = response.body;
        return forecastWeatherFromJson(json);
      } else {
        throw Exception("No data");
      }
    } catch (e) {
      showErrorDialog(context, "Failed to reach the weather: $e");
    }
    throw Exception("Failed to reach the weather");
  }

  String getOpenWeatherIconString(String iconString) =>
      "https://openweathermap.org/img/wn/$iconString@4x.png";

  DateTime convertDateTime(int? timeStamp) =>
      DateTime.fromMillisecondsSinceEpoch((timeStamp ?? 0) * 1000);

  String greetingString(DateTime dateTime) {
    if (dateTime.hour >= 0 && dateTime.hour < 11) {
      return "Selamat Pagi";
    } else if (dateTime.hour >= 11 && dateTime.hour < 15) {
      return "Selamat Siang";
    } else if (dateTime.hour >= 15 && dateTime.hour < 18) {
      return "Selamat Sore";
    } else if (dateTime.hour >= 18) {
      return "Selamat Malam";
    }
    return "Halo";
  }

  String getHourMinute(int? timeStamp) {
    DateTime time = convertDateTime(timeStamp);
    return DateFormat('hh:mm a').format(time);
  }

  String getDate(int? timeStamp) {
    DateTime time = convertDateTime(timeStamp);
    return DateFormat('dd').format(time);
  }

  String getMonth(int? timeStamp) {
    DateTime time = convertDateTime(timeStamp);
    return DateFormat('MMM').format(time);
  }

  String getTempDegree(double? temp) => "${temp ?? 0} °C";
}
