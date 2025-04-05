abstract class WeatherEvent {}

class LoadingWeather extends WeatherEvent {
  LoadingWeather();
}

class GetWeatherEvent extends WeatherEvent {
  GetWeatherEvent();
}

class ErrorFetchWeather extends WeatherEvent {
  ErrorFetchWeather();
}
