// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'authentication.dart';

@test
@Order(-2)
@Singleton(as: Authentication)
class AuthenticationStub implements Authentication {
  bool _isAuthenticated = false;
  int _refreshTokenCount = 0;
  final EmptyInterceptor _emptyInterceptor = EmptyInterceptor();

  Future<int> get refreshTokenCount async => _refreshTokenCount;

  @override
  Future<bool> get isAuthenticated async => _isAuthenticated;

  @override
  Future<void> login({Map<String, String>? queryParameters}) async {
    _isAuthenticated = true;
  }

  @override
  Future<void> logout() async {
    _isAuthenticated = false;
  }

  @override
  Interceptor get oAuthInterceptor => _emptyInterceptor;

  @override
  Future<void> refreshToken() async {
    _refreshTokenCount++;
  }
}

class EmptyInterceptor extends Interceptor {}
