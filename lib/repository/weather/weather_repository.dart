import 'package:injectable/injectable.dart';
import 'package:weather_app/constant/app_config.dart';
import 'package:weather_app/model/weather.dart';

import 'iweather_repository.dart';

@LazySingleton(as: IWeatherRepository)
class WeatherRepository extends IWeatherRepository {
  WeatherRepository({required super.dioProvider});

  @override
  Future<WeatherModel> getTodayWeather(double lat, double long) async {
    try {
      final response = await dio.get('/weather', queryParameters: {
        'lat': lat,
        'lon': long,
        "units": "metric",
        'appid': AppConfig.apiKey
      });
      return WeatherModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WeatherModel>> getWeatherForecast(double lat, double long) async {
    try {
      final response = await dio.get('/forecast', queryParameters: {
        'lat': lat,
        'lon': long,
        "cnt": 32,
        "units": "metric",
        'appid': AppConfig.apiKey
      });
      final forecastDay = <WeatherModel>[];
      final models = (response.data['list'] as List)
          .map<WeatherModel>((e) => WeatherModel.fromJson(e))
          .toList()
          .cast<WeatherModel>();
      for (var item in models) {
        DateTime date = item.time;
        if (date.hour == 13 && forecastDay.length < 4) {
          forecastDay.add(item);
        }
      }
      return forecastDay;
    } catch (e) {
      rethrow;
    }
  }
}
