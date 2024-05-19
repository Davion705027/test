import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/core/format/project/module/format-odds-conversion-mixin.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import 'dog_horse_rank_row.dart';
import 'vr_common_box_shadow.dart';

class DogHorseFinishedRankWidget extends StatelessWidget {
  const DogHorseFinishedRankWidget({
    super.key,
    required this.match,
    required this.championHps,
    required this.topTwoHps,
    required this.topThreeHps,
    required this.oddEvenHps,
    required this.sizeHps,
    required this.teamRankingInfo,
    required this.championOls,
    required this.topTwoOls,
    required this.topThreeOls,
    required this.oddEvenOls,
    required this.sizeOls,
  });

  final Map<String, Map<String, String?>?> teamRankingInfo;
  final MatchEntity? match;
  final MatchHps? championHps;
  final MatchHps? topTwoHps;
  final MatchHps? topThreeHps;
  final MatchHps? oddEvenHps;
  final MatchHps? sizeHps;
  final List<MatchHpsHlOl> championOls;
  final List<MatchHpsHlOl> topTwoOls;
  final List<MatchHpsHlOl> topThreeOls;
  final List<MatchHpsHlOl> oddEvenOls;
  final List<MatchHpsHlOl> sizeOls;

  (String teamName, String teamNum) _teamInfo(int index) {
    final teamsMapKey = teamRankingInfo.keys.toList()[index];
    final teamNumNameMap = teamRankingInfo[teamsMapKey];

    final teamNum = teamNumNameMap?['teamNum'] ?? '1';
    final teamName = teamNumNameMap?['teamName'] ?? '';
    return (teamName, teamNum);
  }

