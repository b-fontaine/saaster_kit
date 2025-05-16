// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/core_module.dart' as _i1039;
import 'core/di/authentication/authentication.dart' as _i704;
import 'core/di/authentication/authentication_impl.dart' as _i588;
import 'core/di/authentication/authentication_stub.dart' as _i690;
import 'core/di/configuration/configuration.dart' as _i459;
import 'core/di/configuration/configuration_prod.dart' as _i658;
import 'core/di/configuration/configuration_stub.dart' as _i219;
import 'core/di/network/api_module.dart' as _i496;
import 'core/di/network/api_module_impl.dart' as _i1022;
import 'core/di/network/api_module_stub.dart' as _i763;
import 'data/data_module.dart' as _i947;
import 'data/repository/user_info.dart' as _i440;
import 'data/repository/user_is_authenticated.dart' as _i1048;
import 'data/repository/user_login.dart' as _i1029;
import 'domain/domain_module.dart' as _i230;
import 'domain/usecases/aggregate_login_if_needed.dart' as _i752;
import 'domain/usecases/get_is_connected.dart' as _i616;
import 'domain/usecases/get_user.dart' as _i714;
import 'domain/usecases/login_user.dart' as _i782;
import 'ui/router.dart' as _i766;

const String _test = 'test';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i459.Configuration>(
      () => _i219.ConfigurationStub(),
      registerFor: {_test},
    );
    gh.singleton<_i459.Configuration>(
      () => _i658.ConfigurationProd(),
      registerFor: {_prod},
    );
    gh.singleton<_i704.Authentication>(
      () => _i690.AuthenticationStub(),
      registerFor: {_test},
    );
    gh.singleton<_i704.Authentication>(
      () => _i588.AuthenticationImpl(gh<_i459.Configuration>()),
      registerFor: {_prod},
    );
    gh.singleton<_i496.ApiModule>(
      () => _i763.ApiModuleStub(gh<_i459.Configuration>()),
      registerFor: {_test},
    );
    gh.singleton<_i496.ApiModule>(
      () => _i1022.ApiModuleImpl(
        gh<_i704.Authentication>(),
        gh<_i459.Configuration>(),
      ),
      registerFor: {_prod},
    );
    gh.factory<_i1048.UserIsAuthenticatedRepository>(
      () => _i1048.UserIsAuthenticatedRepository(gh<_i1039.Authentication>()),
    );
    gh.factory<_i1029.UserLoginRepository>(
      () => _i1029.UserLoginRepository(gh<_i704.Authentication>()),
    );
    gh.factory<_i782.LoginUser>(
      () => _i782.LoginUser(gh<_i947.UserLoginRepository>()),
    );
    gh.singleton<_i616.GetIsConnected>(
      () => _i616.GetIsConnected(gh<_i947.UserIsAuthenticatedRepository>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i440.UserInfoRepository>(
      () => _i440.UserInfoRepository(gh<_i496.ApiModule>()),
    );
    gh.factory<_i752.AggregateLoginIfNeeded>(
      () => _i752.AggregateLoginIfNeeded(
        gh<_i230.LoginUser>(),
        gh<_i230.GetIsConnected>(),
      ),
    );
    gh.singleton<_i714.GetUser>(
      () => _i714.GetUser(
        gh<_i947.UserIsAuthenticatedRepository>(),
        gh<_i947.UserInfoRepository>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i766.AppRouter>(
      () => _i766.AppRouter(
        gh<_i230.AggregateLoginIfNeeded>(),
        gh<_i230.GetIsConnected>(),
      ),
      dispose: (i) => i.dispose(),
    );
    return this;
  }
}
