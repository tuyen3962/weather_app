import 'package:weather_app/model/weather.dart';
import 'package:weather_app/repository/ibase_repository.dart';

abstract class IWeatherRepository extends IBaseRepository {
  IWeatherRepository({required super.dioProvider});

  Future<WeatherModel> getTodayWeather(double lat, double long);
  Future<List<WeatherModel>> getWeatherForecast(double lat, double long);
}
