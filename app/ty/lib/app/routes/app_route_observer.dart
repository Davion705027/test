import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/routes/app_pages.dart';

class AppRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final name = route.settings.name ?? '';
    if (name.isNotEmpty) Routes.history.add(name);
    debugPrint('didPush');
    debugPrint('Routes.history: ${Routes.history}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final name = route.settings.name ?? '';
    if (name.isNotEmpty) Routes.history.remove(name);
    debugPrint('didPop');
    debugPrint('Routes.history: ${Routes.history}');
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      final index = Routes.history.indexWhere((element) {
        return element == oldRoute?.settings.name;
      });
      final name = newRoute.settings.name ?? '';
      if (name.isNotEmpty) {
        if (index > -1) {
          Routes.history[index] = name;
        } else {
          Routes.history.add(name);
        }
      }
    }
    debugPrint('didReplace');
    debugPrint('Routes.history: ${Routes.history}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final name = route.settings.name ?? '';
    if (name.isNotEmpty) Routes.history.remove(name);
    debugPrint('didRemove');
    debugPrint('Routes.history: ${Routes.history}');
    super.didRemove(route, previousRoute);
  }
}
