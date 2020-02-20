import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'location.dart';
import 'networking.dart';

const apiKey = '7c00e91d3069779ece0112c2e12901fe';

class WeatherLocationData {
//  double latitude;
//  double longitude;

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weatherss?q=$cityName&appid=$apiKey&units=metric';
    NetworkModel networkModel = NetworkModel(url: url);

    var weatherData = await networkModel.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    LocationStatus location = LocationStatus();

    await location.getCurrentLocation();

//    latitude = locationStatus.latitude;
//    longitude = locationStatus.longitude;

    NetworkModel networkModel = NetworkModel(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkModel.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'snowny';
    } else if (condition < 400) {
      return 'snow';
    } else if (condition < 600) {
      return ' rain';
    } else if (condition < 700) {
      return ' ice';
    } else if (condition < 800) {
      return ' ice block';
    } else if (condition == 800) {
      return ' sunny';
    } else if (condition <= 804) {
      return ' cold';
    } else {
      return 'I don\'t know';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s Ice Cream time';
    } else if (temp > 20) {
      return 'Time for short and coat';
    } else if (temp < 10) {
      return 'You will need garment and glove';
    } else {
      return 'Bring a jacket in case!';
    }
  }
}
