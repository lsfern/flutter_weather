import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/bean/weather.dart';

class WeatherRepository {
  static const _getWeatherUrl =
      "http://www.tianqiapi.com/api?version=v9&appid=52396359&appsecret=m36qtLQA";

  static Future<Weather> getWeather({String cityName}) async {
    Weather weather;
    try {
      Response response = await Dio().get(
          "${cityName.isNotEmpty ? _getWeatherUrl + "&city=" + cityName : _getWeatherUrl}");
      if (response.statusCode >= 200 && response.statusCode <= 400) {
        weather = Weather.fromJson(response.data);
      }
      print(jsonEncode(weather));
    } catch (e) {
      print("get weather failed $e");
    }
    return weather;
  }
}
