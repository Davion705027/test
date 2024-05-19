import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_h5_pre_bet_orderlist_entity.dart';

GetH5PreBetOrderlistEntity $GetH5PreBetOrderlistEntityFromJson(
    Map<String, dynamic> json) {
  final GetH5PreBetOrderlistEntity getH5PreBetOrderlistEntity = GetH5PreBetOrderlistEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getH5PreBetOrderlistEntity.code = code;
  }
  final GetH5PreBetOrderlistData? data = jsonConvert.convert<
      GetH5PreBetOrderlistData>(json['data']);
  if (data != null) {
    getH5PreBetOrderlistEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getH5PreBetOrderlistEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getH5PreBetOrderlistEntity.ts = ts;
  }
  return getH5PreBetOrderlistEntity;
}

Map<String, dynamic> $GetH5PreBetOrderlistEntityToJson(
    GetH5PreBetOrderlistEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetH5PreBetOrderlistEntityExtension on GetH5PreBetOrderlistEntity {
  GetH5PreBetOrderlistEntity copyWith({
    String? code,
    GetH5PreBetOrderlistData? data,
    String? msg,
    int? ts,
  }) {
    return GetH5PreBetOrderlistEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetH5PreBetOrderlistData $GetH5PreBetOrderlistDataFromJson(
    Map<String, dynamic> json) {
  final GetH5PreBetOrderlistData getH5PreBetOrderlistData = GetH5PreBetOrderlistData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getH5PreBetOrderlistData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getH5PreBetOrderlistData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getH5PreBetOrderlistData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getH5PreBetOrderlistData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getH5PreBetOrderlistData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getH5PreBetOrderlistData.hasPrevious = hasPrevious;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getH5PreBetOrderlistData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getH5PreBetOrderlistData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getH5PreBetOrderlistData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getH5PreBetOrderlistData.profit = profit;
  }
  final Map<String, GetH5PreBetOrderlistDataRecordx?>? record =
  (json['record'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e == null ? null : jsonConvert.convert<
          GetH5PreBetOrderlistDataRecordx>(e)));
  if (record != null) {
    getH5PreBetOrderlistData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getH5PreBetOrderlistData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getH5PreBetOrderlistData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getH5PreBetOrderlistData.size = size;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getH5PreBetOrderlistData.total = total;
  }
  return getH5PreBetOrderlistData;
}

Map<String, dynamic> $GetH5PreBetOrderlistDataToJson(
    GetH5PreBetOrderlistData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ascs'] = entity.ascs;
  data['betTotalAmount'] = entity.betTotalAmount;
  data['current'] = entity.current;
  data['descs'] = entity.descs;
  data['hasNext'] = entity.hasNext;
  data['hasPrevious'] = entity.hasPrevious;
  data['optimizeCountSql'] = entity.optimizeCountSql;
  data['pages'] = entity.pages;
  data['preBetTotalAmount'] = entity.preBetTotalAmount;
  data['profit'] = entity.profit;
  data['record'] = entity.record;
  data['records'] = entity.records;
  data['searchCount'] = entity.searchCount;
  data['size'] = entity.size;
  data['total'] = entity.total;
  return data;
}

extension GetH5PreBetOrderlistDataExtension on GetH5PreBetOrderlistData {
  GetH5PreBetOrderlistData copyWith({
    dynamic ascs,
    String? betTotalAmount,
    String? current,
    dynamic descs,
    bool? hasNext,
    bool? hasPrevious,
    bool? optimizeCountSql,
    String? pages,
    String? preBetTotalAmount,
    String? profit,
    Map<String, GetH5PreBetOrderlistDataRecordx?>? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? total,
  }) {
    return GetH5PreBetOrderlistData()
      ..ascs = ascs ?? this.ascs
      ..betTotalAmount = betTotalAmount ?? this.betTotalAmount
      ..current = current ?? this.current
      ..descs = descs ?? this.descs
      ..hasNext = hasNext ?? this.hasNext
      ..hasPrevious = hasPrevious ?? this.hasPrevious
      ..optimizeCountSql = optimizeCountSql ?? this.optimizeCountSql
      ..pages = pages ?? this.pages
      ..preBetTotalAmount = preBetTotalAmount ?? this.preBetTotalAmount
      ..profit = profit ?? this.profit
      ..record = record ?? this.record
      ..records = records ?? this.records
      ..searchCount = searchCount ?? this.searchCount
      ..size = size ?? this.size
      ..total = total ?? this.total;
  }
}

GetH5PreBetOrderlistDataRecordx $GetH5PreBetOrderlistDataRecordxFromJson(
    Map<String, dynamic> json) {
  final GetH5PreBetOrderlistDataRecordx getH5PreBetOrderlistDataRecordx = GetH5PreBetOrderlistDataRecordx();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getH5PreBetOrderlistDataRecordx.betAmount = betAmount;
  }
  final List<GetH5PreBetOrderlistDataRecordxData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetH5PreBetOrderlistDataRecordxData>(
          e) as GetH5PreBetOrderlistDataRecordxData).toList();
  if (data != null) {
    getH5PreBetOrderlistDataRecordx.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getH5PreBetOrderlistDataRecordx.totalOrders = totalOrders;
  }
  return getH5PreBetOrderlistDataRecordx;
}

