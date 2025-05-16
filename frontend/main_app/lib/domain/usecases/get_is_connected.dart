import 'dart:async';

import 'package:injectable/injectable.dart';

import '/data/data_module.dart';

@singleton
class GetIsConnected {
  final UserIsAuthenticatedRepository _isAuthenticatedRepository;
  final StreamController<bool> _controller = StreamController<bool>();
  late final Stream<bool> _stream;

  Stream<bool> get stream => _stream;

  GetIsConnected(this._isAuthenticatedRepository) {
    _stream = _controller.stream.asBroadcastStream();
  }

  Future<bool> call() async {
    var result = await _isAuthenticatedRepository();
    _controller.sink.add(result);
    return result;
  }

  @disposeMethod
  void dispose() {
    _controller.close();
  }
}
