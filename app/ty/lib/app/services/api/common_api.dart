
// 来源vue: src/api/module/common/index.js


import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/services/network/app_dio.dart';
import 'package:retrofit/http.dart';

import '../../db/app_cache.dart';
import '../models/res/api_res.dart';

part 'common_api.g.dart';

@RestApi()
abstract class CommonApi {

  factory CommonApi(Dio dio, {String baseUrl}) = _CommonApi;

  factory CommonApi.instance() => CommonApi(AppDio.getInstance().dio,
      baseUrl: StringKV.baseUrl.get() ?? '');

  // 电竞图片资源域名
  @GET('/yewu11/v1/games/imgDomain')
  Future<ApiRes> getDjImageDomain();



}