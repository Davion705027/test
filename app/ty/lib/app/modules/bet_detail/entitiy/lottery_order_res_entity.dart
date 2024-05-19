import 'dart:convert';

import 'package:flutter_ty_app/generated/json/base/json_field.dart';


class LotteryOrderResEntity {
	int? code;
	String? msg;
	LotteryOrderResData? data;
	int? total;
	bool? sucess;

	@override
	String toString() {
		return jsonEncode(this);
	}
}

class LotteryOrderResData {
	int? total;
	int? totalPage;
	int? pageSize;
	int? currentPage;

	LotteryOrderResData();

	@override
	String toString() {
		return jsonEncode(this);
	}
}
