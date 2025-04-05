import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/repository/weather/iweather_repository.dart';
import 'package:weather_app/screen/weather/weather_event.dart';
import 'package:weather_app/screen/weather/weather_state.dart';
import 'package:weather_app/service/app_init_service.dart';
import 'package:weather_app/service/location_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherRepository weatherRepository = locator.get();
  final LocationService locationService = locator.get();

  WeatherBloc() : super(const WeatherState()) {
    on<WeatherEvent>((event, emit) async {
      if (event is LoadingWeather) {
        emit(state.copyWith(
            isLoading: true, isError: false, hasFetchSuccess: false));
      } else if (event is GetWeatherEvent) {
        await _getWeather(emit);
      } else if (event is ErrorFetchWeather) {
        emit(state.copyWith(
            isError: true, isLoading: false, hasFetchSuccess: false));
      }
    });

    fetchWeather();
  }

  void fetchWeather() {
    add(LoadingWeather());
    add(GetWeatherEvent());
  }

  Future<void> _getWeather(Emitter<WeatherState> emit) async {
    try {
      final location = await locationService.getCurrentLocation();
      if (location != null) {
        final result = await weatherRepository.getTodayWeather(
            location.latitude, location.longitude);
        final forestWeather = await weatherRepository.getWeatherForecast(
            location.latitude, location.longitude);
        emit(state.copyWith(
            isLoading: false,
            isError: false,
            hasFetchSuccess: true,
            weatherModel: result,
            weatherNextFewDays: forestWeather));
      }
    } catch (e) {
      add(ErrorFetchWeather());
    }
  }
}
