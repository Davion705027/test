import 'dart:async';

import 'package:flutter_ty_app/app/global/config_controller.dart';

class HourlyTaskRunner {
  Timer? _timer;

  void start() {
    _scheduleNextHour();
  }

  void stop() {
    _timer?.cancel();
  }
  ////定时任务 整点拉取
  void _scheduleNextHour() {
    final now = DateTime.now();
    final nextHour = DateTime(now.year, now.month, now.day, now.hour + 1);
    final durationUntilNextHour = nextHour.difference(now);
    _timer = Timer(durationUntilNextHour, _runHourlyTask);
  }

  void _runHourlyTask() {
    ConfigController.to.loadTournamentMatch();
    ConfigController.to.loadMenuMapping();
    ConfigController.to.loadMenuInit();
    ConfigController.to.loadNameList();
    ConfigController.to.loadOriginData();
    _scheduleNextHour();
  }
}
