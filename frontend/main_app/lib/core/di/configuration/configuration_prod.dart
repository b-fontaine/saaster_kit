import 'package:injectable/injectable.dart';

import 'configuration.dart';

@prod
@Order(-3)
@Singleton(as: Configuration)
class ConfigurationProd implements Configuration {
  @override
  String get apiBaseUrl => 'http://localhost/';

  @override
  String get authTokenUrl => 'http://localhost/auth/realms/saaster';

  @override
  String get authClientId => 'saaster-client';

  @override
  String get authClientSecret => 'test';
}
