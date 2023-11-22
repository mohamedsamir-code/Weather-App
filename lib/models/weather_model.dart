import 'dart:core';

import 'package:flutter/material.dart';

class WeatherModel {
  String date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherStateName});

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['days'][0];
    return WeatherModel(
        date: jsonData['datetime'],
        temp: jsonData['temp'],
        maxTemp: jsonData['tempmax'],
        minTemp: jsonData['tempmin'],
        weatherStateName: jsonData['conditions']);
  }

  String getImage() {
    if (weatherStateName == 'Clear') {
      return 'assets/images/clear.png';
    } else if (weatherStateName == 'Overcast' || weatherStateName == 'Partially cloudy') {
      return 'assets/images/cloudy.png';
    } else if (weatherStateName == 'Rain' || weatherStateName == 'Rain, Partially cloudy') {
      return 'assets/images/rainy.png';
    } else {
      return 'assets/images/clear.png';
    }
  }

  MaterialColor getThemeColor() {
    if (weatherStateName == 'Clear') {
      return Colors.orange;
    } else if (weatherStateName == 'Partially cloudy' || weatherStateName == 'Overcast' || weatherStateName == 'Rain' || weatherStateName == 'Rain, Partially cloudy') {
      return Colors.blueGrey;
    } else {
      return Colors.blue;
    }
  }

  @override
  String toString() {
    return 'date: $date temp: $temp maxTemp: $maxTemp minTemp: $minTemp weatherStateName: $weatherStateName';
  }
}