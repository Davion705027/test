class AnalyzeMatchHistoryBattleDTOMapEntity {
  String? coachBirthdate;
  num? coachGameCount;
  String? coachName;
  String? coachStyle;
  num? drawCount;
  num? homeAway;
  num? loseCount;
  String? score;
  num? winCount;

  AnalyzeMatchHistoryBattleDTOMapEntity(
      {this.coachBirthdate,
        this.coachGameCount,
        this.coachName,
        this.coachStyle,
        this.drawCount,
        this.homeAway,
        this.loseCount,
        this.score,
        this.winCount});

  AnalyzeMatchHistoryBattleDTOMapEntity.fromJson(Map<String, dynamic> json) {
    coachBirthdate = json['coachBirthdate'];
    coachGameCount = json['coachGameCount'];
    coachName = json['coachName'];
    coachStyle = json['coachStyle'];
    drawCount = json['drawCount'];
    homeAway = json['homeAway'];
    loseCount = json['loseCount'];
    score = json['score'];
    winCount = json['winCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coachBirthdate'] = this.coachBirthdate;
    data['coachGameCount'] = this.coachGameCount;
    data['coachName'] = this.coachName;
    data['coachStyle'] = this.coachStyle;
    data['drawCount'] = this.drawCount;
    data['homeAway'] = this.homeAway;
    data['loseCount'] = this.loseCount;
    data['score'] = this.score;
    data['winCount'] = this.winCount;
    return data;
  }
}
