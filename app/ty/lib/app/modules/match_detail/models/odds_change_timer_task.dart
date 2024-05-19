class OddsChangeTimerTask {
  String id;
  int seconds;
  Function callback;

  OddsChangeTimerTask({
    required this.id,
    required this.seconds,
    required this.callback,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OddsChangeTimerTask &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
