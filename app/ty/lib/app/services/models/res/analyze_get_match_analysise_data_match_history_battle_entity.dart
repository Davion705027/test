class AnalyzeGetMatchAnalysiseDataMatchHistoryBattleEntity {
  List<num>? handicapResultList;
  List<MatchHistoryBattleDetailDTOList>? matchHistoryBattleDetailDTOList;
  List<num>? overunderResultList;

  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleEntity(
      {this.handicapResultList,
        this.matchHistoryBattleDetailDTOList,
        this.overunderResultList});

  AnalyzeGetMatchAnalysiseDataMatchHistoryBattleEntity.fromJson(
      Map<String, dynamic> json) {
    if (json['handicapResultList'] != null) {
      handicapResultList = (json['handicapResultList'] as List).map((e) => num.tryParse("$e")??0).toList();
    }

    if (json['matchHistoryBattleDetailDTOList'] != null) {
      matchHistoryBattleDetailDTOList = <MatchHistoryBattleDetailDTOList>[];
      json['matchHistoryBattleDetailDTOList'].forEach((v) {
        matchHistoryBattleDetailDTOList!
            .add(new MatchHistoryBattleDetailDTOList.fromJson(v));
      });
    }
    if (json['overunderResultList'] != null) {
      overunderResultList = (json['overunderResultList'] as List).map((e) => num.tryParse("$e")??0).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handicapResultList'] = this.handicapResultList;
    if (this.matchHistoryBattleDetailDTOList != null) {
      data['matchHistoryBattleDetailDTOList'] =
          this.matchHistoryBattleDetailDTOList!.map((v) => v.toJson()).toList();
    }
    data['overunderResultList'] = this.overunderResultList;
    return data;
  }
}

class MatchHistoryBattleDetailDTOList {
  num? handicapResultEqual;
  num? handicapResultLose;
  num? handicapResultWin;
  num? handicapResultWinRate;
  num? overunderResultEqual;
  num? overunderResultLose;
  num? overunderResultLoseRate;

  num? overunderResultWin;
  num? overunderResultWinRate;
  num? postionFlag;

  MatchHistoryBattleDetailDTOList(
      {this.handicapResultEqual,
        this.handicapResultLose,
        this.handicapResultWin,
        this.handicapResultWinRate,
        this.overunderResultEqual,
        this.overunderResultLose,
        this.overunderResultLoseRate,
        this.overunderResultWin,
        this.overunderResultWinRate,
        this.postionFlag});

  MatchHistoryBattleDetailDTOList.fromJson(Map<String, dynamic> json) {
    handicapResultEqual = json['handicapResultEqual'];
    handicapResultLose = json['handicapResultLose'];
    handicapResultWin = json['handicapResultWin'];
    handicapResultWinRate = json['handicapResultWinRate'];
    overunderResultEqual = json['overunderResultEqual'];
    overunderResultLose = json['overunderResultLose'];
    overunderResultLoseRate = json['overunderResultLoseRate'];
    overunderResultWin = json['overunderResultWin'];
    overunderResultWinRate = json['overunderResultWinRate'];
    postionFlag = json['postionFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handicapResultEqual'] = this.handicapResultEqual;
    data['handicapResultLose'] = this.handicapResultLose;
    data['handicapResultWin'] = this.handicapResultWin;
    data['handicapResultWinRate'] = this.handicapResultWinRate;
    data['overunderResultEqual'] = this.overunderResultEqual;
    data['overunderResultLose'] = this.overunderResultLose;
    data['overunderResultLoseRate'] = this.overunderResultLoseRate;
    data['overunderResultWin'] = this.overunderResultWin;
    data['overunderResultWinRate'] = this.overunderResultWinRate;
    data['postionFlag'] = this.postionFlag;
    return data;
  }
}
