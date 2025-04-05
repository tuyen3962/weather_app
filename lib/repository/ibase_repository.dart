import 'package:dio/dio.dart';
import 'package:weather_app/service/dio_provider.dart';

abstract class IBaseRepository<T> {
  final DioProvider dioProvider;

  IBaseRepository({required this.dioProvider});

  Dio get dio => dioProvider.dio;
}
