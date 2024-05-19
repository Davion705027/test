import 'dart:async';
import 'dart:ui';

class DebounceUtil {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DebounceUtil({required this.milliseconds});

  void run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }
}
