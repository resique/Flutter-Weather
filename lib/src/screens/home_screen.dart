import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:music_app/models/FiveDayForecast.dart';
import 'package:music_app/models/weather_model.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<WeatherModel> weather;
  Future<FiveDayForecastModel> fiveDayForecast;

  Future<FiveDayForecastModel> fetchFiveDayForecast() async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?id=706483&APPID=c59ab0270c5b4b0369a400584b9d2a2e&units=metric&mode=json');
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print('successfully retrieved five day weather data');
      return FiveDayForecastModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<WeatherModel> fetchWeather() async {
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?id=706483&APPID=c59ab0270c5b4b0369a400584b9d2a2e&units=metric');
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print('successfully retrieved weather data');
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  String getIconFromIconId(String id) {
    switch(id) {
      case "01d":
        return "assets/sunIcon/icons8-sun-50px.png";
      case "01n":
        return "assets/sunIcon/icons8-sun-50px.png";
      case "02d":
        return "assets/partCloudIcon/icons8-partly-cloudy-day-50.png";
      case "02n":
        return "assets/partCloudIcon/icons8-partly-cloudy-day-50.png";
      case "03d":
        return "assets/cloudIcon/icons8-clouds-50px.png";
      case "03n":
        return "assets/cloudIcon/icons8-clouds-50px.png";
      case "04d":
        return "assets/cloudIcon/icons8-clouds-50px.png";
      case "04n":
        return "assets/cloudIcon/icons8-clouds-50px.png";
      case "09d":
        return "assets/showerRainIcon/icons8-heavy-rain-50.png";
      case "09n":
        return "assets/showerRainIcon/icons8-heavy-rain-50.png";
      case "10d":
        return "assets/rainIcon/icons8-moderate-rain-50.png";
      case "10n":
        return "assets/rainIcon/icons8-moderate-rain-50.png";
      case "11d":
        return "assets/stromIcon/icons8-storm-50.png";
      case "11n":
        return "assets/stromIcon/icons8-storm-50.png";
      case "13d":
        return "assets/snowIcon/icons8-snow-50.png";
      case "13n":
        return "assets/snowIcon/icons8-snow-50.png";
      case "50d":
        return "assets/fogIcon/icons8-fog-50.png";
      case "50n":
        return "assets/fogIcon/icons8-fog-50.png";
    }
  }
  // Init state

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
    fiveDayForecast = fetchFiveDayForecast();
  }

  // Build

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: FutureBuilder<WeatherModel>(
                future: weather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    DateTime date = DateTime.fromMillisecondsSinceEpoch(snapshot.data.dt * 1000);
                    String formattedDate = DateFormat('hh:mm a, EEE MMM d').format(date);

                    return Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blueAccent,
                                  Colors.lightBlueAccent,
                                  Colors.white

                                ])),
                        child: SafeArea(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _topInfo(formattedDate, snapshot.data.city),
                                    _bottomInfo(
                                        snapshot.data.mainWeatherData.temp,
                                        snapshot.data.mainWeatherData.temp_min,
                                        snapshot.data.mainWeatherData.temp_max,
                                        snapshot.data.weatherData.first.description)
                                  ]),
                            )));

                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  }
                  return Center(
                      child: CircularProgressIndicator()
                  );
                })));
  }

  // Weather Cell

  Container _weatherCell(String imageName, double temperature, String time, String date) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            temperature.toString() + '°C',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Image(height: 40, image: AssetImage(imageName)),
          Text(date),
          Text(time),

        ],
      ),
    );
  }

  // Top Info

  Container _topInfo(String time, String place) {
    return Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(time),
        Text(
          place,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ]),
      Icon(
        Icons.menu,
        color: Colors.black,
        size: 40,
      )
    ]));
  }

  // Main temperature

  Container _mainTemperatureInfo(double temperature) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(temperature.toString(),
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.w700)),
        // Spacer
        Container(
          width: 10,
        ),
        Text('°C', style: TextStyle(fontSize: 24))
      ],
    ));
  }

  // Additional temperature

  Container _additionalTemperature(double up, double down) {
    return Container(
      height: 95,
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('↑', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(up.toString() + '°C')
            ],
          ),
          Row(
            children: <Widget>[
              Text('↓', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(down.toString() + '°C')
            ],
          )
        ],
      ),
    );
  }

  // Bottom Info

  Container _bottomInfo(
      double temp, double minTemp, double maxTemp, String description) {
    return Container(
      // Main column
      child: Column(
        children: <Widget>[
          Container(
            height: 95,

            // Top row with main temperature readings
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Main temperature and celsius sign
                _mainTemperatureInfo(temp),

                // Additional temperature readings
                _additionalTemperature(minTemp, maxTemp)
              ],
            ),
          ),

          // Column with separator line and weather description
          Container(
            padding: EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(thickness: 7, color: Colors.black),
                Text(description,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300))
              ],
            ),
          ),
          Container(
            height: 95,
            child: FutureBuilder<FiveDayForecastModel>(
              future: fiveDayForecast,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.list.length,
                      itemBuilder: (context, index) {

                      DateTime date = DateTime.fromMillisecondsSinceEpoch(snapshot.data.list[index].dt * 1000);
                      String formattedDate = DateFormat('dd.MM-hh a').format(date);

                        return _weatherCell(
                            getIconFromIconId(snapshot.data.list[index].weatherDataList.first.icon),
                            snapshot.data.list[index].main.temp,
                            formattedDate.split('-')[1],
                            formattedDate.split('-').first
                        );
                      },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
