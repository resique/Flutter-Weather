import 'package:music_app/models/weather_model.dart';

class FiveDayForecastListEntry {
  final int dt;
  final MainWeatherData main;
  final List<WeatherData> weatherDataList;

  FiveDayForecastListEntry({this.dt, this.main, this.weatherDataList});

  factory FiveDayForecastListEntry.fromJson(Map<String, dynamic> json) {
    var parsedList = json['weather'] as List;
    List<WeatherData> weatherDataList = parsedList.map((i) => WeatherData.fromJson(i)).toList();
    return FiveDayForecastListEntry(
      dt: json['dt'],
      main: MainWeatherData.fromJson(json['main']),
      weatherDataList: weatherDataList,
    );
  }

}

class FiveDayForecastModel {
  final List<FiveDayForecastListEntry> list;


  FiveDayForecastModel({this.list});

  factory FiveDayForecastModel.fromJson(Map<String, dynamic> json) {
    var parsedList = json['list'] as List;
    List<FiveDayForecastListEntry> weatherDataList = parsedList.map((i) => FiveDayForecastListEntry.fromJson(i)).toList();

    return FiveDayForecastModel(
        list: weatherDataList
    );
  }
}