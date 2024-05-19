import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/origin_data_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../models/res/access_config.dart';
import '../models/res/get_filter_match_list_new_entity.dart';
import '../models/res/sport_config_info.dart';
import '../network/app_dio.dart';
import '../network/retry_interceptor.dart';

part 'base_data_api.g.dart';

@RestApi()
abstract class BaseDataApi {
  factory BaseDataApi(Dio dio, {String baseUrl}) = _BaseDataApi;

  factory BaseDataApi.instance() => BaseDataApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  // 新旧菜单ID对应
  @Extra({kRetryable: true})
  @POST('/yewu11/v3/menu/loadMapping')
  Future<ApiRes<Map<String, dynamic>>> loadMenuMapping(
      @Body() Map<String, dynamic> body);

  ///球种
  @Extra({kRetryable: true})
  @GET('/yewu11/v3/menu/init')
  Future<ApiRes<List<SportConfigInfo>>> getMenuInit();

  // 菜单-联赛-赛事
  @POST('/yewu11/v3/menu/loadTournamentMatch')
  Future<ApiRes<Map<String, dynamic>>> loadTournamentMatch(
      @Body() Map<String, dynamic> map);

  // 菜单国际化
  @Extra({kRetryable: true})
  @POST('/yewu11/v3/menu/loadNameList')
  Future<ApiRes<Map<String, dynamic>>> loadNameList(
      @Body() Map<String, dynamic> map);

  // 获取元数据
  @Extra({kRetryable: true})
  @GET('/yewu11/v2/m/getOriginalData')
  Future<ApiRes<OriginDataEntity>> getOriginalData();

  // 获取联赛数据
  @GET("/yewu11/v1/m/getFilterMatchListNew")
  Future<GetFilterMatchListNewEntity> getFilterMatchListNew(
    @Query('type') int type,
    @Query('euid') int euid,
    @Query('inputText') String inputText,
    @Query('cuid') int cuid,
    @Query('device') String device,
    @Query('showem') String showem,
    @Query('md') int md,
    @Query('t') int t,
  );

  @GET('/yewu11/v1/art/getAccessConfig')
  @Extra({kRetryable: true})
  Future<ApiRes<AccessConfig>> getAccessConfig();
}
