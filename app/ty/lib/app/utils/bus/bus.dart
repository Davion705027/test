import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

/// @Author swifter
/// @Date 2024/2/4 18:29
/// @Desc 事件总线

class Bus {
  Bus._();

  static Bus? _bus;

  static EventBus? _eventBus;

  static Bus getInstance() {
    _bus ??= Bus._();
    _eventBus ??= EventBus();

    return _bus!;
  }

  final Map<String, List<Function>> _events = {};

  /// 订阅事件
  void on(EventType event, Function callback) {
    if (_events[event.name] == null) {
      _events[event.name] = [];
    }
    _events[event.name]!.add(callback);
  }

  /// 取消订阅
  void off(EventType event) {
    if (_events[event.name] != null) {
      _events[event.name]!.safeRemoveLast();
    }
  }

  /// 发送事件
  void emit(EventType event, [dynamic data]) {
    if (_events[event.name] != null) {
      for (var element in _events[event.name]!) {
        element(data);
      }
    }
  }

  ///ws 推送
  void wsSend(event) {
    _eventBus?.fire(event);
  }

  Stream<T> wsReceive<T>() {
    return _eventBus!.on<T>();
  }

  void unRegister() {
    _eventBus?.destroy();
    _eventBus = null;
  }
}
