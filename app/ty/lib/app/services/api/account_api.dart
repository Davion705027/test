import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/login_panda_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/user_info.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/balance_entity.dart';
import '../models/res/user_personalise_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';
import '../network/throttle_api.dart';

part 'account_api.g.dart';

@RestApi()
abstract class AccountApi {
  factory AccountApi(Dio dio, {String baseUrl}) = _AccountApi;

  factory AccountApi.instance() => AccountApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  /// login prod 试玩是get
  @GET("/user/loginPanda")
  Future loginPanda(
    @Query("userName") String? username,
    @Query("merchantCode") String merchantCode,
    @Query("password") String? password,
    @Query('terminal') String? terminal,
  );

  ///其余是post
  @POST("/user/login")
  Future<LoginPandaEntity> login(
    @Field('userName') String? userName,
    @Field('merchantCode') String? merchantCode,
    @Field("password") String? password,
    @Field('terminal') String? terminal,
  );

  /// 获取用户信息
  @GET('/yewu12/user/getUserInfo')
  Future<ApiRes<UserInfo>> getUserInfo(@Query('token') String token);

  // 获取用户余额
  @Extra({kThrottleAbleKey: true,kThrottleDurtionKey:1500})
  @GET(ThrottleUtil.userAmount)
  Future<ApiRes<BalanceEntity>> getBalance(@Query('uid') String uid);

  // 记住用户选择(附加盘/语言/日间/夜间等)此接口不支持PB
  @POST('/yewu12/user/getUserPersonalise')
  Future<ApiRes<UserPersonaliseEntity>> getUserPersonalise(@Field("a") int? a);

  // 设置用户选择(附加盘/语言/日间/夜间等)此接口不支持PB
  @POST('/yewu12/user/setUserPersonalise')
  Future<ApiRes> setUserPersonalise(
      @Field("toAccept") String? toAccept,
      @Field("userVersion") String? userVersion,
      @Field("handicapType") String? handicapType,
  );

  // 获取服务器时间
  @GET('/yewu11/v1/getSystemTime/currentTimeMillis')
  Future<ApiRes> getServerTime();
}
