import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newtoktech_project/constants/api_end_points.dart';
import 'package:newtoktech_project/models/weather_model/weather_model.dart';
import 'package:newtoktech_project/secrets/apikey.dart';

class WeatherProvider extends ChangeNotifier {
  List<String> weatherList = [];
  WeatherModel? _weatherData;
  WeatherModel? get weatherModel => _weatherData;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _error = '';
  String get error => _error;
  Future<void> FetchWeather(String city) async {
    _isLoading = true;
    _error = "";
    try {
      final weatherUrl = "${baseUrl}q=$city&units=metric&appid=$apiKey";
      log(weatherUrl);
      final responce = await http.get(Uri.parse(weatherUrl));
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        _weatherData = WeatherModel.fromJson(jsonDecode(responce.body));
        log(responce.body);
        weatherList.add(_weatherData!.main!.temp.toString());
        notifyListeners();
      } else {
        _error = "Servier side Error";
      }
    } catch (e) {
      log(e.toString(), name: "client");
      _error = "Client side Error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    //Future.delayed(const Duration(seconds: 3));
  }
}
