// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../domain/domain_module.dart';
import 'app.dart' deferred as app;

@singleton
class AppRouter {
  final LoginUser _loginUser;
  final GetIsConnected _getIsConnected;

  GoRouter? _goRouter;
  late final ValueNotifier<RoutingConfig> _routingConfiguration;

  AppRouter(this._loginUser, this._getIsConnected) {
    _routingConfiguration = ValueNotifier<RoutingConfig>(
      RoutingConfig(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (context, state) {
              return FutureBuilder(
                future: app.loadLibrary(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return app.App();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            },
            redirect: (context, state) async {
              if (await _loginIfNeeded()) {
                return '/';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _loginIfNeeded() async {
    final queryParameters = Uri.base.queryParameters;
    Uri.base.removeFragment();
    Uri.base.replace(queryParameters: null);
    if (false == await _getIsConnected() &&
        queryParameters.containsKey("code") &&
        queryParameters.containsKey("state") &&
        queryParameters.containsKey("session_state")) {
      print("Login needed with query parameters: $queryParameters");
      await _loginUser(queryParameters: queryParameters);
      await _getIsConnected();
      return true;
    }
    return false;
  }

  GoRouter initRouter({String? route}) {
    final router = GoRouter.routingConfig(
      routingConfig: _routingConfiguration,
      initialLocation: route,
    );
    return router;
  }

  GoRouter get goRouter {
    _goRouter ??= initRouter();
    return _goRouter!;
  }

  void addRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) {
    _routingConfiguration.value.routes[0].routes.add(
      GoRoute(path: path, builder: builder),
    );
  }

  void go(String path) {
    goRouter.go(path);
  }

  Map<String, String> _toMap(String fragment) {
    var data = fragment
        .split('&')
        .map((e) => e.split('='))
        .map((e) => MapEntry(e.first, e.last));
    return Map.fromEntries(data);
  }

  @disposeMethod
  void dispose() {
    goRouter.dispose();
    _routingConfiguration.dispose();
  }
}
