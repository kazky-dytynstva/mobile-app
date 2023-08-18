import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/data/data_source/remote_api/interceptor/logging_interceptor.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';
import 'package:mobile_app/data/helper/url_creator/url_creator.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio createDio(
    List<Interceptor> interceptors,
    UrlCreator urlCreator,
  ) {
    const timeOut = Duration(milliseconds: 15 * 1000);

    final baseOptions = BaseOptions(
      baseUrl: urlCreator.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      sendTimeout: timeOut,
      responseType: ResponseType.json,
    );

    final dio = Dio(baseOptions);
    dio.interceptors.addAll(interceptors);
    return dio;
  }

  @lazySingleton
  List<Interceptor> createDioInterceptors() {
    final List<Interceptor> list = [];

    if (!EnvConfig.isProd) {
      list.add(LoggingInterceptor(getIt<Logger>()));
    }
    return list;
  }

  Connectivity connectivity() => Connectivity();
}
