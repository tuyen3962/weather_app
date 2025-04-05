import 'package:flutter/material.dart';
import 'package:weather_app/screen/weather/weather_screen.dart';
import 'package:weather_app/service/app_init_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: WeatherPage());
  }
}
