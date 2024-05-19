import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/get_h5_order_list_entity.dart';

GetH5OrderListEntity $GetH5OrderListEntityFromJson(Map<String, dynamic> json) {
  final GetH5OrderListEntity getH5OrderListEntity = GetH5OrderListEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    getH5OrderListEntity.code = code;
  }
  final GetH5OrderListData? data = jsonConvert.convert<GetH5OrderListData>(
      json['data']);
  if (data != null) {
    getH5OrderListEntity.data = data;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    getH5OrderListEntity.msg = msg;
  }
  final int? ts = jsonConvert.convert<int>(json['ts']);
  if (ts != null) {
    getH5OrderListEntity.ts = ts;
  }
  return getH5OrderListEntity;
}

Map<String, dynamic> $GetH5OrderListEntityToJson(GetH5OrderListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data.toJson();
  data['msg'] = entity.msg;
  data['ts'] = entity.ts;
  return data;
}

extension GetH5OrderListEntityExtension on GetH5OrderListEntity {
  GetH5OrderListEntity copyWith({
    String? code,
    GetH5OrderListData? data,
    String? msg,
    int? ts,
  }) {
    return GetH5OrderListEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..msg = msg ?? this.msg
      ..ts = ts ?? this.ts;
  }
}

GetH5OrderListData $GetH5OrderListDataFromJson(Map<String, dynamic> json) {
  final GetH5OrderListData getH5OrderListData = GetH5OrderListData();
  final dynamic ascs = json['ascs'];
  if (ascs != null) {
    getH5OrderListData.ascs = ascs;
  }
  final String? betTotalAmount = jsonConvert.convert<String>(
      json['betTotalAmount']);
  if (betTotalAmount != null) {
    getH5OrderListData.betTotalAmount = betTotalAmount;
  }
  final String? current = jsonConvert.convert<String>(json['current']);
  if (current != null) {
    getH5OrderListData.current = current;
  }
  final dynamic descs = json['descs'];
  if (descs != null) {
    getH5OrderListData.descs = descs;
  }
  final bool? hasNext = jsonConvert.convert<bool>(json['hasNext']);
  if (hasNext != null) {
    getH5OrderListData.hasNext = hasNext;
  }
  final bool? hasPrevious = jsonConvert.convert<bool>(json['hasPrevious']);
  if (hasPrevious != null) {
    getH5OrderListData.hasPrevious = hasPrevious;
  }
  final bool? optimizeCountSql = jsonConvert.convert<bool>(
      json['optimizeCountSql']);
  if (optimizeCountSql != null) {
    getH5OrderListData.optimizeCountSql = optimizeCountSql;
  }
  final String? pages = jsonConvert.convert<String>(json['pages']);
  if (pages != null) {
    getH5OrderListData.pages = pages;
  }
  final String? preBetTotalAmount = jsonConvert.convert<String>(
      json['preBetTotalAmount']);
  if (preBetTotalAmount != null) {
    getH5OrderListData.preBetTotalAmount = preBetTotalAmount;
  }
  final String? profit = jsonConvert.convert<String>(json['profit']);
  if (profit != null) {
    getH5OrderListData.profit = profit;
  }
  final Map<String, GetH5OrderListDataRecordx?>? record =
  (json['record'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k,
          e == null ? null : jsonConvert.convert<GetH5OrderListDataRecordx>(
              e)));
  if (record != null) {
    getH5OrderListData.record = record;
  }
  final List<dynamic>? records = (json['records'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (records != null) {
    getH5OrderListData.records = records;
  }
  final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
  if (searchCount != null) {
    getH5OrderListData.searchCount = searchCount;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    getH5OrderListData.size = size;
  }
  final String? total = jsonConvert.convert<String>(json['total']);
  if (total != null) {
    getH5OrderListData.total = total;
  }
  return getH5OrderListData;
}

Map<String, dynamic> $GetH5OrderListDataToJson(GetH5OrderListData entity) {
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

extension GetH5OrderListDataExtension on GetH5OrderListData {
  GetH5OrderListData copyWith({
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
    Map<String, GetH5OrderListDataRecordx?>? record,
    List<dynamic>? records,
    bool? searchCount,
    String? size,
    String? total,
  }) {
    return GetH5OrderListData()
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

GetH5OrderListDataRecordx $GetH5OrderListDataRecordxFromJson(
    Map<String, dynamic> json) {
  final GetH5OrderListDataRecordx getH5OrderListDataRecordx = GetH5OrderListDataRecordx();
  final double? betAmount = jsonConvert.convert<double>(json['betAmount']);
  if (betAmount != null) {
    getH5OrderListDataRecordx.betAmount = betAmount;
  }
  final List<GetH5OrderListDataRecordxData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetH5OrderListDataRecordxData>(
          e) as GetH5OrderListDataRecordxData).toList();
  if (data != null) {
    getH5OrderListDataRecordx.data = data;
  }
  final int? totalOrders = jsonConvert.convert<int>(json['totalOrders']);
  if (totalOrders != null) {
    getH5OrderListDataRecordx.totalOrders = totalOrders;
  }
  final double? profit = jsonConvert.convert<double>(json['profit']);
  if (profit != null) {
    getH5OrderListDataRecordx.profit = profit;
  }
  return getH5OrderListDataRecordx;
}

Map<String, dynamic> $GetH5OrderListDataRecordxToJson(
    GetH5OrderListDataRecordx entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['betAmount'] = entity.betAmount;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  data['totalOrders'] = entity.totalOrders;
  data['profit'] = entity.profit;
  return data;
}

extension GetH5OrderListDataRecordxExtension on GetH5OrderListDataRecordx {
  GetH5OrderListDataRecordx copyWith({
    double? betAmount,
    List<GetH5OrderListDataRecordxData>? data,
    int? totalOrders,
    double? profit,
  }) {
    return GetH5OrderListDataRecordx()
      ..betAmount = betAmount ?? this.betAmount
      ..data = data ?? this.data
      ..totalOrders = totalOrders ?? this.totalOrders
      ..profit = profit ?? this.profit;
  }
}

GetH5OrderListDataRecordxData $GetH5OrderListDataRecordxDataFromJson(
    Map<String, dynamic> json) {
  final GetH5OrderListDataRecordxData getH5OrderListDataRecordxData = GetH5OrderListDataRecordxData();
  final bool? isExpand = jsonConvert.convert<bool>(json['isExpand']);
  if (isExpand != null) {
    getH5OrderListDataRecordxData.isExpand = isExpand;
  }
  final bool? preSettleExpand = jsonConvert.convert<bool>(
      json['preSettleExpand']);
  if (preSettleExpand != null) {
    getH5OrderListDataRecordxData.preSettleExpand = preSettleExpand;
  }
  final bool? turnOnEarlySettlement = jsonConvert.convert<bool>(
      json['turnOnEarlySettlement']);
  if (turnOnEarlySettlement != null) {
    getH5OrderListDataRecordxData.turnOnEarlySettlement = turnOnEarlySettlement;
  }
  final bool? exhibitEarlySettlement = jsonConvert.convert<bool>(
      json['exhibitEarlySettlement']);
  if (exhibitEarlySettlement != null) {
    getH5OrderListDataRecordxData.exhibitEarlySettlement =
        exhibitEarlySettlement;
  }
  final bool? earlySettlementBeingRequested = jsonConvert.convert<bool>(
      json['earlySettlementBeingRequested']);
  if (earlySettlementBeingRequested != null) {
    getH5OrderListDataRecordxData.earlySettlementBeingRequested =
        earlySettlementBeingRequested;
  }
  final int? earlySettlementSuccessfulType = jsonConvert.convert<int>(
      json['earlySettlementSuccessfulType']);
  if (earlySettlementSuccessfulType != null) {
    getH5OrderListDataRecordxData.earlySettlementSuccessfulType =
        earlySettlementSuccessfulType;
  }
  final String? acCode = jsonConvert.convert<String>(json['acCode']);
  if (acCode != null) {
    getH5OrderListDataRecordxData.acCode = acCode;
  }
  final int? addition = jsonConvert.convert<int>(json['addition']);
  if (addition != null) {
    getH5OrderListDataRecordxData.addition = addition;
  }
  final double? backAmount = jsonConvert.convert<double>(json['backAmount']);
  if (backAmount != null) {
    getH5OrderListDataRecordxData.backAmount = backAmount;
  }
  final dynamic beginTime = json['beginTime'];
  if (beginTime != null) {
    getH5OrderListDataRecordxData.beginTime = beginTime;
  }
  final String? beginTimeStr = jsonConvert.convert<String>(
      json['beginTimeStr']);
  if (beginTimeStr != null) {
    getH5OrderListDataRecordxData.beginTimeStr = beginTimeStr;
  }
  final String? betTime = jsonConvert.convert<String>(json['betTime']);
  if (betTime != null) {
    getH5OrderListDataRecordxData.betTime = betTime;
  }
  final String? betTimeStr = jsonConvert.convert<String>(json['betTimeStr']);
  if (betTimeStr != null) {
    getH5OrderListDataRecordxData.betTimeStr = betTimeStr;
  }
  final List<
      GetH5OrderListDataRecordxDataDetailList>? detailList = (json['detailList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetH5OrderListDataRecordxDataDetailList>(
          e) as GetH5OrderListDataRecordxDataDetailList).toList();
  if (detailList != null) {
    getH5OrderListDataRecordxData.detailList = detailList;
  }
  final bool? enablePreSettle = jsonConvert.convert<bool>(
      json['enablePreSettle']);
  if (enablePreSettle != null) {
    getH5OrderListDataRecordxData.enablePreSettle = enablePreSettle;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    getH5OrderListDataRecordxData.id = id;
  }
  final bool? initPresettleWs = jsonConvert.convert<bool>(
      json['initPresettleWs']);
  if (initPresettleWs != null) {
    getH5OrderListDataRecordxData.initPresettleWs = initPresettleWs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getH5OrderListDataRecordxData.langCode = langCode;
  }
  final int? managerCode = jsonConvert.convert<int>(json['managerCode']);
  if (managerCode != null) {
    getH5OrderListDataRecordxData.managerCode = managerCode;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getH5OrderListDataRecordxData.marketType = marketType;
  }
  final dynamic matchType = json['matchType'];
  if (matchType != null) {
    getH5OrderListDataRecordxData.matchType = matchType;
  }
  final dynamic maxCashout = json['maxCashout'];
  if (maxCashout != null) {
    getH5OrderListDataRecordxData.maxCashout = maxCashout;
  }
  final double? maxWinAmount = jsonConvert.convert<double>(
      json['maxWinAmount']);
  if (maxWinAmount != null) {
    getH5OrderListDataRecordxData.maxWinAmount = maxWinAmount;
  }
  final String? modifyTime = jsonConvert.convert<String>(json['modifyTime']);
  if (modifyTime != null) {
    getH5OrderListDataRecordxData.modifyTime = modifyTime;
  }
  final String? modifyTimeStr = jsonConvert.convert<String>(
      json['modifyTimeStr']);
  if (modifyTimeStr != null) {
    getH5OrderListDataRecordxData.modifyTimeStr = modifyTimeStr;
  }
  final double? orderAmountTotal = jsonConvert.convert<double>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getH5OrderListDataRecordxData.orderAmountTotal = orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getH5OrderListDataRecordxData.orderNo = orderNo;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['orderStatus']);
  if (orderStatus != null) {
    getH5OrderListDataRecordxData.orderStatus = orderStatus;
  }
  final List<
      GetH5OrderListDataRecordxDataOrderVOS>? orderVOS = (json['orderVOS'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<GetH5OrderListDataRecordxDataOrderVOS>(
          e) as GetH5OrderListDataRecordxDataOrderVOS).toList();
  if (orderVOS != null) {
    getH5OrderListDataRecordxData.orderVOS = orderVOS;
  }
  final int? outcome = jsonConvert.convert<int>(json['outcome']);
  if (outcome != null) {
    getH5OrderListDataRecordxData.outcome = outcome;
  }
  final dynamic preBetAmount = json['preBetAmount'];
  if (preBetAmount != null) {
    getH5OrderListDataRecordxData.preBetAmount = preBetAmount;
  }
  final dynamic preOrder = json['preOrder'];
  if (preOrder != null) {
    getH5OrderListDataRecordxData.preOrder = preOrder;
  }
  final dynamic preOrderStatus = json['preOrderStatus'];
  if (preOrderStatus != null) {
    getH5OrderListDataRecordxData.preOrderStatus = preOrderStatus;
  }
  final dynamic preOrderVoList = json['preOrderVoList'];
  if (preOrderVoList != null) {
    getH5OrderListDataRecordxData.preOrderVoList = preOrderVoList;
  }
  final dynamic preSettle = json['preSettle'];
  if (preSettle != null) {
    getH5OrderListDataRecordxData.preSettle = preSettle;
  }
  final dynamic preSettleBetAmount = json['preSettleBetAmount'];
  if (preSettleBetAmount != null) {
    getH5OrderListDataRecordxData.preSettleBetAmount = preSettleBetAmount;
  }
  final double? profitAmount = jsonConvert.convert<double>(
      json['profitAmount']);
  if (profitAmount != null) {
    getH5OrderListDataRecordxData.profitAmount = profitAmount;
  }
  final int? seriesSum = jsonConvert.convert<int>(json['seriesSum']);
  if (seriesSum != null) {
    getH5OrderListDataRecordxData.seriesSum = seriesSum;
  }
  final String? seriesType = jsonConvert.convert<String>(json['seriesType']);
  if (seriesType != null) {
    getH5OrderListDataRecordxData.seriesType = seriesType;
  }
  final String? seriesValue = jsonConvert.convert<String>(json['seriesValue']);
  if (seriesValue != null) {
    getH5OrderListDataRecordxData.seriesValue = seriesValue;
  }
  final String? settleTime = jsonConvert.convert<String>(json['settleTime']);
  if (settleTime != null) {
    getH5OrderListDataRecordxData.settleTime = settleTime;
  }
  final int? settleType = jsonConvert.convert<int>(json['settleType']);
  if (settleType != null) {
    getH5OrderListDataRecordxData.settleType = settleType;
  }
  final double? settledAmount = jsonConvert.convert<double>(
      json['settledAmount']);
  if (settledAmount != null) {
    getH5OrderListDataRecordxData.settledAmount = settledAmount;
  }
  return getH5OrderListDataRecordxData;
}

Map<String, dynamic> $GetH5OrderListDataRecordxDataToJson(
    GetH5OrderListDataRecordxData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['isExpand'] = entity.isExpand;
  data['preSettleExpand'] = entity.preSettleExpand;
  data['turnOnEarlySettlement'] = entity.turnOnEarlySettlement;
  data['exhibitEarlySettlement'] = entity.exhibitEarlySettlement;
  data['earlySettlementBeingRequested'] = entity.earlySettlementBeingRequested;
  data['earlySettlementSuccessfulType'] = entity.earlySettlementSuccessfulType;
  data['acCode'] = entity.acCode;
  data['addition'] = entity.addition;
  data['backAmount'] = entity.backAmount;
  data['beginTime'] = entity.beginTime;
  data['beginTimeStr'] = entity.beginTimeStr;
  data['betTime'] = entity.betTime;
  data['betTimeStr'] = entity.betTimeStr;
  data['detailList'] = entity.detailList.map((v) => v.toJson()).toList();
  data['enablePreSettle'] = entity.enablePreSettle;
  data['id'] = entity.id;
  data['initPresettleWs'] = entity.initPresettleWs;
  data['langCode'] = entity.langCode;
  data['managerCode'] = entity.managerCode;
  data['marketType'] = entity.marketType;
  data['matchType'] = entity.matchType;
  data['maxCashout'] = entity.maxCashout;
  data['maxWinAmount'] = entity.maxWinAmount;
  data['modifyTime'] = entity.modifyTime;
  data['modifyTimeStr'] = entity.modifyTimeStr;
  data['orderAmountTotal'] = entity.orderAmountTotal;
  data['orderNo'] = entity.orderNo;
  data['orderStatus'] = entity.orderStatus;
  data['orderVOS'] = entity.orderVOS.map((v) => v.toJson()).toList();
  data['outcome'] = entity.outcome;
  data['preBetAmount'] = entity.preBetAmount;
  data['preOrder'] = entity.preOrder;
  data['preOrderStatus'] = entity.preOrderStatus;
  data['preOrderVoList'] = entity.preOrderVoList;
  data['preSettle'] = entity.preSettle;
  data['preSettleBetAmount'] = entity.preSettleBetAmount;
  data['profitAmount'] = entity.profitAmount;
  data['seriesSum'] = entity.seriesSum;
  data['seriesType'] = entity.seriesType;
  data['seriesValue'] = entity.seriesValue;
  data['settleTime'] = entity.settleTime;
  data['settleType'] = entity.settleType;
  data['settledAmount'] = entity.settledAmount;
  return data;
}

extension GetH5OrderListDataRecordxDataExtension on GetH5OrderListDataRecordxData {
  GetH5OrderListDataRecordxData copyWith({
    bool? isExpand,
    bool? preSettleExpand,
    bool? turnOnEarlySettlement,
    bool? exhibitEarlySettlement,
    bool? earlySettlementBeingRequested,
    int? earlySettlementSuccessfulType,
    String? acCode,
    int? addition,
    double? backAmount,
    dynamic beginTime,
    String? beginTimeStr,
    String? betTime,
    String? betTimeStr,
    List<GetH5OrderListDataRecordxDataDetailList>? detailList,
    bool? enablePreSettle,
    String? id,
    bool? initPresettleWs,
    String? langCode,
    int? managerCode,
    String? marketType,
    dynamic matchType,
    dynamic maxCashout,
    double? maxWinAmount,
    String? modifyTime,
    String? modifyTimeStr,
    double? orderAmountTotal,
    String? orderNo,
    String? orderStatus,
    List<GetH5OrderListDataRecordxDataOrderVOS>? orderVOS,
    int? outcome,
    dynamic preBetAmount,
    dynamic preOrder,
    dynamic preOrderStatus,
    dynamic preOrderVoList,
    dynamic preSettle,
    dynamic preSettleBetAmount,
    double? profitAmount,
    int? seriesSum,
    String? seriesType,
    String? seriesValue,
    String? settleTime,
    int? settleType,
    double? settledAmount,
  }) {
    return GetH5OrderListDataRecordxData()
      ..isExpand = isExpand ?? this.isExpand
      ..preSettleExpand = preSettleExpand ?? this.preSettleExpand
      ..turnOnEarlySettlement = turnOnEarlySettlement ??
          this.turnOnEarlySettlement
      ..exhibitEarlySettlement = exhibitEarlySettlement ??
          this.exhibitEarlySettlement
      ..earlySettlementBeingRequested = earlySettlementBeingRequested ??
          this.earlySettlementBeingRequested
      ..earlySettlementSuccessfulType = earlySettlementSuccessfulType ??
          this.earlySettlementSuccessfulType
      ..acCode = acCode ?? this.acCode
      ..addition = addition ?? this.addition
      ..backAmount = backAmount ?? this.backAmount
      ..beginTime = beginTime ?? this.beginTime
      ..beginTimeStr = beginTimeStr ?? this.beginTimeStr
      ..betTime = betTime ?? this.betTime
      ..betTimeStr = betTimeStr ?? this.betTimeStr
      ..detailList = detailList ?? this.detailList
      ..enablePreSettle = enablePreSettle ?? this.enablePreSettle
      ..id = id ?? this.id
      ..initPresettleWs = initPresettleWs ?? this.initPresettleWs
      ..langCode = langCode ?? this.langCode
      ..managerCode = managerCode ?? this.managerCode
      ..marketType = marketType ?? this.marketType
      ..matchType = matchType ?? this.matchType
      ..maxCashout = maxCashout ?? this.maxCashout
      ..maxWinAmount = maxWinAmount ?? this.maxWinAmount
      ..modifyTime = modifyTime ?? this.modifyTime
      ..modifyTimeStr = modifyTimeStr ?? this.modifyTimeStr
      ..orderAmountTotal = orderAmountTotal ?? this.orderAmountTotal
      ..orderNo = orderNo ?? this.orderNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..orderVOS = orderVOS ?? this.orderVOS
      ..outcome = outcome ?? this.outcome
      ..preBetAmount = preBetAmount ?? this.preBetAmount
      ..preOrder = preOrder ?? this.preOrder
      ..preOrderStatus = preOrderStatus ?? this.preOrderStatus
      ..preOrderVoList = preOrderVoList ?? this.preOrderVoList
      ..preSettle = preSettle ?? this.preSettle
      ..preSettleBetAmount = preSettleBetAmount ?? this.preSettleBetAmount
      ..profitAmount = profitAmount ?? this.profitAmount
      ..seriesSum = seriesSum ?? this.seriesSum
      ..seriesType = seriesType ?? this.seriesType
      ..seriesValue = seriesValue ?? this.seriesValue
      ..settleTime = settleTime ?? this.settleTime
      ..settleType = settleType ?? this.settleType
      ..settledAmount = settledAmount ?? this.settledAmount;
  }
}

GetH5OrderListDataRecordxDataDetailList $GetH5OrderListDataRecordxDataDetailListFromJson(
    Map<String, dynamic> json) {
  final GetH5OrderListDataRecordxDataDetailList getH5OrderListDataRecordxDataDetailList = GetH5OrderListDataRecordxDataDetailList();
  final dynamic acceptBetOdds = json['acceptBetOdds'];
  if (acceptBetOdds != null) {
    getH5OrderListDataRecordxDataDetailList.acceptBetOdds = acceptBetOdds;
  }
  final String? awayName = jsonConvert.convert<String>(json['awayName']);
  if (awayName != null) {
    getH5OrderListDataRecordxDataDetailList.awayName = awayName;
  }
  final String? backAmount = jsonConvert.convert<String>(json['backAmount']);
  if (backAmount != null) {
    getH5OrderListDataRecordxDataDetailList.backAmount = backAmount;
  }
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getH5OrderListDataRecordxDataDetailList.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getH5OrderListDataRecordxDataDetailList.beginTime = beginTime;
  }
  final String? betAmount = jsonConvert.convert<String>(json['betAmount']);
  if (betAmount != null) {
    getH5OrderListDataRecordxDataDetailList.betAmount = betAmount;
  }
  final String? betNo = jsonConvert.convert<String>(json['betNo']);
  if (betNo != null) {
    getH5OrderListDataRecordxDataDetailList.betNo = betNo;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getH5OrderListDataRecordxDataDetailList.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getH5OrderListDataRecordxDataDetailList.betStatus = betStatus;
  }
  final dynamic betTime = json['betTime'];
  if (betTime != null) {
    getH5OrderListDataRecordxDataDetailList.betTime = betTime;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getH5OrderListDataRecordxDataDetailList.cancelType = cancelType;
  }
  final dynamic childPlayId = json['childPlayId'];
  if (childPlayId != null) {
    getH5OrderListDataRecordxDataDetailList.childPlayId = childPlayId;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getH5OrderListDataRecordxDataDetailList.closingTime = closingTime;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    getH5OrderListDataRecordxDataDetailList.createTime = createTime;
  }
  final String? dataSourceCode = jsonConvert.convert<String>(
      json['dataSourceCode']);
  if (dataSourceCode != null) {
    getH5OrderListDataRecordxDataDetailList.dataSourceCode = dataSourceCode;
  }
  final dynamic firstNum = json['firstNum'];
  if (firstNum != null) {
    getH5OrderListDataRecordxDataDetailList.firstNum = firstNum;
  }
  final String? homeName = jsonConvert.convert<String>(json['homeName']);
  if (homeName != null) {
    getH5OrderListDataRecordxDataDetailList.homeName = homeName;
  }
  final dynamic isValid = json['isValid'];
  if (isValid != null) {
    getH5OrderListDataRecordxDataDetailList.isValid = isValid;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getH5OrderListDataRecordxDataDetailList.marketId = marketId;
  }
  final String? marketName = jsonConvert.convert<String>(json['marketName']);
  if (marketName != null) {
    getH5OrderListDataRecordxDataDetailList.marketName = marketName;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getH5OrderListDataRecordxDataDetailList.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getH5OrderListDataRecordxDataDetailList.marketValue = marketValue;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getH5OrderListDataRecordxDataDetailList.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getH5OrderListDataRecordxDataDetailList.matchInfo = matchInfo;
  }
  final int? matchManageType = jsonConvert.convert<int>(
      json['matchManageType']);
  if (matchManageType != null) {
    getH5OrderListDataRecordxDataDetailList.matchManageType = matchManageType;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getH5OrderListDataRecordxDataDetailList.matchName = matchName;
  }
  final int? matchOver = jsonConvert.convert<int>(json['matchOver']);
  if (matchOver != null) {
    getH5OrderListDataRecordxDataDetailList.matchOver = matchOver;
  }
  final String? matchPeriodId = jsonConvert.convert<String>(
      json['matchPeriodId']);
  if (matchPeriodId != null) {
    getH5OrderListDataRecordxDataDetailList.matchPeriodId = matchPeriodId;
  }
  final dynamic matchStatusId = json['matchStatusId'];
  if (matchStatusId != null) {
    getH5OrderListDataRecordxDataDetailList.matchStatusId = matchStatusId;
  }
  final String? matchTestScore = jsonConvert.convert<String>(
      json['matchTestScore']);
  if (matchTestScore != null) {
    getH5OrderListDataRecordxDataDetailList.matchTestScore = matchTestScore;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getH5OrderListDataRecordxDataDetailList.matchType = matchType;
  }
  final int? matchVideoTag = jsonConvert.convert<int>(json['matchVideoTag']);
  if (matchVideoTag != null) {
    getH5OrderListDataRecordxDataDetailList.matchVideoTag = matchVideoTag;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getH5OrderListDataRecordxDataDetailList.oddFinally = oddFinally;
  }
  final double? oddsValue = jsonConvert.convert<double>(json['oddsValue']);
  if (oddsValue != null) {
    getH5OrderListDataRecordxDataDetailList.oddsValue = oddsValue;
  }
  final String? optionValue = jsonConvert.convert<String>(json['optionValue']);
  if (optionValue != null) {
    getH5OrderListDataRecordxDataDetailList.optionValue = optionValue;
  }
  final String? orderAmountTotal = jsonConvert.convert<String>(
      json['orderAmountTotal']);
  if (orderAmountTotal != null) {
    getH5OrderListDataRecordxDataDetailList.orderAmountTotal = orderAmountTotal;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    getH5OrderListDataRecordxDataDetailList.orderNo = orderNo;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getH5OrderListDataRecordxDataDetailList.outrightYear = outrightYear;
  }
  final String? phase = jsonConvert.convert<String>(json['phase']);
  if (phase != null) {
    getH5OrderListDataRecordxDataDetailList.phase = phase;
  }
  final dynamic placeNum = json['placeNum'];
  if (placeNum != null) {
    getH5OrderListDataRecordxDataDetailList.placeNum = placeNum;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getH5OrderListDataRecordxDataDetailList.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getH5OrderListDataRecordxDataDetailList.playName = playName;
  }
  final String? playOptionName = jsonConvert.convert<String>(
      json['playOptionName']);
  if (playOptionName != null) {
    getH5OrderListDataRecordxDataDetailList.playOptionName = playOptionName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getH5OrderListDataRecordxDataDetailList.playOptions = playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getH5OrderListDataRecordxDataDetailList.playOptionsId = playOptionsId;
  }
  final String? playOptionsRange = jsonConvert.convert<String>(
      json['playOptionsRange']);
  if (playOptionsRange != null) {
    getH5OrderListDataRecordxDataDetailList.playOptionsRange = playOptionsRange;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    getH5OrderListDataRecordxDataDetailList.remark = remark;
  }
  final String? riskEvent = jsonConvert.convert<String>(json['riskEvent']);
  if (riskEvent != null) {
    getH5OrderListDataRecordxDataDetailList.riskEvent = riskEvent;
  }
  final String? score = jsonConvert.convert<String>(json['score']);
  if (score != null) {
    getH5OrderListDataRecordxDataDetailList.score = score;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getH5OrderListDataRecordxDataDetailList.scoreBenchmark = scoreBenchmark;
  }
  final dynamic secondNum = json['secondNum'];
  if (secondNum != null) {
    getH5OrderListDataRecordxDataDetailList.secondNum = secondNum;
  }
  final String? secondsMatchStart = jsonConvert.convert<String>(
      json['secondsMatchStart']);
  if (secondsMatchStart != null) {
    getH5OrderListDataRecordxDataDetailList.secondsMatchStart =
        secondsMatchStart;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getH5OrderListDataRecordxDataDetailList.settleScore = settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getH5OrderListDataRecordxDataDetailList.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getH5OrderListDataRecordxDataDetailList.sportName = sportName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    getH5OrderListDataRecordxDataDetailList.startTime = startTime;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getH5OrderListDataRecordxDataDetailList.tournamentId = tournamentId;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getH5OrderListDataRecordxDataDetailList.tournamentPic = tournamentPic;
  }
  final dynamic uid = json['uid'];
  if (uid != null) {
    getH5OrderListDataRecordxDataDetailList.uid = uid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    getH5OrderListDataRecordxDataDetailList.userId = userId;
  }
  return getH5OrderListDataRecordxDataDetailList;
}

Map<String, dynamic> $GetH5OrderListDataRecordxDataDetailListToJson(
    GetH5OrderListDataRecordxDataDetailList entity) {
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
  data['dataSourceCode'] = entity.dataSourceCode;
  data['firstNum'] = entity.firstNum;
  data['homeName'] = entity.homeName;
  data['isValid'] = entity.isValid;
  data['marketId'] = entity.marketId;
  data['marketName'] = entity.marketName;
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['matchId'] = entity.matchId;
  data['matchInfo'] = entity.matchInfo;
  data['matchManageType'] = entity.matchManageType;
  data['matchName'] = entity.matchName;
  data['matchOver'] = entity.matchOver;
  data['matchPeriodId'] = entity.matchPeriodId;
  data['matchStatusId'] = entity.matchStatusId;
  data['matchTestScore'] = entity.matchTestScore;
  data['matchType'] = entity.matchType;
  data['matchVideoTag'] = entity.matchVideoTag;
  data['oddFinally'] = entity.oddFinally;
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
  data['secondsMatchStart'] = entity.secondsMatchStart;
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

extension GetH5OrderListDataRecordxDataDetailListExtension on GetH5OrderListDataRecordxDataDetailList {
  GetH5OrderListDataRecordxDataDetailList copyWith({
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
    String? dataSourceCode,
    dynamic firstNum,
    String? homeName,
    dynamic isValid,
    String? marketId,
    String? marketName,
    String? marketType,
    String? marketValue,
    String? matchId,
    String? matchInfo,
    int? matchManageType,
    String? matchName,
    int? matchOver,
    String? matchPeriodId,
    dynamic matchStatusId,
    String? matchTestScore,
    int? matchType,
    int? matchVideoTag,
    String? oddFinally,
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
    String? secondsMatchStart,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? startTime,
    String? tournamentId,
    String? tournamentPic,
    dynamic uid,
    String? userId,
  }) {
    return GetH5OrderListDataRecordxDataDetailList()
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
      ..dataSourceCode = dataSourceCode ?? this.dataSourceCode
      ..firstNum = firstNum ?? this.firstNum
      ..homeName = homeName ?? this.homeName
      ..isValid = isValid ?? this.isValid
      ..marketId = marketId ?? this.marketId
      ..marketName = marketName ?? this.marketName
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..matchId = matchId ?? this.matchId
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchManageType = matchManageType ?? this.matchManageType
      ..matchName = matchName ?? this.matchName
      ..matchOver = matchOver ?? this.matchOver
      ..matchPeriodId = matchPeriodId ?? this.matchPeriodId
      ..matchStatusId = matchStatusId ?? this.matchStatusId
      ..matchTestScore = matchTestScore ?? this.matchTestScore
      ..matchType = matchType ?? this.matchType
      ..matchVideoTag = matchVideoTag ?? this.matchVideoTag
      ..oddFinally = oddFinally ?? this.oddFinally
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
      ..secondsMatchStart = secondsMatchStart ?? this.secondsMatchStart
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

GetH5OrderListDataRecordxDataOrderVOS $GetH5OrderListDataRecordxDataOrderVOSFromJson(
    Map<String, dynamic> json) {
  final GetH5OrderListDataRecordxDataOrderVOS getH5OrderListDataRecordxDataOrderVOS = GetH5OrderListDataRecordxDataOrderVOS();
  final String? batchNo = jsonConvert.convert<String>(json['batchNo']);
  if (batchNo != null) {
    getH5OrderListDataRecordxDataOrderVOS.batchNo = batchNo;
  }
  final String? beginTime = jsonConvert.convert<String>(json['beginTime']);
  if (beginTime != null) {
    getH5OrderListDataRecordxDataOrderVOS.beginTime = beginTime;
  }
  final int? betResult = jsonConvert.convert<int>(json['betResult']);
  if (betResult != null) {
    getH5OrderListDataRecordxDataOrderVOS.betResult = betResult;
  }
  final int? betStatus = jsonConvert.convert<int>(json['betStatus']);
  if (betStatus != null) {
    getH5OrderListDataRecordxDataOrderVOS.betStatus = betStatus;
  }
  final int? cancelType = jsonConvert.convert<int>(json['cancelType']);
  if (cancelType != null) {
    getH5OrderListDataRecordxDataOrderVOS.cancelType = cancelType;
  }
  final dynamic closingTime = json['closingTime'];
  if (closingTime != null) {
    getH5OrderListDataRecordxDataOrderVOS.closingTime = closingTime;
  }
  final int? hs = jsonConvert.convert<int>(json['hs']);
  if (hs != null) {
    getH5OrderListDataRecordxDataOrderVOS.hs = hs;
  }
  final String? langCode = jsonConvert.convert<String>(json['langCode']);
  if (langCode != null) {
    getH5OrderListDataRecordxDataOrderVOS.langCode = langCode;
  }
  final String? marketId = jsonConvert.convert<String>(json['marketId']);
  if (marketId != null) {
    getH5OrderListDataRecordxDataOrderVOS.marketId = marketId;
  }
  final String? marketType = jsonConvert.convert<String>(json['marketType']);
  if (marketType != null) {
    getH5OrderListDataRecordxDataOrderVOS.marketType = marketType;
  }
  final String? marketValue = jsonConvert.convert<String>(json['marketValue']);
  if (marketValue != null) {
    getH5OrderListDataRecordxDataOrderVOS.marketValue = marketValue;
  }
  final String? matchDay = jsonConvert.convert<String>(json['matchDay']);
  if (matchDay != null) {
    getH5OrderListDataRecordxDataOrderVOS.matchDay = matchDay;
  }
  final String? matchId = jsonConvert.convert<String>(json['matchId']);
  if (matchId != null) {
    getH5OrderListDataRecordxDataOrderVOS.matchId = matchId;
  }
  final String? matchInfo = jsonConvert.convert<String>(json['matchInfo']);
  if (matchInfo != null) {
    getH5OrderListDataRecordxDataOrderVOS.matchInfo = matchInfo;
  }
  final String? matchName = jsonConvert.convert<String>(json['matchName']);
  if (matchName != null) {
    getH5OrderListDataRecordxDataOrderVOS.matchName = matchName;
  }
  final int? matchType = jsonConvert.convert<int>(json['matchType']);
  if (matchType != null) {
    getH5OrderListDataRecordxDataOrderVOS.matchType = matchType;
  }
  final String? oddFinally = jsonConvert.convert<String>(json['oddFinally']);
  if (oddFinally != null) {
    getH5OrderListDataRecordxDataOrderVOS.oddFinally = oddFinally;
  }
  final String? oddsValue = jsonConvert.convert<String>(json['oddsValue']);
  if (oddsValue != null) {
    getH5OrderListDataRecordxDataOrderVOS.oddsValue = oddsValue;
  }
  final String? outrightYear = jsonConvert.convert<String>(
      json['outrightYear']);
  if (outrightYear != null) {
    getH5OrderListDataRecordxDataOrderVOS.outrightYear = outrightYear;
  }
  final int? playId = jsonConvert.convert<int>(json['playId']);
  if (playId != null) {
    getH5OrderListDataRecordxDataOrderVOS.playId = playId;
  }
  final String? playName = jsonConvert.convert<String>(json['playName']);
  if (playName != null) {
    getH5OrderListDataRecordxDataOrderVOS.playName = playName;
  }
  final String? playOptions = jsonConvert.convert<String>(json['playOptions']);
  if (playOptions != null) {
    getH5OrderListDataRecordxDataOrderVOS.playOptions = playOptions;
  }
  final String? playOptionsId = jsonConvert.convert<String>(
      json['playOptionsId']);
  if (playOptionsId != null) {
    getH5OrderListDataRecordxDataOrderVOS.playOptionsId = playOptionsId;
  }
  final String? scoreBenchmark = jsonConvert.convert<String>(
      json['scoreBenchmark']);
  if (scoreBenchmark != null) {
    getH5OrderListDataRecordxDataOrderVOS.scoreBenchmark = scoreBenchmark;
  }
  final String? settleScore = jsonConvert.convert<String>(json['settleScore']);
  if (settleScore != null) {
    getH5OrderListDataRecordxDataOrderVOS.settleScore = settleScore;
  }
  final int? sportId = jsonConvert.convert<int>(json['sportId']);
  if (sportId != null) {
    getH5OrderListDataRecordxDataOrderVOS.sportId = sportId;
  }
  final String? sportName = jsonConvert.convert<String>(json['sportName']);
  if (sportName != null) {
    getH5OrderListDataRecordxDataOrderVOS.sportName = sportName;
  }
  final String? tournamentId = jsonConvert.convert<String>(
      json['tournamentId']);
  if (tournamentId != null) {
    getH5OrderListDataRecordxDataOrderVOS.tournamentId = tournamentId;
  }
  final String? tournamentPic = jsonConvert.convert<String>(
      json['tournamentPic']);
  if (tournamentPic != null) {
    getH5OrderListDataRecordxDataOrderVOS.tournamentPic = tournamentPic;
  }
  return getH5OrderListDataRecordxDataOrderVOS;
}

Map<String, dynamic> $GetH5OrderListDataRecordxDataOrderVOSToJson(
    GetH5OrderListDataRecordxDataOrderVOS entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['batchNo'] = entity.batchNo;
  data['beginTime'] = entity.beginTime;
  data['betResult'] = entity.betResult;
  data['betStatus'] = entity.betStatus;
  data['cancelType'] = entity.cancelType;
  data['closingTime'] = entity.closingTime;
  data['hs'] = entity.hs;
  data['langCode'] = entity.langCode;
  data['marketId'] = entity.marketId;
  data['marketType'] = entity.marketType;
  data['marketValue'] = entity.marketValue;
  data['matchDay'] = entity.matchDay;
  data['matchId'] = entity.matchId;
  data['matchInfo'] = entity.matchInfo;
  data['matchName'] = entity.matchName;
  data['matchType'] = entity.matchType;
  data['oddFinally'] = entity.oddFinally;
  data['oddsValue'] = entity.oddsValue;
  data['outrightYear'] = entity.outrightYear;
  data['playId'] = entity.playId;
  data['playName'] = entity.playName;
  data['playOptions'] = entity.playOptions;
  data['playOptionsId'] = entity.playOptionsId;
  data['scoreBenchmark'] = entity.scoreBenchmark;
  data['settleScore'] = entity.settleScore;
  data['sportId'] = entity.sportId;
  data['sportName'] = entity.sportName;
  data['tournamentId'] = entity.tournamentId;
  data['tournamentPic'] = entity.tournamentPic;
  return data;
}

extension GetH5OrderListDataRecordxDataOrderVOSExtension on GetH5OrderListDataRecordxDataOrderVOS {
  GetH5OrderListDataRecordxDataOrderVOS copyWith({
    String? batchNo,
    String? beginTime,
    int? betResult,
    int? betStatus,
    int? cancelType,
    dynamic closingTime,
    int? hs,
    String? langCode,
    String? marketId,
    String? marketType,
    String? marketValue,
    String? matchDay,
    String? matchId,
    String? matchInfo,
    String? matchName,
    int? matchType,
    String? oddFinally,
    String? oddsValue,
    String? outrightYear,
    int? playId,
    String? playName,
    String? playOptions,
    String? playOptionsId,
    String? scoreBenchmark,
    String? settleScore,
    int? sportId,
    String? sportName,
    String? tournamentId,
    String? tournamentPic,
  }) {
    return GetH5OrderListDataRecordxDataOrderVOS()
      ..batchNo = batchNo ?? this.batchNo
      ..beginTime = beginTime ?? this.beginTime
      ..betResult = betResult ?? this.betResult
      ..betStatus = betStatus ?? this.betStatus
      ..cancelType = cancelType ?? this.cancelType
      ..closingTime = closingTime ?? this.closingTime
      ..hs = hs ?? this.hs
      ..langCode = langCode ?? this.langCode
      ..marketId = marketId ?? this.marketId
      ..marketType = marketType ?? this.marketType
      ..marketValue = marketValue ?? this.marketValue
      ..matchDay = matchDay ?? this.matchDay
      ..matchId = matchId ?? this.matchId
      ..matchInfo = matchInfo ?? this.matchInfo
      ..matchName = matchName ?? this.matchName
      ..matchType = matchType ?? this.matchType
      ..oddFinally = oddFinally ?? this.oddFinally
      ..oddsValue = oddsValue ?? this.oddsValue
      ..outrightYear = outrightYear ?? this.outrightYear
      ..playId = playId ?? this.playId
      ..playName = playName ?? this.playName
      ..playOptions = playOptions ?? this.playOptions
      ..playOptionsId = playOptionsId ?? this.playOptionsId
      ..scoreBenchmark = scoreBenchmark ?? this.scoreBenchmark
      ..settleScore = settleScore ?? this.settleScore
      ..sportId = sportId ?? this.sportId
      ..sportName = sportName ?? this.sportName
      ..tournamentId = tournamentId ?? this.tournamentId
      ..tournamentPic = tournamentPic ?? this.tournamentPic;
  }
}