import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';

import 'model/bet_history_record.dart';

class ShopCartHistory{
  ShopCartHistory._privateConstructor();
  static final ShopCartHistory _instance = ShopCartHistory._privateConstructor();

  factory ShopCartHistory() {
    // 返回静态私有实例
    return _instance;
  }

  final Map<String,BetHistoryRecord> historyRecordMap = {};

  BetHistoryRecord getHistoryRecord(ShopCartItem shopCartItem){

    BetHistoryRecord? record = historyRecordMap[shopCartItem.itemId];
    if(record == null){
      record = BetHistoryRecord(shopCartItem);
      historyRecordMap[shopCartItem.itemId] = record;
    }

    return record;
  }

  void removeHistoryRecord(ShopCartItem shopCartItem){
    BetHistoryRecord? record = historyRecordMap[shopCartItem.itemId];
    if(record != null){
      historyRecordMap.remove(shopCartItem.itemId);
    }
  }
}
