import 'package:injectable/injectable.dart';

import '../../core/di/network/api_module.dart';
import '../dto/user.dart';

@injectable
class UserInfoRepository {
  final ApiModule _apiModule;

  @factoryMethod
  UserInfoRepository(this._apiModule);

  Future<UserDto> call() => _apiModule.apiClient.getUser(
        _apiModule.refreshOptions,
      );
}
