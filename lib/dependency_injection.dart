import 'package:app_cloud_config_web/app/core/api/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void initializeDependencies() {
  // dependencies
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: Endpoints.baseUrl),
    ),
  );
}
