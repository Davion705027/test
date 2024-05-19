
import 'package:get/get.dart';

/// 球类图标
String getImage(String index, bool isSelected) {
  if (isSelected) {
    return 'assets/images/sport/sportstab_ico_${index.padLeft(2,'0')}_sel.png';
  } else {
    if (Get.isDarkMode) {
      return 'assets/images/sport/sportstab_ico_${index.padLeft(2,'0')}_nor_night.png';
    } else {
      return 'assets/images/sport/sportstab_ico_${index.padLeft(2,'0')}_nor.png';
    }
  }
}