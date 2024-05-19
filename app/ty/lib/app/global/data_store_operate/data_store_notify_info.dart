class WSMatchMarketOddsInfo {
  String wsType;
  dynamic data;
  List<String> matchIds;
  List<String> marketIds;
  List<String> oddIds;

  WSMatchMarketOddsInfo({
    required this.wsType,
    required this.data,
    required this.matchIds,
    required this.marketIds,
    required this.oddIds,
  });
}

class WSNotifyInfo {
  String wsType;
  String payload;

  WSNotifyInfo(this.wsType, this.payload);
}
