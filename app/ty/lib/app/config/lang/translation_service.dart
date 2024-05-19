import 'dart:ui';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

import '../../../generated/locales.g.dart';
import '../../db/app_cache.dart';


/// @Author swifter
/// @Date 2023/9/17 18:12

class TranslationService extends Translations {
  static const fallbackLocale = Locale('zh', 'CN');

  static Locale getInitLocale() {
    String language = StringKV.language.get() ?? "";
    if (language.isNotEmpty) {
      if (language.contains('CN')) {
        return const Locale('zh', 'CN');
      } else if (language.contains('GB')) {
        return const Locale('en', 'GB');
      } else if (language.contains('TW')) {
        return const Locale('zh', 'TW');
      } else if (language.contains('VN')) {
        return const Locale('vi', 'VN');
      }else if (language.contains('TH')) {
        return const Locale('th', 'TH');
      }else if (language.contains('MY')) {
        return const Locale('ms', 'MY');
      }else if (language.contains('KR')) {
        return const Locale('ko', 'KR');
      }else if (language.contains('PT')) {
        return const Locale('pt', 'PT');
      }
    }
    //首次没是语言设置默认设置中文简体
    StringKV.language.save("CN");
    return fallbackLocale;
  }

  @override
  Map<String, Map<String, String>> get keys => AppTranslation.translations;
}
