import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/req/bet_req.dart';
import '../models/req/latest_market_req.dart';
import '../models/res/api_res.dart';
import '../models/req/bet_amount_req.dart';
import '../models/res/bet_amount_entity.dart';
import '../models/res/bet_result_entity.dart';
import '../models/res/cancel_pre_bet_order_entity.dart';
import '../models/res/get_cashout_max_amount_list_entity.dart';
import '../models/res/get_h5_order_list_entity.dart';
import '../models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../models/res/last_market_entity.dart';
import '../models/res/order_pre_settle_entity.dart';
import '../models/res/update_pre_bet_odds_entity.dart';
import '../network/app_dio.dart';

part 'bet_api.g.dart';

@RestApi()
abstract class BetApi {
  factory BetApi(Dio dio, {String baseUrl}) = _BetApi;

  factory BetApi.instance() =>
      BetApi(AppDio
          .getInstance()
          .dio, baseUrl: StringKV.baseUrl.get() ?? '');

  //获取额度接口合并
  @POST("/yewu13/v1/betOrder/queryBetAmount")
  Future<ApiRes<BetAmountEntity>> queryBetAmount(
      @Body() BetAmountReq betAmountReq
  );

  // 获取最大值和最小值接口
  @POST("/yewu13/v1/betOrder/queryMarketMaxMinBetMoney")
  Future<ApiRes<List<BetAmountBetAmountInfo>>> queryMarketMaxMinBetMoney(
      @Body() BetAmountReq betAmountReq
  );

  // 查询最新的盘口数据
  @POST('/yewu13/v1/betOrder/queryLatestMarketInfo')
  Future<ApiRes<List<LastMarketEntity>>> queryLatestMarketInfo(
      @Body() LatestMarketReq latestMarketReq
      );

  //获取预约额度接口合并
  @POST("/yewu13/v1/betOrder/queryPreBetAmount")
  Future<ApiRes<BetAmountEntity>> queryPreBetAmount(
      @Body() BetAmountReq betAmountReq
      );

  // 押注项提交接口
  @POST("/yewu13/v1/betOrder/bet")
  Future<ApiRes<BetResultEntity>> bet(
      @Body() BetReq betReq
  );

  ///未结注单-未结算和（已结算）两个功能共用一个接口
  @POST("/yewu12/order/betRecord/getH5OrderListPB")
//  @FormUrlEncoded()
  Future<GetH5OrderListEntity> getH5OrderList(
      @Field('orderStatus') String? orderStatus,
      @Field('searchAfter') String? searchAfter,
      );

  ///已结注单-预约中-已失效 两个功能共用一个接口
  @POST("/yewu13/order/betRecord/getH5PreBetOrderlist")
//  @FormUrlEncoded()
  Future<GetH5PreBetOrderlistEntity> getH5PreBetOrderlist(
      @Field('preOrderStatusList') List<int>? preOrderStatusList,
      @Field('searchAfter') String? searchAfter,
      );

  ///已结注单
  @POST("/yewu12/order/betRecord/getH5OrderListPB")
//  @FormUrlEncoded()
  Future<GetH5OrderListEntity> getH5OrderListSettled(
      @Field('orderStatus') String? orderStatus,
      @Field('searchAfter') String? searchAfter,
      @Field('orderBy') int? orderBy,
      @Field('timeType') int? timeType,
      );

  ///未结注单-预约中-更改赔率
  @POST("/yewu13/order/betRecord/updatePreBetOdds")
//  @FormUrlEncoded()
  Future<UpdatePreBetOddsEntity> updatePreBetOdds(
    @Field('marketType') String? marketType,
    @Field('odds') int? odds,
    @Field('orderNo') String? orderNo,
  );

  ///未结注单-预约中-取消预约
  @GET("/yewu13/v1/betOrder/cancelPreBetOrder")
  Future<CancelPreBetOrderEntity> cancelPreBetOrder(
      @Query('orderNo') int orderNo,
      );

  ///未结注单-未结算-提前结算
  @GET("/yewu13/order/betRecord/getCashoutMaxAmountList")
  Future<GetCashoutMaxAmountListEntity> getCashoutMaxAmountList(
      @Query('orderNo') String? orderNo,
      );

  ///未结注单-预约中-更改赔率
  @POST("/yewu13/v1/betOrder/orderPreSettle")
//  @FormUrlEncoded()
  Future<OrderPreSettleEntity> orderPreSettle(
      @Field('deviceType') int? deviceType,
      @Field('frontSettleAmount') String? frontSettleAmount,
      @Field('orderNo') String? orderNo,
      @Field('settleAmount') double? settleAmount,
      );
}