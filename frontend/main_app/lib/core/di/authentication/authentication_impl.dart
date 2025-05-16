// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:dio_oidc_interceptor/dio_oidc_interceptor.dart';
import 'package:injectable/injectable.dart';

import '../configuration/configuration.dart';
import 'authentication.dart';

@prod
@Order(-2)
@Singleton(as: Authentication)
class AuthenticationImpl implements Authentication {
  late final OpenId _oAuth;

  AuthenticationImpl(Configuration configuration) {
    _oAuth = OpenId(
        configuration: OpenIdConfiguration(
      clientId: configuration.authClientId,
      clientSecret: configuration.authClientSecret,
      uri: Uri.parse(configuration.authTokenUrl),
      scopes: ['openid'],
    ));
  }

  @override
  Future<void> login({Map<String, String>? queryParameters}) =>
      _oAuth.login(queryParameters: queryParameters);

  @override
  Future<void> logout() => _oAuth.logout();

  @override
  Interceptor get oAuthInterceptor => _oAuth;

  @override
  Future<void> refreshToken() => _oAuth.login();

  @override
  Future<bool> get isAuthenticated => _oAuth.isConnected;
}
