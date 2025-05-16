import 'package:dio/dio.dart';
import 'package:dio_mocked_responses/dio_mocked_responses.dart';
import 'package:injectable/injectable.dart';

import '../configuration/configuration.dart';
import 'api_client.dart';
import 'api_module.dart';

@test
@Order(-1)
@Singleton(as: ApiModule)
class ApiModuleStub implements ApiModule {
  late final Dio _dio;
  late final ApiClient _apiClient;

  ApiModuleStub(Configuration configuration) {
    _dio = Dio()..interceptors.add(MockInterceptor(basePath: 'mocks/api'));
    _apiClient = ApiClient(_dio, baseUrl: configuration.apiBaseUrl);
  }

  @override
  Dio get dio => _dio;
  @override
  ApiClient get apiClient => _apiClient;

  @override
  Options? get forceCacheOptions => null;

  @override
  Options? get refreshOptions => null;
}
