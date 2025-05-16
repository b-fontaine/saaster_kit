import 'package:injectable/injectable.dart';

import 'configuration.dart';

@test
@Order(-3)
@Singleton(as: Configuration)
class ConfigurationStub implements Configuration {
  @override
  String get apiBaseUrl => 'https://gherkin.test';

  @override
  String get authTokenUrl => 'https://connect.gherkin.test';

  @override
  String get authClientId => 'flutter-connect';

  @override
  String get authClientSecret => 'secret';
}
