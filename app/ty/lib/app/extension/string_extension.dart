import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import 'color_extension.dart';

/**
 * @Author swifter
 * @Date 2024/2/4 18:23
 */

extension StringX on String {
  num toNum() {
    try {
      return num.parse(this);
    } catch (e) {
      return 0;
    }
  }

  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return 0;
    }
  }
}

extension HexStringToColor on String {
  Color get hexColor => HexColor(this);
}

extension UrlParametersString on String? {
  // 查询 url 中的指定参数
  String queryParametersOf(String key) {
    if (this?.isNotEmpty == true) {
      try {
        final uri = Uri.parse(this!);
        final queryParameters = uri.queryParameters;
        String value = queryParameters[key] ?? '';
        if (value.isEmpty) {
          // 解决 url 包含 # 号的特殊情况
          final fragment = uri.fragment;
          if (fragment.isNotEmpty) {
            value = fragment.queryParametersOf(key);
          }
        }
        return value;
      } catch (e) {
        debugPrint('queryParametersOf key = $key error: $e');
        return '';
      }
    }
    return '';
  }

  // 查询 url 中的所有参数
  Map<String, String>? queryParameters() {
    if (this?.isNotEmpty == true) {
      try {
        final uri = Uri.parse(this!);
        return uri.queryParameters;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
