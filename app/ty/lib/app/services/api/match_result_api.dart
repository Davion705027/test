import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/network/app_dio.dart';
import 'package:retrofit/retrofit.dart';

/**
 * @Author bookpeer
 * @Date 2024/2/25 17:34
 */

part 'match_result_api.g.dart';

@RestApi()
abstract class MatchResultApi {
  factory MatchResultApi(Dio dio, {String baseUrl}) = _MatchResultApi;

  factory MatchResultApi.instance() => MatchResultApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  /// https://api.lkjklkyi.com/yewu11/v1/m/matchDetail/getEventResult?mid=3225182&t=1708853441116
  @GET("/getEventResult")
  Future<ApiRes<List<dynamic>>> getEventResult(
      @Query("mid") String mId, @Query("t") String time);
}
