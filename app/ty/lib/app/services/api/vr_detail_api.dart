import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/common_score_model_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/group_soure_model_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/item_disuse_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_history_dog_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_ranking_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sports_menu_entity.dart';
import 'package:flutter_ty_app/app/services/network/app_dio.dart';
import 'package:retrofit/retrofit.dart';


part 'vr_detail_api.g.dart';

@RestApi()
abstract class VrDetailApi {
  factory VrDetailApi(Dio dio, {String baseUrl}) = _VrDetailApi;

  factory VrDetailApi.instance() => VrDetailApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  @POST('/yewu11/v1/w/virtual/getVirtualSportTeamRanking')
  Future<ApiRes<List<CommonScoreModelData>>> getVirtualSportTeamRanking(
    @Field("tid") String tid,
  );

  @POST('/yewu11/v1/w/virtual/getVirtualSportXZTeamRanking')
  Future<ApiRes<List<GroupSoureModelDataGroupData>>> getVirtualSportXZTeamRanking(
    @Field("tid") String tid,
  );


  // tid: 86945115832995842
  // batchNo: 457652
  // lod: 2
  // mmp: SEMIFINAL
  // beginTime: 1710419160000
  // t: 1710419105589
  @GET('/yewu11/v1/w/virtual/getMatchSorce')
  Future<ApiRes<Map<String,dynamic>>> getMatchSorce(
    @Query("tid") String tid,
    @Query("batchNo") String batchNo,
    @Query("lod") String lod,
    @Query("mmp") String mmp,
    @Query("beginTime") String beginTime,
  );

  @GET('/yewu11/v1/m/matchDetail/getVirtualMatchDetailCount')
  Future<ApiRes<List<VrHistoryDogEntity>>> getVirtualMatchDetailCount(
    @Query("mid") String mid,
  );

}
