import 'package:flutter_ty_app/app/core/format/project/module/format-odds-conversion-mixin.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/vr_bet/vr_mix_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_sport_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_common_odds_box.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';

class WaitingBallsTeamsRatioWidget extends StatefulWidget {
  const WaitingBallsTeamsRatioWidget({
    super.key,
    required this.type,
    required this.vrMatch,
    required this.lockOdds,
  });

  // 1足球 2篮球
  final int type;
  final VrMatchEntity vrMatch;
  final bool lockOdds;

  @override
  State<WaitingBallsTeamsRatioWidget> createState() =>
      _WaitingBallsTeamsRatioWidgetState();
}

class _WaitingBallsTeamsRatioWidgetState
    extends State<WaitingBallsTeamsRatioWidget> {
  // TODO: 可能需要存储到 MatchEntity 或者 VrHomeController 里面
  final Map<int, MatchHpsHlOl?> _selOls = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.vrMatch.matchs.length,
        (index) => _buildMatchItem(
          widget.vrMatch.matchs[index],
          onOlTap: (ol) {
            if (ShopCartController.to.currentBetController
                is! VrMixBetController) return;

            _selOls[index] = ol;
            if (mounted) setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildMatchItem(
    MatchEntity match, {
    ValueChanged<MatchHpsHlOl?>? onOlTap,
  }) {
    final hpns = widget.vrMatch.hpns;

    final winAllHps = hpns.isNotEmpty
        ? match.hps.firstWhereOrNull((element) => element.hpn == hpns[0])
        : null;
    final fieldGoalHps = hpns.length >= 2
        ? match.hps.firstWhereOrNull((element) => element.hpn == hpns[1])
        : null;
    final fullFieldSizeHps = hpns.length >= 3
        ? match.hps.firstWhereOrNull((element) => element.hpn == hpns[2])
        : null;

    late bool isProfess;
    try {
      isProfess = HomeController.to.homeState.isProfess;
    } catch (e) {
      isProfess = true;
    }
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.vrSportDetail,
          arguments: {
            'vrMatch': widget.vrMatch,
            'match': match,
            'isBalls': widget.type <= 2,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Get.isDarkMode
                  ? Colors.white.withOpacity(0.07999999821186066)
                  : AppColor.dividerColorLight,
            ),
          ),
        ),
        child: Column(
          children: [
            _buildTotalGuessEntrance(match.mc, isProfess),
            isProfess
                ? _buildTeamsAndRatios(
                    match: match,
                    teams: match.teams,
                    malu: match.malu ?? '',
                    mhlu: match.mhlu ?? '',
                    winAllHps: winAllHps,
                    fieldGoalHps: fieldGoalHps,
                    fullFieldSizeHps: fullFieldSizeHps,
                    onOlTap: onOlTap,
                  )
                : _buildBeginnerRatios(
                    match,
                    match.teams,
                    match.mhlu,
                    match.malu,
                    winAllHps,
                    onOlTap: onOlTap,
                  ),
            SizedBox(height: 4.w),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalGuessEntrance(num mcCount, bool isProfess) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: isProfess ? 22.w : 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$mcCount${mcCount > 0 ? '+' : ''}',
            style: TextStyle(
              fontSize: 10,
              color: Get.isDarkMode
                  ? AppColor.colorWhite.withOpacity(0.3)
                  : '#AFB3C8'.hexColor,
            ),
          ),
          ImageView(
            'assets/images/vr/icon_arrowright_nor.png',
            width: 12.w,
            height: 12.w,
            // AppColor.colorWhite
            color: Get.isDarkMode ? null : '#AFB3C8'.hexColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsAndRatios({
    required MatchEntity match,
    List<String> teams = const [],
    String malu = '',
    String mhlu = '',
    MatchHps? winAllHps,
    MatchHps? fieldGoalHps,
    MatchHps? fullFieldSizeHps,
    ValueChanged<MatchHpsHlOl?>? onOlTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: List.generate(
            teams.length,
            (index) => _buildTeam(
              teamName: teams[index],
              teamLogoSrc: index == 1 ? malu : mhlu,
            ).marginOnly(bottom: 0 == index ? 15 : 7),
          ),
        ).expanded(),
        _buildRatios(
          match: match,
          winAllHps: winAllHps,
          fieldGoalHps: fieldGoalHps,
          fullFieldSizeHps: fullFieldSizeHps,
          onOlTap: onOlTap,
        ).expanded(),
      ],
    );
  }

  Widget _buildBeginnerRatios(
    MatchEntity match,
    List<String> teams,
    String mhlu,
    String malu,
    MatchHps? winAllHps, {
    ValueChanged<MatchHpsHlOl?>? onOlTap,
  }) {
    final winAllHl = winAllHps?.hl.firstOrNull;
    final winAllOls = winAllHl?.ol ?? <MatchHpsHlOl>[];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  teams.firstOrNull ?? '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Get.isDarkMode
                        ? AppColor.colorWhite
                        : '#303442'.hexColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4.w),
                ImageView(
                  mhlu,
                  cdn: true,
                  width: 20.w,
                  height: 20.w,
                ),
              ],
            ),
            Text(
              'VS',
              style: TextStyle(
                fontSize: 12.sp,
                color:
                    Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
                fontWeight: FontWeight.w500,
              ),
            ).marginSymmetric(horizontal: 16.w),
            Row(
              children: [
                ImageView(
                  malu,
                  cdn: true,
                  width: 20.w,
                  height: 20.w,
                ),
                SizedBox(width: 4.w),
                Text(
                  teams.lastOrNull ?? '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Get.isDarkMode
                        ? AppColor.colorWhite
                        : '#303442'.hexColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ).marginSymmetric(vertical: 4.w),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            winAllOls.length,
            (index) {
              final ol = winAllOls[index];
              final olOvStr =
                  TYFormatOddsConversionMixin.computeValueByCurOddType(
                ol.ov,
                winAllHps?.hpid ?? '',
                winAllHps?.hsw.split(',') ?? [],
                int.tryParse(match.csid) ?? 0,
              );
              return VrCommonOddsBox(
                onTap: () {
                  if (widget.lockOdds) return;
                  if (winAllHps != null && winAllHl != null) {
                    OddsButtonState state = OddsButtonState.betState(
                      match.mhs,
                      winAllHl.hs,
                      ol.os,
                    );
                    if (state == OddsButtonState.open) {
                      onOlTap?.call(ol);
                      ShopCartController.to.addBet(
                        match,
                        winAllHps,
                        winAllHl,
                        ol,
                        betType: OddsBetType.vr,
                      );
                    }
                  }
                },
                padding: EdgeInsets.symmetric(vertical: 2.w),
                ol: ol,
                childBuilder: (isSelected) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: 32.w, minWidth: 90.w),
                    child: widget.lockOdds
                        ? Icon(
                            Icons.lock,
                            color: '#AFB3C8'.hexColor,
                            size: 20,
                          ).center
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ol.on,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSelected
                                      ? Get.isDarkMode
                                          ? Colors.white
                                          : '#127DCC'.hexColor
                                      : '#AFB3C8'.hexColor,
                                  height: 14 / 10,
                                ),
                              ),
                              Text(
                                olOvStr,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isSelected
                                      ? Get.isDarkMode
                                          ? Colors.white
                                          : '#127DCC'.hexColor
                                      : Get.isDarkMode
                                          ? AppColor.colorWhite
                                          : '#303442'.hexColor,
                                  fontWeight: FontWeight.w700,
                                  height: 16 / 12,
                                ),
                              ),
                            ],
                          ),
                  );
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 32.w, minWidth: 90.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ol.on,
                        style: TextStyle(
                          fontSize: 10,
                          color: '#AFB3C8'.hexColor,
                          height: 14 / 10,
                        ),
                      ),
                      Text(
                        olOvStr,
                        style: TextStyle(
                          fontSize: 12,
                          color: Get.isDarkMode
                              ? AppColor.colorWhite
                              : '#303442'.hexColor,
                          fontWeight: FontWeight.w700,
                          height: 16 / 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ).marginOnly(left: index == 0 ? 0 : 2.w);
            },
          ),
        ),
        SizedBox(height: 2.w),
      ],
    );
  }

  Widget _buildTeam({
    required String teamLogoSrc,
    required String teamName,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 0.w),
      child: Row(
        children: [
          ImageView(
            teamLogoSrc,
            cdn: true,
            width: 20.w,
            height: 20.w,
          ),
          SizedBox(width: 4.w),
          Text(
            teamName,
            style: TextStyle(
              fontSize: 12,
              color: Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatios({
    required MatchEntity match,
    required MatchHps? winAllHps,
    required MatchHps? fieldGoalHps,
    required MatchHps? fullFieldSizeHps,
    ValueChanged<MatchHpsHlOl?>? onOlTap,
  }) {
    final winAllHl = winAllHps?.hl.firstOrNull;
    final winAllOls = winAllHl?.ol ?? <MatchHpsHlOl>[];

    final fieldGoalHl = fieldGoalHps?.hl.firstOrNull;
    final fieldGoalOls = fieldGoalHl?.ol ?? <MatchHpsHlOl>[];

    final fullFieldSizeHl = fullFieldSizeHps?.hl.firstOrNull;
    final fullFieldSizeOls = fullFieldSizeHl?.ol ?? <MatchHpsHlOl>[];

    return Row(
      children: [
        Column(
          children: List.generate(
            winAllOls.length,
            (index) => _buildRatioItem(
              match: match,
              hps: winAllHps,
              hl: winAllHl,
              ol: winAllOls[index],
              onOlTap: onOlTap,
              heightFactor: winAllOls.length >= 3 ? 1 : 1.5,
              margin: index > 0 ? EdgeInsets.only(top: 2.w) : EdgeInsets.zero,
            ),
          ),
        ).expanded(),
        SizedBox(width: 2.w),
        Column(
          children: List.generate(
            fieldGoalOls.length,
            (index) => _buildRatioItem(
              match: match,
              hps: fieldGoalHps,
              hl: fieldGoalHl,
              ol: fieldGoalOls[index],
              onOlTap: onOlTap,
              heightFactor: fieldGoalOls.length >= 3 ? 1 : 1.5,
              margin: index > 0 ? EdgeInsets.only(top: 2.w) : EdgeInsets.zero,
            ),
          ),
        ).expanded(),
        SizedBox(width: 2.w),
        Column(
          children: List.generate(
            fullFieldSizeOls.length,
            (index) => _buildRatioItem(
              match: match,
              hps: fullFieldSizeHps,
              hl: fullFieldSizeHl,
              ol: fullFieldSizeOls[index],
              onOlTap: onOlTap,
              heightFactor: fullFieldSizeOls.length >= 3 ? 1 : 1.5,
              margin: index > 0 ? EdgeInsets.only(top: 2.w) : EdgeInsets.zero,
            ),
          ),
        ).expanded(),
      ],
    );
  }

  Widget _buildRatioItem({
    required MatchEntity? match,
    required MatchHps? hps,
    required MatchHpsHl? hl,
    required MatchHpsHlOl? ol,
    double heightFactor = 1,
    EdgeInsetsGeometry? margin,
    ValueChanged<MatchHpsHlOl?>? onOlTap,
  }) {
    final bool isSelected = _selOls.values.contains(ol);

    final olOvStr = TYFormatOddsConversionMixin.computeValueByCurOddType(
      ol?.ov ?? 0,
      hps?.hpid ?? '',
      hps?.hsw.split(',') ?? [],
      int.tryParse(match?.csid ?? '0') ?? 0,
    );
    return Container(
      margin: margin,
      child: VrCommonOddsBox(
        onTap: () {
          if (widget.lockOdds) return;
          if (match != null && hps != null && hl != null && ol != null) {
            OddsButtonState state = OddsButtonState.betState(
              match.mhs,
              hl.hs,
              ol.os,
            );
            if (state == OddsButtonState.open) {
              onOlTap?.call(ol);
              ShopCartController.to.addBet(
                match,
                hps,
                hl,
                ol,
                betType: OddsBetType.vr,
              );
            }
          }
        },
        width: double.infinity,
        height: 32.w * heightFactor,
        ol: ol,
        childBuilder: (isSelected) {
          if (widget.lockOdds) {
            return Icon(
              Icons.lock,
              color: '#AFB3C8'.hexColor,
              size: 20,
            ).center;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ol?.on ?? '',
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected
                      ? Get.isDarkMode
                          ? Colors.white
                          : '#127DCC'.hexColor
                      : '#AFB3C8'.hexColor,
                  height: 14 / 10,
                ),
              ),
              Text(
                olOvStr,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? Get.isDarkMode
                          ? Colors.white
                          : '#127DCC'.hexColor
                      : Get.isDarkMode
                          ? AppColor.colorWhite
                          : '#303442'.hexColor,
                  fontWeight: FontWeight.w700,
                  height: 16 / 12,
                ),
              ),
            ],
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ol?.on ?? '',
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? Get.isDarkMode
                        ? Colors.white
                        : '#127DCC'.hexColor
                    : '#AFB3C8'.hexColor,
                height: 14 / 10,
              ),
            ),
            Text(
              olOvStr,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? Get.isDarkMode
                        ? Colors.white
                        : '#127DCC'.hexColor
                    : Get.isDarkMode
                        ? AppColor.colorWhite
                        : '#303442'.hexColor,
                fontWeight: FontWeight.w700,
                height: 16 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
