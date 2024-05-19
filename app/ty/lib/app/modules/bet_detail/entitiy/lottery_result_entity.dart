import 'dart:convert';


class LotteryResultEntity {

	int? code;
	String? msg;
	String? sign;
	List<LotteryResultData>? data;
  
  LotteryResultEntity();


  @override
  String toString() {
    return jsonEncode(this);
  }
}

class JsonSerializable {
  const JsonSerializable();
}

class LotteryResultData {

	String? issue;
	String? code;
	dynamic codeStyle;
	String? saleStartTime;
	int? betStatus;

  LotteryResultData({this.issue,this.code,this.codeStyle,this.saleStartTime,this.betStatus});

  @override
  String toString() {
    return jsonEncode(this);
  }
}