import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

Widget sportIcon(
    {required int index,
    required double width,
    required double height,
    required bool isSelected}) {
  if (isSelected) {
    return ImageView(
      'assets/images/sport/sportstab_ico_${index}_sel.png',
      width: width,
      height: height,
      boxFit: BoxFit.fitHeight,
    );
  } else {
    if (Get.isDarkMode) {
      return ImageView(
        'assets/images/sport/sportstab_ico_${index}_nor_night.png',
        width: width,
        height: height,
        boxFit: BoxFit.fitHeight,
      );
    } else {
      return ImageView(
        'assets/images/sport/sportstab_ico_${index}_nor.png',
        width: width,
        height: height,
        boxFit: BoxFit.fitHeight,
      );
    }
  }
}

Widget leagueIcon(
    {required int index,
    required double width,
    required double height,
    required bool isSelected}) {
  if (isSelected) {
    return ImageView(
      'assets/images/league/sportstab_ico_${index}_sel_league.png',
      width: width,
      height: height,
      boxFit: BoxFit.fitHeight,
    );
  } else {
    if (Get.isDarkMode) {
      return ImageView(
        'assets/images/league/sportstab_ico_${index}_nor_night_league.png',
        width: width,
        height: height,
        boxFit: BoxFit.fitHeight,
      );
    } else {
      return ImageView(
        'assets/images/league/sportstab_ico_${index}_nor_league.png',
        width: width,
        height: height,
        boxFit: BoxFit.fitHeight,
      );
    }
  }
}
