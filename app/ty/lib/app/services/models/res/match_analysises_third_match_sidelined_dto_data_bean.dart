class MatchAnalysisesThirdMatchSidelinedDTODataBean {
  num? homeAway;
  String? playerName;
  String? positionName;
  String? reason;
  num? shirtNumber;
  String? thirdPlayerPicUrl;

  MatchAnalysisesThirdMatchSidelinedDTODataBean(
      {this.homeAway,
        this.playerName,
        this.positionName,
        this.reason,
        this.shirtNumber,
        this.thirdPlayerPicUrl});

  MatchAnalysisesThirdMatchSidelinedDTODataBean.fromJson(
      Map<String, dynamic> json) {
    homeAway = json['homeAway'];
    playerName = json['playerName'];
    positionName = json['positionName'];
    reason = json['reason'];
    shirtNumber = json['shirtNumber'];
    thirdPlayerPicUrl = json['thirdPlayerPicUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homeAway'] = this.homeAway;
    data['playerName'] = this.playerName;
    data['positionName'] = this.positionName;
    data['reason'] = this.reason;
    data['shirtNumber'] = this.shirtNumber;
    data['thirdPlayerPicUrl'] = this.thirdPlayerPicUrl;
    return data;
  }
}
