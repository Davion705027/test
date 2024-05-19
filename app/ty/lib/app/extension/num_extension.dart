/**
 * @Author swifter
 * @Date 2024/2/4 18:22
 */

/// 安全数据组
extension SafeList<T> on List<T> {
  T? safe(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }

  T? get safeLast {
    if (length > 0) {
      return this[length - 1];
    }
    return null;
  }

  T? get safeFirst {
    if (length > 0) {
      return this[0];
    }
    return null;
  }

  T? get safeRe {
    if (length > 0) {
      return this[0];
    }
    return null;
  }

  List<T> safeSublist(int startIndex, int endIndex) {
    // 确保索引范围有效
    if (startIndex < 0) startIndex = 0;
    if (endIndex >= length) endIndex = length - 1;

    if (startIndex <= endIndex) {
      return sublist(startIndex, endIndex + 1);
    } else {
      return <T>[];
    }
  }

  T? safeRemoveLast() {
    if (isEmpty) {
      return null;
    } else {
      return removeLast();
    }
  }
}

extension SecondsToCountdownTime on int? {
  // 转成倒计时
  String get secondsToCountdown {
    if (this == null || this == 0) {
      return "00:00";
    }

    int hours = (this! / 3600).floor();
    int minutes = ((this! % 3600) / 60).floor();
    int remainingSeconds = this! % 60;

    if (hours <= 0) {
      String minutesString = minutes.toString().padLeft(2, '0');
      String secondsString = remainingSeconds.toString().padLeft(2, '0');
      return '$minutesString:$secondsString';
    } else {
      String hoursString = hours.toString().padLeft(2, '0');
      String minutesString = minutes.toString().padLeft(2, '0');
      String secondsString = remainingSeconds.toString().padLeft(2, '0');
      return '$hoursString:$minutesString:$secondsString';
    }
  } // 转成倒计时

  String get millsecondsToCountdown {
    if (this == null || this == 0) {
      return "00:00";
    }

    int seconds = (this! / 1000).floor();
    int milliseconds = (this! % 900);
    String secondsString = seconds.toString().padLeft(2, '0');
    String millisecondsString = milliseconds.toString().padLeft(2, '0');
    return '$secondsString:$millisecondsString';
  }
}