  @override
  Widget build(BuildContext context) {
    final championOl = championOls.firstOrNull;
    final championoOlOvStr =
        TYFormatOddsConversionMixin.computeValueByCurOddType(
      championOl?.ov ?? 0,
      championHps?.hpid ?? '',
      championHps?.hsw.split(',') ?? [],
      int.tryParse(match?.csid ?? '0') ?? 0,
    );

    return Column(
      children: [
        if (teamRankingInfo.length > 3)
          ...List.generate(
            3,
            (index) {
              final (teamName, teamNum) = _teamInfo(index);
              return DogHorseRankRow(
                rank: index,
                title: teamName,
                teamNum: teamNum,
              ).marginOnly(top: 8.w);
            },
          ),
        SizedBox(height: 8.w),
        Row(
          children: [
            if (teamRankingInfo.isNotEmpty)
              VrCommonBoxShadow(
                padding: EdgeInsets.symmetric(vertical: 12.w),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.menu_itme_name_champion.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? AppColor.colorWhite
                            : '#303442'.hexColor,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            ImageView(
                              'assets/images/vr/vr_dog_horse_rank${_teamInfo(0).$2}.png',
                              width: 20.w,
                              height: 20.w,
                            ).marginSymmetric(vertical: 4.w),
                            Text(
                              championoOlOvStr,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Get.isDarkMode
                                    ? AppColor.colorWhite
                                    : '#303442'.hexColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ).expanded(),
            SizedBox(width: 8.w),
            if (teamRankingInfo.length > 2)
              _buildRankCard(
                title: '前二',
                iconSrcs: [
                  'assets/images/vr/vr_dog_horse_rank${_teamInfo(1).$2}.png',
                  'assets/images/vr/vr_dog_horse_rank${_teamInfo(2).$2}.png',
                ],
                oddsList: topTwoOls.map((ol) {
                  final topTwoOlOvStr =
                      TYFormatOddsConversionMixin.computeValueByCurOddType(
                    ol.ov,
                    topTwoHps?.hpid ?? '',
                    topTwoHps?.hsw.split(',') ?? [],
                    int.tryParse(match?.csid ?? '0') ?? 0,
                  );
                  return topTwoOlOvStr;
                }).toList(),
              ).expanded(),
            SizedBox(width: 8.w),
            if (teamRankingInfo.length > 5)
              _buildRankCard(
                title: '前三',
                iconSrcs: [
                  'assets/images/vr/vr_dog_horse_rank${_teamInfo(3).$2}.png',
                  'assets/images/vr/vr_dog_horse_rank${_teamInfo(4).$2}.png',
                  'assets/images/vr/vr_dog_horse_rank${_teamInfo(5).$2}.png',
                ],
                oddsList: topThreeOls.map((ol) {
                  final topThreeOlOvStr =
                      TYFormatOddsConversionMixin.computeValueByCurOddType(
                    ol.ov,
                    topThreeHps?.hpid ?? '',
                    topThreeHps?.hsw.split(',') ?? [],
                    int.tryParse(match?.csid ?? '0') ?? 0,
                  );
                  return topThreeOlOvStr;
                }).toList(),
              ).expanded(),
          ],
        ),
        SizedBox(height: 8.w),
        _buildOddEven(),
        SizedBox(height: 8.w),
      ],
    ).marginSymmetric(horizontal: 8.w);
  }

  Widget _buildRankCard({
    required String title,
    required List<String> iconSrcs,
    required List<String> oddsList,
  }) {
    // assert(
    //   iconSrcs.length == oddsList.length,
    //   '赔率和排名图标数量必须一致',
    // );

    if (oddsList.isEmpty || iconSrcs.isEmpty) return const SizedBox();

    return VrCommonBoxShadow(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
            ),
          ),
          Row(
            mainAxisAlignment: iconSrcs.length > 2
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.start,
            mainAxisSize:
                iconSrcs.length < 3 ? MainAxisSize.min : MainAxisSize.max,
            children: List.generate(
              iconSrcs.length,
              (index) {
                final iconSrc = iconSrcs[index];
                final odds = oddsList[index];
                return Column(
                  children: [
                    ImageView(
                      iconSrc,
                      width: 20.w,
                      height: 20.w,
                    ).marginSymmetric(vertical: 4.w),
                    Text(
                      odds,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Get.isDarkMode
                            ? AppColor.colorWhite
                            : '#303442'.hexColor,
                      ),
                    ),
                  ],
                ).marginOnly(
                    right: iconSrcs.length == 2 && index == 0 ? 16.w : 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 单双结果
  Widget _buildOddEven() {
    if (oddEvenOls.isEmpty && sizeOls.isEmpty) return const SizedBox();

    final oddEvenOl = oddEvenOls.firstOrNull;
    final oddEvenOlOvStr = TYFormatOddsConversionMixin.computeValueByCurOddType(
      oddEvenOl?.ov ?? 0,
      oddEvenHps?.hpid ?? '',
      oddEvenHps?.hsw.split(',') ?? [],
      int.tryParse(match?.csid ?? '0') ?? 0,
    );

    final sizeOl = sizeOls.firstOrNull;
    final sizeOlOvStr = TYFormatOddsConversionMixin.computeValueByCurOddType(
      sizeOl?.ov ?? 0,
      sizeHps?.hpid ?? '',
      sizeHps?.hsw.split(',') ?? [],
      int.tryParse(match?.csid ?? '0') ?? 0,
    );

    return Row(
      children: [
        if (oddEvenOls.isNotEmpty)
          _buildOddEvenRow(
            title: '单/双',
            ratio: oddEvenOlOvStr,
          ).expanded(),
        SizedBox(width: 8.w),
        if (sizeOls.isNotEmpty)
          _buildOddEvenRow(
            title: '大/小',
            ratio: sizeOlOvStr,
          ).expanded(),
      ],
    );
  }

  Widget _buildOddEvenRow({
    required String title,
    required String ratio,
  }) {
    return VrCommonBoxShadow(
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color:
                    Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
              ),
            ),
          ),
          Text(
            ratio,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
            ),
          ),
        ],
      ),
    );
  }
}