Map<String, dynamic> $GetH5PreBetOrderlistDataRecordxToJson(
    GetH5PreBetOrderlistDataRecordx entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  return data;
}

extension GetH5PreBetOrderlistDataRecordxExtension on GetH5PreBetOrderlistDataRecordx {
  GetH5PreBetOrderlistDataRecordx copyWith({
    double? betAmount,
    List<GetH5PreBetOrderlistDataRecordxData>? data,
    int? totalOrders,
  }) {
    return GetH5PreBetOrderlistDataRecordx()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders;
  }
}

GetH5PreBetOrderlistDataRecordxData $GetH5PreBetOrderlistDataRecordxDataFromJson(
    Map<String, dynamic> json) {
  final GetH5PreBetOrderlistDataRecordxData getH5PreBetOrderlistDataRecordxData = GetH5PreBetOrderlistDataRecordxData();
  final bool? canBeModified = jsonConvert.convert<bool>(json['canBeModified']);
  if (canBeModified != null) {
    getH5PreBetOrderlistDataRecordxData.canBeModified = canBeModified;
  }
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getH5PreBetOrderlistDataRecordxData.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getH5PreBetOrderlistDataRecordxData.addition = addition;
  }
  final dynamic backAmount = json['backAmount'];
  if (backAmount != null) {
    getH5PreBetOrderlistDataRecordxData.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getH5PreBetOrderlistDataRecordxData.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getH5PreBetOrderlistDataRecordxData.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getH5PreBetOrderlistDataRecordxData.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getH5PreBetOrderlistDataRecordxData.betTimeStr = betTimeStr;
  }
  final List<
      GetH5PreBetOrderlistDataRecordxDataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<
          GetH5PreBetOrderlistDataRecordxDataDetailList>(
          e) as GetH5PreBetOrderlistDataRecordxDataDetailList).toList();
  if (detailList != null) {
    getH5PreBetOrderlistDataRecordxData.detailList = detailList;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getH5PreBetOrderlistDataRecordxData.id = id;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getH5PreBetOrderlistDataRecordxData.langCode = langCode;
  }
  final dynamic managerCode = json['managerCode'];
  if (managerCode != null) {
    getH5PreBetOrderlistDataRecordxData.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getH5PreBetOrderlistDataRecordxData.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getH5PreBetOrderlistDataRecordxData.matchType = matchType;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getH5PreBetOrderlistDataRecordxData.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getH5PreBetOrderlistDataRecordxData.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getH5PreBetOrderlistDataRecordxData.modifyTimeStr = modifyTimeStr;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getH5PreBetOrderlistDataRecordxData.orderAmountTotal = orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getH5PreBetOrderlistDataRecordxData.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getH5PreBetOrderlistDataRecordxData.orderStatus = orderStatus;
  }
  final dynamic outcome = json['outcome'];
  if (outcome != null) {
    getH5PreBetOrderlistDataRecordxData.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getH5PreBetOrderlistDataRecordxData.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getH5PreBetOrderlistDataRecordxData.preOrder = preOrder;
  }
  final int? preOrderStatus = jsonConvert.convert<int>(json['preOrderStatus']);
  if (preOrderStatus != null) {
    getH5PreBetOrderlistDataRecordxData.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getH5PreBetOrderlistDataRecordxData.preOrderVoList = preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getH5PreBetOrderlistDataRecordxData.preSettle = preSettle;
  }
  final dynamic profitAmount = json['profitAmount'];
  if (profitAmount != null) {
    getH5PreBetOrderlistDataRecordxData.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getH5PreBetOrderlistDataRecordxData.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getH5PreBetOrderlistDataRecordxData.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getH5PreBetOrderlistDataRecordxData.seriesValue = seriesValue;
  }
  final dynamic settleTime = json['settleTime'];
  if (settleTime != null) {
    getH5PreBetOrderlistDataRecordxData.settleTime = settleTime;
  }
  final dynamic settleType = json['settleType'];
  if (settleType != null) {
    getH5PreBetOrderlistDataRecordxData.settleType = settleType;
  }
  final dynamic settledAmount = json['settledAmount'];
  if (settledAmount != null) {
    getH5PreBetOrderlistDataRecordxData.settledAmount = settledAmount;
  }
  return getH5PreBetOrderlistDataRecordxData;
}

