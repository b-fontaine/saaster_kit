import 'package:injectable/injectable.dart';

import '../../core/core_module.dart';

@injectable
class UserIsAuthenticatedRepository {
  final Authentication _auth;

  @factoryMethod
  UserIsAuthenticatedRepository(this._auth);

  Future<bool> call() => _auth.isAuthenticated;
}
