import 'dart:async';

import 'package:injectable/injectable.dart';

import '/data/data_module.dart';

@injectable
class LoginUser {
  final UserLoginRepository _userLoginRepository;

  @factoryMethod
  LoginUser(this._userLoginRepository);

  Future<void> call({Map<String, String>? queryParameters}) =>
      _userLoginRepository(queryParameters: queryParameters);
}
