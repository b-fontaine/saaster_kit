import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:injectable/injectable.dart';

import '../authentication/authentication.dart';
import '../configuration/configuration.dart';
import 'api_client.dart';
import 'api_module.dart';

@prod
@Order(-1)
@Singleton(as: ApiModule)
class ApiModuleImpl implements ApiModule {
  late final Dio _dio;
  late final ApiClient _apiClient;

  ApiModuleImpl(Authentication auth, Configuration configuration) {
    var cache = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
    );
    _dio = Dio()
      ..interceptors.addAll([
        auth.oAuthInterceptor,
        DioCacheInterceptor(options: cache),
      ]);
    _apiClient = ApiClient(_dio, baseUrl: configuration.apiBaseUrl);
  }

  @override
  Dio get dio => _dio;
  @override
  ApiClient get apiClient => _apiClient;

  @override
  Options? get forceCacheOptions => const CacheOptions(
        policy: CachePolicy.forceCache,
        store: null,
      ).toOptions();

  @override
  Options? get refreshOptions => const CacheOptions(
        policy: CachePolicy.refresh,
        store: null,
      ).toOptions();
}
