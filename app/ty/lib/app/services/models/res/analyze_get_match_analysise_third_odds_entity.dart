class AnalyzeGetMatchAnalysiseThirdOddsEntity {
  String? bookName;
  List<HandicapOddsDTOList>? handicapOddsDTOList;

  AnalyzeGetMatchAnalysiseThirdOddsEntity(
      {this.bookName, this.handicapOddsDTOList});

  AnalyzeGetMatchAnalysiseThirdOddsEntity.fromJson(Map<String, dynamic> json) {
    bookName = json['bookName'];
    if (json['handicapOddsDTOList'] != null) {
      handicapOddsDTOList = <HandicapOddsDTOList>[];
      json['handicapOddsDTOList'].forEach((v) {
        handicapOddsDTOList!.add(new HandicapOddsDTOList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookName'] = this.bookName;
    if (this.handicapOddsDTOList != null) {
      data['handicapOddsDTOList'] =
          this.handicapOddsDTOList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HandicapOddsDTOList {
  num? active;
  Directions? directions;
  num? handicapVal;
  num? returnRate;
  String? type;
  num? value;
  num? value0;
  num? value0WinRate;
  num? valueWinRate;

  HandicapOddsDTOList(
      {this.active,
        this.directions,
        this.handicapVal,
        this.returnRate,
        this.type,
        this.value,
        this.value0,
        this.value0WinRate,
        this.valueWinRate});

  HandicapOddsDTOList.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    directions = json['directions'] != null
        ? new Directions.fromJson(json['directions'])
        : null;
    handicapVal = json['handicapVal'];
    returnRate = json['returnRate'];
    type = json['type'];
    value = json['value'];
    value0 = json['value0'];
    value0WinRate = json['value0WinRate'];
    valueWinRate = json['valueWinRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    if (this.directions != null) {
      data['directions'] = this.directions!.toJson();
    }
    data['handicapVal'] = this.handicapVal;
    data['returnRate'] = this.returnRate;
    data['type'] = this.type;
    data['value'] = this.value;
    data['value0'] = this.value0;
    data['value0WinRate'] = this.value0WinRate;
    data['valueWinRate'] = this.valueWinRate;
    return data;
  }
}

class Directions {
  num? value0;
  num? handicapVal;
  num? value;
  num?  returnRate;
  num?  value0WinRate;
  num?  valueWinRate;

  Directions({this.value0, this.handicapVal, this.value,this.returnRate,this.value0WinRate,this.valueWinRate});

  Directions.fromJson(Map<String, dynamic> json) {
    value0 = json['value0'];
    handicapVal = json['handicapVal'];
    value = json['value'];


    returnRate = json['returnRate'];
    value0WinRate = json['value0WinRate'];
    valueWinRate = json['valueWinRate'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value0'] = this.value0;
    data['handicapVal'] = this.handicapVal;
    data['value'] = this.value;

    data['returnRate'] = this.returnRate;
    data['value0WinRate'] = this.value0WinRate;
    data['valueWinRate'] = this.valueWinRate;
    return data;
  }
}
