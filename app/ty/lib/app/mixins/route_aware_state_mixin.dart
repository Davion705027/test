import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/routes/app_pages.dart';
import 'package:flutter_ty_app/app/routes/app_route_observer.dart';
import 'package:get/get.dart';

// 监听路由变化
mixin RouteAwareStateMixin<T extends StatefulWidget> on State<T>
    implements RouteAware {
  AppRouteObserver? _observer;

  @override
  void initState() {
    _observer = Routes.observer;
    _observer?.subscribe(this, Get.routing.route!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _observer?.unsubscribe(this);
  }

  @override
  void didPop() {}

  @override
  void didPush() {}

  @override
  void didPopNext() {}

  @override
  void didPushNext() {}
}
