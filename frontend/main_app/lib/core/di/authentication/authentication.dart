import 'package:dio/dio.dart';

abstract class Authentication {
  Interceptor get oAuthInterceptor;
  Future<void> login({Map<String, String>? queryParameters});
  Future<void> logout();
  Future<void> refreshToken();
  Future<bool> get isAuthenticated;
}
