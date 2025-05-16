import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:saaster/domain/domain_module.dart';

@injectable
class AggregateLoginIfNeeded {
  final LoginUser _loginUser;
  final GetIsConnected _getIsConnected;

  @factoryMethod
  AggregateLoginIfNeeded(this._loginUser, this._getIsConnected);

  Future<void> call({Map<String, String>? queryParameters}) async {
    if (await _getIsConnected()) {
      return;
    }
    _loginUser(queryParameters: queryParameters);
  }
}