Map<String, dynamic> $GetH5PreBetOrderlistDataRecordxDataToJson(
    GetH5PreBetOrderlistDataRecordxData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['canBeModified'] = entity.canBeModified;
  data['acCode'] = entity.acCode;
  data['addition'] = entity.addition;
  data['backAmount'] = entity.backAmount;
  data['beginTime'] = entity.beginTime;
  data['beginTimeStr'] = entity.beginTimeStr;
  data['betTime'] = entity.betTime;
  data['betTimeStr'] = entity.betTimeStr;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['id'] = entity.id;
  data['langCode'] = entity.langCode;
  data['managerCode'] = entity.managerCode;
  data['marketType'] = entity.marketType;
  data['matchType'] = entity.matchType;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['modifyTime'] = entity.modifyTime;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['outcome'] = entity.outcome;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrder'] = entity.preOrder;
  data['preOrderStatus'] = entity.preOrderStatus;
  data['preOrderVoList'] = entity.preOrderVoList;
  data['preSettle'] = entity.preSettle;
  data['profitAmount'] = entity.profitAmount;
  data['seriesSum'] = entity.seriesSum;
  data['seriesType'] = entity.seriesType;
  data['seriesValue'] = entity.seriesValue;
  data['settleTime'] = entity.settleTime;
  data['settleType'] = entity.settleType;
  data['settledAmount'] = entity.settledAmount;
  return data;
}

extension GetH5PreBetOrderlistDataRecordxDataExtension on GetH5PreBetOrderlistDataRecordxData {
  GetH5PreBetOrderlistDataRecordxData copyWith({
    bool? canBeModified,
    String? acCode,
    int? addition,
    dynamic backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetH5PreBetOrderlistDataRecordxDataDetailList>? detailList,
    String? id,
    String? langCode,
    dynamic managerCode,
    String? marketType,
    dynamic matchType,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    dynamic outcome,
    dynamic preBetAmount,
    dynamic preOrder,
    int? preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    dynamic settleTime,
    dynamic settleType,
    dynamic settledAmount,
  }) {
    return GetH5PreBetOrderlistDataRecordxData()
      ..canBeModified = canBeModified ?? this.canBeModified
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..detailList = detailList ?? this.detailList
      ..id = id ?? this.id
      ..langCode = langCode ?? this.langCode
      ..managerCode = managerCode ?? this.managerCode
      ..marketType = marketType ?? this.marketType
      ..matchType = matchType ?? this.matchType
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..outcome = outcome ?? this.outcome
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrder = preOrder ?? this.preOrder
      ..preOrderStatus = preOrderStatus ?? this.preOrderStatus
      ..preOrderVoList = preOrderVoList ?? this.preOrderVoList
      ..preSettle = preSettle ?? this.preSettle
      ..profitAmount = profitAmount ?? this.profitAmount
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesType = seriesType ?? this.seriesType
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleTime = settleTime ?? this.settleTime
      ..settleType = settleType ?? this.settleType
      ..settledAmount = settledAmount ?? this.settledAmount;
  }
}

