import 'package:flutter/material.dart';
import 'city_screen.dart';
import 'weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherLocationData weatherLocationData = WeatherLocationData();

  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();

    print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityName = '';
        weatherMessage = 'Unable to get weather data!';
      } else {
        double temp = weatherData['main']['temp'].toDouble();
        //temperature = weatherData['main']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherLocationData.getWeatherIcon(condition);

        weatherMessage = weatherLocationData.getMessage(temperature);

        cityName = weatherData['name'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/waether.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData =
                          await weatherLocationData.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typeName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typeName != null) {
                        var weatherData =
                            await weatherLocationData.getCityWeather(typeName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      weatherIcon,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
