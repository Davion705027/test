import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../db/app_cache.dart';
import '../models/res/set_user_language_entity.dart';
import '../network/app_dio.dart';

part 'language_api.g.dart';

@RestApi()
abstract class LanguageApi {
  factory LanguageApi(Dio dio, {String baseUrl}) = _LanguageApi;

  factory LanguageApi.instance() =>
      LanguageApi(AppDio.getInstance().dio, baseUrl: StringKV.baseUrl.get() ?? '');


  ///未结注单-未结算-提前结算
  @GET("/yewu12/user/setUserLanguage")
  Future<SetUserLanguageEntity> setUserLanguage(
      @Query('token') String? token,
      @Query('languageName') String? languageName,
      );
}
