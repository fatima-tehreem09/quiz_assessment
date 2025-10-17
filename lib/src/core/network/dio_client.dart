import 'package:dio/dio.dart';

Dio createDioClient() {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  dio.interceptors.add(
    LogInterceptor(
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: false,
      logPrint: (object) {
        if (true) {
          print(object);
        }
      },
    ),
  );

  return dio;
}
