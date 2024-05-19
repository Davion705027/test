import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:get/get.dart';

extension TYFormatMsc on TYFormat {
  static List<String> formatMsc(String str) {
    if (str == '' || str.isEmpty) {
      return [];
    }

    List<String> list_ = str.split(RegExp(r'[:|]'));

    for (int i = 0, l = 3 - list_.length; i < l; i++) {
      list_.add('');
    }

    list_.add('msc_${list_[0]}'.tr);
    return list_;
  }

}