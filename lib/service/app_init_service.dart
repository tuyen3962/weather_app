import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/service/app_init_service.config.dart';

final locator = GetIt.instance;

@InjectableInit(initializerName: 'init', preferRelativeImports: true)
Future<void> configureDependencies() => locator.init();
