// ignore_for_file: unused_field, unused_element

import 'package:flutter_ty_app/app/core/format/project/module/format-odds-conversion-mixin.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/vr_bet/vr_mix_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/dog_horse_odds_row.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

class WaitingDogHorseRatioWidget extends StatefulWidget {
  const WaitingDogHorseRatioWidget({
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
  State<WaitingDogHorseRatioWidget> createState() =>
      _WaitingDogHorseRatioWidgetState();
}

class _WaitingDogHorseRatioWidgetState
    extends State<WaitingDogHorseRatioWidget> {
  int _championIndex = -1;
  final List<int> _topTwoIndexList = [];
  final List<int> _topThreeIndexList = [];

  // TODO: 可能需要存储到 MatchEntity 或者 VrHomeController 里面
  MatchHpsHlOl? _selsctedOl;

  MatchEntity? get _match => widget.vrMatch.matchs.firstOrNull;
  MatchHps? get _championHps =>
      _match?.hps.firstWhereOrNull((element) => element.hpn == '冠军');
  MatchHpsHl? get _championHl => _championHps?.hl.firstOrNull;
  List<MatchHpsHlOl> get _championOls => _championHl?.ol ?? [];

  MatchHps? get _topTwoHps =>
      _match?.hps.firstWhereOrNull((element) => element.hpn == '前二');
  MatchHpsHl? get _topTwoHl => _topTwoHps?.hl.firstOrNull;
  List<MatchHpsHlOl> get _topTwoOls => _topTwoHl?.ol ?? [];

  MatchHps? get _topThreeHps =>
      _match?.hps.firstWhereOrNull((element) => element.hpn == '前三');
  MatchHpsHl? get _topThreeHl => _topThreeHps?.hl.firstOrNull;
  List<MatchHpsHlOl> get _topThreeOls => _topThreeHl?.ol ?? [];

  MatchHps? get _oddEvenHps =>
      _match?.hps.firstWhereOrNull((element) => element.hpn == '单/双');
  MatchHpsHl? get _oddEvenHl => _oddEvenHps?.hl.firstOrNull;
  List<MatchHpsHlOl> get _oddEvenOls => _oddEvenHl?.ol ?? [];

  MatchHps? get _sizeHps =>
      _match?.hps.firstWhereOrNull((element) => element.hpn == '大/小');
  MatchHpsHl? get _sizeHl => _sizeHps?.hl.firstOrNull;
  List<MatchHpsHlOl> get _sizeOls => _sizeHl?.ol ?? [];

  @override
  Widget build(BuildContext context) {
    final hpsHpnList = _match?.hps.map((element) => element.hpn).toList() ?? [];

    final datas = [];
    for (var hpn in hpsHpnList) {
      final hps = _match?.hps.firstWhereOrNull((element) => element.hpn == hpn);
      final hl = hps?.hl.firstOrNull;
      final ols = hl?.ol ?? [];
      datas.add({
        'hpn': hpn,
        'hps': hps,
        'hl': hl,
        'ols': ols,
      });
    }

    return Column(
      children: datas.map((e) {
        final title = e['hpn'] ?? '';
        final hps = e['hps'];
        final hl = e['hl'];
        final ols = e['ols'] ?? [];
        return ols.isEmpty
            ? const SizedBox()
            : _buildItem(
                title: title,
                hps: hps,
                hl: hl,
                ols: ols,
                onOlSelected: (ol) {
                  // VR 串关才需要选中状态
                  if (ShopCartController.to.currentBetController
                      is! VrMixBetController) return;
                  // if (_selsctedOl != null && ol != _selsctedOl) {
                  //   // showToast('请选择其他赛事');
                  //   return;
                  // }
                  if (ol == _selsctedOl) {
                    _selsctedOl = null;
                  } else {
                    _selsctedOl = ol;
                  }

                  // if (mounted) setState(() {});
                },
                getOlIsSelected: (ol) {
                  return _selsctedOl == ol;
                },
              );
      }).toList(),
    );
  }

  Widget _oldBuild() {
    return Column(
      children: [
        if (_championOls.isNotEmpty)
          _buildItem(
            title: '冠军',
            hps: _championHps,
            hl: _championHl,
            ols: _championOls,
            onItemSelected: (index) {
              if (index == _championIndex) return;
              _championIndex = index;
              if (mounted) setState(() {});
            },
            getItemIsSelected: (index) {
              return _championIndex == index;
            },
          ),
        if (_topTwoOls.isNotEmpty)
          _buildItem(
            title: '前二',
            hps: _topTwoHps,
            hl: _topTwoHl,
            ols: _topTwoOls,
            onItemSelected: (index) {
              if (_topTwoIndexList.length >= 2) {
                _topTwoIndexList.removeAt(0);
              }
              _topTwoIndexList.add(index);
              if (mounted) setState(() {});
            },
            getItemIsSelected: (index) {
              return _topTwoIndexList.contains(index);
            },
          ),
        if (_topThreeOls.isNotEmpty)
          _buildItem(
            title: '前三',
            hps: _topThreeHps,
            hl: _topThreeHl,
            ols: _topThreeOls,
            onItemSelected: (index) {
              if (_topThreeIndexList.length >= 3) {
                _topThreeIndexList.removeAt(0);
              }
              _topThreeIndexList.add(index);
              if (mounted) setState(() {});
            },
            getItemIsSelected: (index) {
              return _topThreeIndexList.contains(index);
            },
          ),
        if (_oddEvenOls.isNotEmpty)
          _buildItem(
            title: '单/双',
            hps: _oddEvenHps,
            hl: _oddEvenHl,
            ols: _oddEvenOls,
            // isOddOrEven: true,
            onItemSelected: (index) {
              if (_topThreeIndexList.length >= 3) {
                _topThreeIndexList.removeAt(0);
              }
              _topThreeIndexList.add(index);
              if (mounted) setState(() {});
            },
            getItemIsSelected: (index) {
              return _topThreeIndexList.contains(index);
            },
          ),
        if (_sizeOls.isNotEmpty)
          _buildItem(
            title: '大/小',
            hps: _sizeHps,
            hl: _sizeHl,
            ols: _sizeOls,
            onItemSelected: (index) {
              if (_topThreeIndexList.length >= 3) {
                _topThreeIndexList.removeAt(0);
              }
              _topThreeIndexList.add(index);
              if (mounted) setState(() {});
            },
            getItemIsSelected: (index) {
              return _topThreeIndexList.contains(index);
            },
          ),
      ],
    );
  }

  Widget _buildItem({
    required String title,
    required MatchHps? hps,
    required MatchHpsHl? hl,
    required List<MatchHpsHlOl> ols,
    ValueChanged<int>? onItemSelected,
    bool Function(int index)? getItemIsSelected,
    ValueChanged<MatchHpsHlOl>? onOlSelected,
    bool Function(MatchHpsHlOl ol)? getOlIsSelected,
    // bool isOddOrEven = false,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.vrSportDetail,
          arguments: {
            'vrMatch': widget.vrMatch,
            'match': _match,
            'isBalls': false,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            _buildTotalGuessEntrance(title: title),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.w,
                crossAxisSpacing: 8.w,
                childAspectRatio: 178 / 40,
              ),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 8.w),
              itemCount: ols.length,
              itemBuilder: (BuildContext context, int index) {
                // final isSelected = getItemIsSelected?.call(index) == true;

                final ol = ols[index];
                // final isSelected = getOlIsSelected?.call(ol) == true;

                String title = ol.on;
                if (title.isEmpty && (_match?.teams.length ?? 0) > index) {
                  title = _match?.teams[index] ?? '';
                }

                final olStr =
                    TYFormatOddsConversionMixin.computeValueByCurOddType(
                  ol.ov,
                  hps?.hpid ?? '',
                  hps?.hsw.split(',') ?? [],
                  int.tryParse(_match?.csid ?? '0') ?? 0,
                );

                return GestureDetector(
                  onTap: () {
                    if (widget.lockOdds) return;
                    if (_match != null && hps != null && hl != null) {
                      OddsButtonState state = OddsButtonState.betState(
                        _match!.mhs,
                        hl.hs,
                        ol.os,
                      );
                      if (state == OddsButtonState.open) {
                        onItemSelected?.call(index);
                        onOlSelected?.call(ol);
                        ShopCartController.to.addBet(
                          _match!,
                          hps,
                          hl,
                          ol,
                          betType: OddsBetType.vr,
                        );
                      }
                    }
                  },
                  child: DogHorseOddsRow(
                    rank: index,
                    teamNum: '${index + 1}',
                    // isSelected: isSelected,
                    title: title,
                    subtitle: olStr,
                    ol: ol,
                    lockWidget: widget.lockOdds
                        ? Icon(
                            Icons.lock,
                            color: '#AFB3C8'.hexColor,
                            size: 20,
                          ).center
                        : null,
                  ),
                );
              },
            ),
            SizedBox(height: 4.w),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalGuessEntrance({
    required String title,
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 20.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Get.isDarkMode
                ? AppColor.dividerColorDark
                : AppColor.dividerColorLight,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(
                Routes.vrSportDetail,
                arguments: {
                  'vrMatch': widget.vrMatch,
                  'match': _match,
                  'isBalls': widget.type <= 2,
                },
              );
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    LocaleKeys.virtual_sports_show_all_markets.tr,
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
                    color: Get.isDarkMode ? null : '#AFB3C8'.hexColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
