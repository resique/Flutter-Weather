class WeatherData {
  final String description;
  final String icon;
  WeatherData({this.description, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      description: json['main'],
      icon: json['icon'],
    );
  }
}

class MainWeatherData {
  final double temp;
  final double temp_min;
  final double temp_max;

  MainWeatherData({this.temp, this.temp_min, this.temp_max});

  factory MainWeatherData.fromJson(Map<String, dynamic> json) {
    return MainWeatherData(
        temp: json['temp'].toDouble(),
        temp_max: json['temp_max'].toDouble(),
        temp_min: json['temp_min'].toDouble(),
    );
  }
}

class WeatherModel {
  final List<WeatherData> weatherData;
  MainWeatherData mainWeatherData;
  final int dt;
  final String city;
  WeatherModel({this.weatherData, this.mainWeatherData, this.dt, this.city});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    List<WeatherData> weatherDataList = list.map((i) => WeatherData.fromJson(i)).toList();

    return WeatherModel(
      weatherData: weatherDataList,
      mainWeatherData: MainWeatherData.fromJson(json['main']),
      dt: json['dt'],
      city: json['name'],
    );
  }
}