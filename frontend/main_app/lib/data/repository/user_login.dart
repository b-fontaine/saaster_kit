import 'package:injectable/injectable.dart';

import '../../core/di/authentication/authentication.dart';

@injectable
class UserLoginRepository {
  final Authentication _auth;

  @factoryMethod
  UserLoginRepository(this._auth);

  Future<void> call({Map<String, String>? queryParameters}) =>
      _auth.login(queryParameters: queryParameters);
}
