import 'dart:async';

import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../modules/match_detail/models/odds_change_timer_task.dart';

class GlobalStreamTimer {
  final StreamController<int> streamController = StreamController.broadcast();
  int i = 0;

  GlobalStreamTimer._() {
    Timer.periodic(const Duration(seconds: 1), _timerCallback);
  }

  static GlobalStreamTimer? _timer;

  static GlobalStreamTimer getInstance() {
    _timer ??= GlobalStreamTimer._();

    return _timer!;
  }

  void _timerCallback(Timer timer) {
    i++;
    if (Get.isRegistered<HomeController>() && HomeController.to.visiable) {
      if (HomeController.to.homeState.endScroll) {
        streamController.add(i);
      }
    } else {
      streamController.add(i);
    }
  }
}

class GlobalTimer {
  Timer? _timer;

  GlobalTimer._() {
    _timer = Timer.periodic(const Duration(seconds: 1), _timerCallback);
  }

  static GlobalTimer? _globalTimer;

  static GlobalTimer getInstance() {
    _globalTimer ??= GlobalTimer._();
    return _globalTimer!;
  }

  static final List<OddsChangeTimerTask> _tasks = [];

  void _timerCallback(Timer timer) {
    // 在这里执行定时任务的逻辑
    List<OddsChangeTimerTask> removeList = [];
    _tasks.forEach((task) {
      if (task.seconds <= 0) {
        task.callback();
        removeList.add(task);
      } else {
        task.seconds--;
      }
    });
    removeList.forEach((element) {
      _tasks.remove(element);
    });
  }

  void push(OddsChangeTimerTask task) {
    // 检查任务是否已经存在于列表中
    if (!_tasks.contains(task)) {
      _tasks.add(task);
    } else {
      _tasks.firstWhereOrNull((element) => element == task)?.seconds =
          task.seconds;
    }
  }

  void pop(Function task) {
    _tasks.remove(task);
  }

  void dispose() {
    _timer?.cancel();
    _globalTimer = null;
  }
}
