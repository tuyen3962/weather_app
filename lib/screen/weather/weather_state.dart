import 'package:equatable/equatable.dart';
import 'package:weather_app/model/weather.dart';

class WeatherState extends Equatable {
  final WeatherModel? weatherModel;
  final List<WeatherModel>? weatherNextFewDays;
  final bool isLoading;
  final bool isError;
  final bool hasFetchSuccess;

  const WeatherState(
      {this.isError = false,
      this.weatherModel,
      this.weatherNextFewDays,
      this.hasFetchSuccess = false,
      this.isLoading = false});

  WeatherState copyWith({
    bool? isError,
    WeatherModel? weatherModel,
    List<WeatherModel>? weatherNextFewDays,
    bool? hasFetchSuccess,
    bool? isLoading,
  }) {
    return WeatherState(
      isError: isError ?? this.isError,
      weatherModel: weatherModel ?? this.weatherModel,
      weatherNextFewDays: weatherNextFewDays ?? this.weatherNextFewDays,
      hasFetchSuccess: hasFetchSuccess ?? this.hasFetchSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [weatherModel, weatherNextFewDays, isLoading, isError, hasFetchSuccess];
}
