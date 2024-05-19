

class MatchResultsEntity {
  String? picUrl;
  String? sportId;
  String? tournamentName;
  String? scoreResult;
  String? tournamentId;
  String? playName;
  String? sportName;
  String? matchTime;
  String? matchId;
  String? marketId;

  MatchResultsEntity(
      {this.picUrl,
        this.sportId,
        this.tournamentName,
        this.scoreResult,
        this.tournamentId,
        this.playName,
        this.sportName,
        this.matchTime,
        this.matchId,
        this.marketId});

  MatchResultsEntity.fromJson(Map<String, dynamic> json) {
    picUrl = json['picUrl'];
    sportId = json['sportId'];
    tournamentName = json['tournamentName'];
    scoreResult = json['scoreResult'];
    tournamentId = json['tournamentId'];
    playName = json['playName'];
    sportName = json['sportName'];
    matchTime = json['matchTime'];
    matchId = json['matchId'];
    marketId = json['marketId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picUrl'] = this.picUrl;
    data['sportId'] = this.sportId;
    data['tournamentName'] = this.tournamentName;
    data['scoreResult'] = this.scoreResult;
    data['tournamentId'] = this.tournamentId;
    data['playName'] = this.playName;
    data['sportName'] = this.sportName;
    data['matchTime'] = this.matchTime;
    data['matchId'] = this.matchId;
    data['marketId'] = this.marketId;
    return data;
  }
}
