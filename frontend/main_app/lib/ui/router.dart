// coverage:ignore-file

import 'package:design_system/design_system.dart' show DSButtons;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../domain/domain_module.dart';
import 'app.dart' deferred as app;

@singleton
class AppRouter {
  final AggregateLoginIfNeeded _loginUser;
  final GetIsConnected _getIsConnected;

  GoRouter? _goRouter;
  late final ValueNotifier<RoutingConfig> _routingConfiguration;
  final String _fragment = Uri.base.fragment;
  Map<String, String> _params = Map.fromEntries(
    Uri.base.queryParameters.entries,
  );

  Map<String, String> get queryParameters =>
      _params.isNotEmpty ? _params : _toMap(_fragment);

  set queryParameters(Map<String, String> params) {
    _params = params;
  }

  AppRouter(this._loginUser, this._getIsConnected) {
    _routingConfiguration = ValueNotifier<RoutingConfig>(
      RoutingConfig(
        routes: <RouteBase>[
          ShellRoute(
            builder: (context, state, child) {
              return child; // Ajouter ici le socle commun de toute votre application
            },
            routes: [
              transitionGoRoute(
                path: '/',
                builder:
                    (context, state) => FutureBuilder(
                      future: app.loadLibrary(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return app.App();
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                //    App(), // Route racine, les autres seront ajoutées par injection de dépendance
              ),
            ],
          ),
        ],
      ),
    );

    Uri.base.removeFragment();
  }

  GoRouter initWithRoute(String route) {
    _goRouter = GoRouter.routingConfig(
      routingConfig: _routingConfiguration,
      initialLocation: route,
    );
    return _goRouter!;
  }

  GoRouter get goRouter {
    _goRouter ??= GoRouter.routingConfig(routingConfig: _routingConfiguration);
    return _goRouter!;
  }

  void addRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) {
    _routingConfiguration.value.routes[0].routes.add(
      transitionGoRoute(
        path: path,
        builder: (context, state) {
          if (queryParameters.containsKey("code") &&
              queryParameters.containsKey("state") &&
              queryParameters.containsKey("session_state")) {
            _loginUser(queryParameters: queryParameters);
          }
          _getIsConnected();
          return StreamBuilder(
            stream: _getIsConnected.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return builder(context, state);
                }
                return DSButtons.primaryAppButton(
                  text: "Login",
                  onPressed: _loginUser.call,
                );
              }
              return const CircularProgressIndicator();
            },
          );
        },
      ),
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

GoRoute transitionGoRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
}) {
  return GoRoute(
    path: path,
    pageBuilder:
        (context, state) => CustomTransitionPage(
          child: builder(context, state),
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        ),
  );
}
