// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../repository/weather/iweather_repository.dart' as _i496;
import '../repository/weather/weather_repository.dart' as _i422;
import 'dio_provider.dart' as _i990;
import 'location_service.dart' as _i126;
import 'wifi_connection_service.dart' as _i269;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i126.LocationService>(() => _i126.LocationService());
    await gh.singletonAsync<_i269.WifiConnectionService>(
      () {
        final i = _i269.WifiConnectionService();
        return i.onInit().then((_) => i);
      },
      preResolve: true,
      dispose: (i) => i.dispose(),
    );
    await gh.lazySingletonAsync<_i990.DioProvider>(
      () {
        final i = _i990.DioProvider(
            connectionService: gh<_i269.WifiConnectionService>());
        return i.onInit().then((_) => i);
      },
      preResolve: true,
    );
    gh.lazySingleton<_i496.IWeatherRepository>(
        () => _i422.WeatherRepository(dioProvider: gh<_i990.DioProvider>()));
    return this;
  }
}