GetH5PreBetOrderlistDataRecordxDataDetailList $GetH5PreBetOrderlistDataRecordxDataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetH5PreBetOrderlistDataRecordxDataDetailList getH5PreBetOrderlistDataRecordxDataDetailList = GetH5PreBetOrderlistDataRecordxDataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.acceptBetOdds = acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.cancelType = cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.childPlayId = childPlayId;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.closingTime = closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.createTime = createTime;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.marketValue = marketValue;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.matchInfo = matchInfo;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.matchName = matchName;
  }
  final dynamic matchOver = json['matchOver'];
  if (matchOver != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.matchOver = matchOver;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.matchStatusId = matchStatusId;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.matchType = matchType;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.oddFinally = oddFinally;
  }
  final String? oddFinallyChange = jsonConvert.convert<String>(
      json['oddFinallyChange']);
  if (oddFinallyChange != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.oddFinallyChange =
        oddFinallyChange;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.optionValue = optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.orderAmountTotal =
        orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.orderNo = orderNo;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.outrightYear = outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.playOptionName =
        playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.playOptions = playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.playOptionsId = playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.playOptionsRange =
        playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.scoreBenchmark =
        scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.secondNum = secondNum;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.settleScore = settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.startTime = startTime;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.tournamentId = tournamentId;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.tournamentPic = tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getH5PreBetOrderlistDataRecordxDataDetailList.userId = userId;
  }
  return getH5PreBetOrderlistDataRecordxDataDetailList;
}

Map<String, dynamic> $GetH5PreBetOrderlistDataRecordxDataDetailListToJson(
    GetH5PreBetOrderlistDataRecordxDataDetailList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['acceptBetOdds'] = entity.acceptBetOdds;
  data['awayName'] = entity.awayName;
  data['backAmount'] = entity.backAmount;
  data['batchNo'] = entity.batchNo;
  data['beginTime'] = entity.beginTime;
  data['betAmount'] = entity.betAmount;
  data['betNo'] = entity.betNo;
  data['betResult'] = entity.betResult;
  data['betStatus'] = entity.betStatus;
  data['betTime'] = entity.betTime;
  data['cancelType'] = entity.cancelType;
  data['childPlayId'] = entity.childPlayId;
  data['closingTime'] = entity.closingTime;
  data['createTime'] = entity.createTime;
  data['firstNum'] = entity.firstNum;
  data['homeName'] = entity.homeName;
  data['isValid'] = entity.isValid;
  data['marketId'] = entity.marketId;
  data['marketName'] = entity.marketName;
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['matchId'] = entity.matchId;
  data['matchInfo'] = entity.matchInfo;
  data['matchName'] = entity.matchName;
  data['matchOver'] = entity.matchOver;
  data['matchStatusId'] = entity.matchStatusId;
  data['matchType'] = entity.matchType;
  data['oddFinally'] = entity.oddFinally;
  data['oddFinallyChange'] = entity.oddFinallyChange;
  data['oddsValue'] = entity.oddsValue;
  data['optionValue'] = entity.optionValue;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['outrightYear'] = entity.outrightYear;
  data['phase'] = entity.phase;
  data['placeNum'] = entity.placeNum;
  data['playId'] = entity.playId;
  data['playName'] = entity.playName;
  data['playOptionName'] = entity.playOptionName;
  data['playOptions'] = entity.playOptions;
  data['playOptionsId'] = entity.playOptionsId;
  data['playOptionsRange'] = entity.playOptionsRange;
  data['remark'] = entity.remark;
  data['riskEvent'] = entity.riskEvent;
  data['score'] = entity.score;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['secondNum'] = entity.secondNum;
  data['settleScore'] = entity.settleScore;
  data['sportId'] = entity.sportId;
  data['sportName'] = entity.sportName;
  data['startTime'] = entity.startTime;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentPic'] = entity.tournamentPic;
  data['uid'] = entity.uid;
  data['userId'] = entity.userId;
  return data;
}

