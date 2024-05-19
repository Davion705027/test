import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/models/res/bet_amount_entity.dart';

class BetCountModel {
  String id;
  String localeName;
  String name;
  int count;



  Rxn<BetAmountBetAmountInfo> betAmountInfo =  Rxn<BetAmountBetAmountInfo>();

  BetCountModel(this.id,this.localeName,this.name,this.count);
}

class BetTipsModel{
  String id;
  String tipsTitle;
  String tipsContent;
  BetTipsModel(this.id,this.tipsTitle,this.tipsContent);
}