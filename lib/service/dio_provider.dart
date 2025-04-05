import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/constant/app_config.dart';
import 'package:weather_app/service/wifi_connection_service.dart';

@lazySingleton
class DioProvider {
  final WifiConnectionService connectionService;

  DioProvider({
    required this.connectionService,
  });

  late Dio _dio;

  Dio get dio => _dio;

  @PostConstruct(preResolve: true)
  Future<void> onInit() async {
    _dio = Dio(BaseOptions(baseUrl: AppConfig.apiURL))
      ..interceptors.addAll([
        // HeaderInterceptor(
        //     model: model, localStorage: localStorage, version: version),
        if (kDebugMode)
          LogInterceptor(
              request: true,
              responseBody: true,
              requestBody: true,
              requestHeader: true,
              logPrint: (object) => log('$object'))
      ]);
  }
}