extension GetH5PreBetOrderlistDataRecordxDataDetailListExtension on GetH5PreBetOrderlistDataRecordxDataDetailList {
  GetH5PreBetOrderlistDataRecordxDataDetailList copyWith({
    dynamic acceptBetOdds,
    String? awayName,
    String? backAmount,
    String? batchNo,
    String? beginTime,
    String? betAmount,
    String? betNo,
    int? betResult,
    int? betStatus,
    dynamic betTime,
    int? cancelType,
    dynamic childPlayId,
    dynamic closingTime,
    dynamic createTime,
    dynamic firstNum,
    String? homeName,
    dynamic isValid,
    String? marketId,
    String? marketName,
    String? marketType,
    String? marketValue,
    String? matchId,
    String? matchInfo,
    String? matchName,
    dynamic matchOver,
    dynamic matchStatusId,
    int? matchType,
    String? oddFinally,
    String? oddFinallyChange,
    double? oddsValue,
    String? optionValue,
    String? orderAmountTotal,
    String? orderNo,
    String? outrightYear,
    String? phase,
    dynamic placeNum,
    int? playId,
    String? playName,
    String? playOptionName,
    String? playOptions,
    String? playOptionsId,
    String? playOptionsRange,
    String? remark,
    String? riskEvent,
    String? score,
    String? scoreBenchmark,
    dynamic secondNum,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    String? tournamentId,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetH5PreBetOrderlistDataRecordxDataDetailList()
      ..acceptBetOdds = acceptBetOdds ?? this.acceptBetOdds
      ..awayName = awayName ?? this.awayName
      ..backAmount = backAmount ?? this.backAmount
      ..batchNo = batchNo ?? this.batchNo
      ..beginTime = beginTime ?? this.beginTime
      ..betAmount = betAmount ?? this.betAmount
      ..betNo = betNo ?? this.betNo
      ..betResult = betResult ?? this.betResult
      ..betStatus = betStatus ?? this.betStatus
      ..betTime = betTime ?? this.betTime
      ..cancelType = cancelType ?? this.cancelType
      ..childPlayId = childPlayId ?? this.childPlayId
      ..closingTime = closingTime ?? this.closingTime
      ..createTime = createTime ?? this.createTime
      ..firstNum = firstNum ?? this.firstNum
      ..homeName = homeName ?? this.homeName
      ..isValid = isValid ?? this.isValid
      ..marketId = marketId ?? this.marketId
      ..marketName = marketName ?? this.marketName
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..matchId = matchId ?? this.matchId
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchName = matchName ?? this.matchName
      ..matchOver = matchOver ?? this.matchOver
      ..matchStatusId = matchStatusId ?? this.matchStatusId
      ..matchType = matchType ?? this.matchType
      ..oddFinally = oddFinally ?? this.oddFinally
      ..oddFinallyChange = oddFinallyChange ?? this.oddFinallyChange
      ..oddsValue = oddsValue ?? this.oddsValue
      ..optionValue = optionValue ?? this.optionValue
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..outrightYear = outrightYear ?? this.outrightYear
      ..phase = phase ?? this.phase
      ..placeNum = placeNum ?? this.placeNum
      ..playId = playId ?? this.playId
      ..playName = playName ?? this.playName
      ..playOptionName = playOptionName ?? this.playOptionName
      ..playOptions = playOptions ?? this.playOptions
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..playOptionsRange = playOptionsRange ?? this.playOptionsRange
      ..remark = remark ?? this.remark
      ..riskEvent = riskEvent ?? this.riskEvent
      ..score = score ?? this.score
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..secondNum = secondNum ?? this.secondNum
      ..settleScore = settleScore ?? this.settleScore
      ..sportId = sportId ?? this.sportId
      ..sportName = sportName ?? this.sportName
      ..startTime = startTime ?? this.startTime
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentPic = tournamentPic ?? this.tournamentPic
      ..uid = uid ?? this.uid
      ..userId = userId ?? this.userId;
  }
}