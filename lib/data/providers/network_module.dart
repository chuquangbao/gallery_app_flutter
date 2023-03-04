import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gallery_app_flutter/data/providers/curl_logger_interceptor.dart';
import 'package:gallery_app_flutter/utils/constants.dart';

class NetworkModule {
  late BaseOptions _baseOptions;

  // dio instance
  Dio get dio => _initDio();

  NetworkModule() {
    _baseOptions = BaseOptions(
      baseUrl: NetworkConstants.basePhotoUrl,
      connectTimeout:
          const Duration(milliseconds: NetworkConstants.connectionTimeout),
      receiveTimeout:
          const Duration(milliseconds: NetworkConstants.receiveTimeout),
      contentType: 'application/json; charset=utf-8',
    );
  }

  Dio _initDio() {
    final dio = Dio(_baseOptions);
    if (kDebugMode) {
      dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: false));
    }
    return dio;
  }
}
