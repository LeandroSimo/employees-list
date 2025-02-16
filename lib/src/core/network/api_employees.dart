import 'package:dio/dio.dart';

class ApiEmployees {
  final Dio _dio = Dio();

  ApiEmployees() {
    _dio.options.baseUrl = 'http://10.0.2.2:3000';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Dio get dio => _dio;
}
