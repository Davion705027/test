import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_list_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/network/retry_interceptor.dart';
import 'package:retrofit/retrofit.dart';

import '../../db/app_cache.dart';
import '../network/app_dio.dart';
part 'dj_data_api.g.dart';

@RestApi()
abstract class DjDataApi {
  factory DjDataApi(Dio dio, {String baseUrl}) = _DjDataApi;

  factory DjDataApi.instance() => DjDataApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  // 获取日期数据
  @POST('/yewu11/v1/w/esports/getDateMenuList')
  Future<ApiRes<List<DjDateEntityEntity>>> getDateMenuList(
      @Field("csid") String csid,);

  @POST('/yewu11/v1/m/esportsMatches')
  Future<ApiRes<List<MatchEntity>>> esportsMatches(
      @Field("category") String category,
      @Field("csid") String csid,
      @Field("cuid") String cuid,
      @Field("euid") String euid,
      @Field("hpsFlag") String hpsFlag,
      @Field("md") String md,
      @Field("sort") String sort,
      @Field("type") String type,
      );
  @POST('/yewu11/v1/m/escnh5')
  Future<ApiRes<List<MatchEntity>>> collection(
      @Field("collect") int collect,
      @Field("csid") String csid,
      @Field("cuid") String cuid,
      @Field("euid") String euid,
      @Field("hpsFlag") String hpsFlag,
      @Field("md") String md,
      @Field("sort") String sort,
      @Field("type") String type,
      );

  @Extra({kRetryable: true, KRetryCode: '0401038'})
  @POST('/yewu11/v1/m/matchesPB')
  Future<ApiRes<List<MatchEntity>>> matchesPB(
      @Field("category") String category,
      @Field("cuid") String cuid,
      @Field("euid") String euid,
      @Field("hpsFlag") String hpsFlag,
      @Field("md") String md,
      @Field("sort") String sort,
      @Field("type") String type,
      );




  // // 获取联赛数据
  // @GET("/v1/m/getFilterMatchListNew")
  // Future<GetFilterMatchListNewEntity> getFilterMatchListNew(
  //     @Query('type') int type,
  //     @Query('euid') int euid,
  //     @Query('inputText') String inputText,
  //     @Query('cuid') int cuid,
  //     @Query('device') String device,
  //     @Query('showem') String showem,
  //     @Query('md') int md,
  //     @Query('t') int t,
  //     );
}
