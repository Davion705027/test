class AnalyzeArrayPersonEntity {
  String? homeFormation;
  String? awayFormation;
  List<Up>? up;
  List<Up>? down;

  AnalyzeArrayPersonEntity({this.homeFormation, this.up, this.down});

  AnalyzeArrayPersonEntity.fromJson(Map<String, dynamic> json) {
    homeFormation = json['homeFormation'];
    awayFormation = json['awayFormation'];

    if (json['up'] != null) {
      up = <Up>[];
      json['up'].forEach((v) {
        up!.add(new Up.fromJson(v));
      });
    }
    if (json['down'] != null) {
      down = <Up>[];
      json['down'].forEach((v) {
        down!.add(new Up.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homeFormation'] = this.homeFormation;
    data['awayFormation'] = this.awayFormation;
    if (this.up != null) {
      data['up'] = this.up!.map((v) => v.toJson()).toList();
    }
    if (this.down != null) {
      data['down'] = this.down!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Up {
  String? awayFormation;
  String? createTime;
  String? dataSourceCode;
  num? homeAway;
  String? homeFormation;
  String? id;
  num? invalid;
  String? matchInfoId;
  String? modifyTime;
  num? position;
  String? positionEnName;
  String? positionName;
  num? shirtNumber;
  String? sportId;
  num? substitute;
  String? thirdPlayerEnName;
  String? thirdPlayerName;
  String? thirdPlayerPicUrl;
  String? thirdPlayerSourceId;
  String? thirdTeamSourceId;

  Up(
      {this.awayFormation,
        this.createTime,
        this.dataSourceCode,
        this.homeAway,
        this.homeFormation,
        this.id,
        this.invalid,
        this.matchInfoId,
        this.modifyTime,
        this.position,
        this.positionEnName,
        this.positionName,
        this.shirtNumber,
        this.sportId,
        this.substitute,
        this.thirdPlayerEnName,
        this.thirdPlayerName,
        this.thirdPlayerPicUrl,
        this.thirdPlayerSourceId,
        this.thirdTeamSourceId});

  Up.fromJson(Map<String, dynamic> json) {
    awayFormation = json['awayFormation'];
    createTime = json['createTime'];
    dataSourceCode = json['dataSourceCode'];
    homeAway = json['homeAway'];
    homeFormation = json['homeFormation'];
    id = json['id'];
    invalid = json['invalid'];
    matchInfoId = json['matchInfoId'];
    modifyTime = json['modifyTime'];
    position = json['position'];
    positionEnName = json['positionEnName'];
    positionName = json['positionName'];
    shirtNumber = json['shirtNumber'];
    sportId = json['sportId'];
    substitute = json['substitute'];
    thirdPlayerEnName = json['thirdPlayerEnName'];
    thirdPlayerName = json['thirdPlayerName'];
    thirdPlayerPicUrl = json['thirdPlayerPicUrl'];
    thirdPlayerSourceId = json['thirdPlayerSourceId'];
    thirdTeamSourceId = json['thirdTeamSourceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['awayFormation'] = this.awayFormation;
    data['createTime'] = this.createTime;
    data['dataSourceCode'] = this.dataSourceCode;
    data['homeAway'] = this.homeAway;
    data['homeFormation'] = this.homeFormation;
    data['id'] = this.id;
    data['invalid'] = this.invalid;
    data['matchInfoId'] = this.matchInfoId;
    data['modifyTime'] = this.modifyTime;
    data['position'] = this.position;
    data['positionEnName'] = this.positionEnName;
    data['positionName'] = this.positionName;
    data['shirtNumber'] = this.shirtNumber;
    data['sportId'] = this.sportId;
    data['substitute'] = this.substitute;
    data['thirdPlayerEnName'] = this.thirdPlayerEnName;
    data['thirdPlayerName'] = this.thirdPlayerName;
    data['thirdPlayerPicUrl'] = this.thirdPlayerPicUrl;
    data['thirdPlayerSourceId'] = this.thirdPlayerSourceId;
    data['thirdTeamSourceId'] = this.thirdTeamSourceId;
    return data;
  }
}

