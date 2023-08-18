// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger _logger;

  LoggingInterceptor(this._logger);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    _log(" ╔══════ API Request ═══════");
    _log(" ║ method: ${options.method}");
    _log(" ║ baseUrl: ${options.baseUrl}");
    _log(" ║ pathUrl: ${options.path}");

    // headers
    if (options.headers.isEmpty) {
      _log(" ║ headers: [empty]");
    } else {
      _log(" ║ headers:");
      options.headers.forEach((String key, dynamic value) {
        _log(" ║    $key : $value");
      });
    }

    // queryParameters
    if (options.queryParameters.isEmpty) {
      _log(" ║ queryParameters: [empty]");
    } else {
      _log(" ║ queryParameters:");
      options.queryParameters.forEach((String key, dynamic value) {
        _log(" ║    $key : $value");
      });
    }

    // data
    if (options.data == null) {
      _log(" ║ data: [empty]");
    } else {
      _log(" ║ data:");
      if (options.data is Map) {
        final map = (options.data as Map);
        if (map.isEmpty) {
          _log(" ║ data: [empty]");
        } else {
          options.data.forEach((String key, dynamic value) {
            _log(" ║    $key : $value");
          });
        }
      } else if (options.data is FormData) {
        final fields = (options.data as FormData).fields;
        if (fields.isEmpty) {
          _log(" ║ data fields: [empty]");
        } else {
          for (final entry in (options.data as FormData).fields) {
            _log(" ║    ${entry.key} : ${entry.value}");
          }
        }
        final files = (options.data as FormData).files;
        if (files.isEmpty) {
          _log(" ║ data files: [empty]");
        } else {
          for (final entry in (options.data as FormData).files) {
            _log(" ║    ${entry.key} : ${entry.value}");
          }
        }
      } else {
        _log(" ║    ${options.data.toString()}");
      }
    }

    _log(" ╚══════════════════════════");

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    _log(" ╔══════ API Response ═══════");
    _log(" ║ method: ${response.requestOptions.method}");
    _log(" ║ baseUrl: ${response.requestOptions.baseUrl}");
    _log(" ║ pathUrl: ${response.requestOptions.path}");

    _log(" ║ statusCode: ${response.statusCode}");
    _log(" ║ statusMessage: ${response.statusMessage}");

    // headers
    if (response.headers.map.isEmpty) {
      _log(" ║ headers: [empty]");
    } else {
      _log(" ║ headers:");
      response.headers.map.forEach((String key, dynamic value) {
        _log(" ║    $key : $value");
      });
    }

    // extra
    if (response.extra.isEmpty) {
      _log(" ║ extra: [empty]");
    } else {
      _log(" ║ extra:");
      response.extra.forEach((String key, dynamic value) {
        _log(" ║    $key : $value");
      });
    }

    // data
    if (response.data == null) {
      _log(" ║ data: [empty]");
    } else {
      _log(" ║ data:");
      if (response.data is Map) {
        response.data.forEach((String key, dynamic value) {
          _log(" ║    $key : $value");
        });
      } else {
        _log(" ║    ${response.data}");
      }
    }

    _log(" ╚═══════════════════════════");

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log(" ╔══════ API Request failed ═══════");
    _log(" ║ method: ${err.requestOptions.method}");
    _log(" ║ baseUrl: ${err.requestOptions.baseUrl}");
    _log(" ║ pathUrl: ${err.requestOptions.path}");
    _log(" ║ errorType: ${err.type}");
    _log(" ║ error: ${err.error}");
    _log(" ║ message: ${err.message}");
    // data
    if (err.response?.data == null) {
      _log(" ║ data: [empty]");
    } else {
      _log(" ║ data:");
      if (err.response?.data is Map) {
        err.response?.data.forEach((String key, dynamic value) {
          _log(" ║    $key : $value");
        });
      } else {
        _log(" ║    ${err.response?.data}");
      }
    }
    _log(" ╚═════════════════════════════════");

    handler.next(err);
  }

  void _log(String msg) => _logger.log(
        () => msg,
        tag: '$LoggingInterceptor',
      );
}
