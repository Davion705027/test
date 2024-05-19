import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../db/app_cache.dart';
import '../models/res/get_user_customize_info_entity.dart';
import '../models/res/menu_entity.dart';
import '../models/res/save_user_customize_info_entity.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'menu_api.g.dart';

@RestApi()
abstract class MenuApi {
  factory MenuApi(Dio dio, {String baseUrl}) = _MenuApi;

  factory MenuApi.instance() =>
      MenuApi(AppDio.getInstance().dio, baseUrl: StringKV.baseUrl.get() ?? '');

  // 盘口设置 按钮更新
  @POST("/yewu12/user/setUserPersonalise")
  Future<MenuEntity> setUserPersonalise(
    @Field('handicapType') int handicapType,
  );

  // 排序规则 按钮更新
  @POST("/yewu12/user/rememberSelect")
  Future<MenuEntity> rememberSelect(
    @Field('sort') int sort,
  );

  // 投注模式 按钮更新
  @POST("/yewu12/user/setUserPersonalise")
  Future<MenuEntity> setUserPersonaliseT(
    @Field('userVersion') int userVersion,
  );

  // 自定义快捷投注金额 拉取投注余额
  @Extra({kRetryable: true})
  @POST("/yewu13/order/betRecord/getUserCustomizeInfo")
  Future<GetUserCustomizeInfoEntity> getUserCustomizeInfo(
    @Field('type') int type,
  );

  // 自定义快捷投注金额 保存投注余额
  @POST("/yewu13/order/betRecord/saveUserCustomizeInfo")
  Future<SaveUserCustomizeInfoEntity> saveUserCustomizeInfo(
    @Field('type') int type,
    @Field('seriesList') List<int> seriesList,
    @Field('singleList') List<int> singleList,
  );

  // 一键投注保存金额
  @POST("/yewu13/order/betRecord/saveUserCustomizeInfo")
  Future<SaveUserCustomizeInfoEntity> saveUserCustomizeInfos(
      @Field('fastBetAmount') String fastBetAmount,
      @Field('firstTime') bool firstTime,
      @Field('switchOn') bool switchOn,
      @Field('type') int type,
      );
}
