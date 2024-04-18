import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:piggybank/presentation/wallet_detail_view.dart';
import 'package:piggybank/presentation/wallet_list_view.dart';

class RoutesManager {
  static const String home = 'home';
  static const String details = 'details';

  static const String paramId = 'id';
}

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: RoutesManager.home,
      builder: (BuildContext context, GoRouterState state) {
        return const WalletListView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '${RoutesManager.details}/:${RoutesManager.paramId}',
          name: RoutesManager.details,
          builder: (BuildContext context, GoRouterState state) {
            String id = state.pathParameters[RoutesManager.paramId]!;
            return WalletDetailView(id: id);
          },
        ),
      ],
    ),
  ],
);
