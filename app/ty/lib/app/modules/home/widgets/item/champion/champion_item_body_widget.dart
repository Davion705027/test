import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/champion/bet_button.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../../services/models/res/match_entity.dart';
import '../../../../match_detail/models/odds_button_enum.dart';
import '../../../../shop_cart/shop_cart_controller.dart';

/**
 * 冠军页面 item
 * */
class ChampionItemBodyWidget extends StatelessWidget {
  const ChampionItemBodyWidget(
      {super.key, required this.matchHps, required this.matchEntity});

  final MatchEntity matchEntity;
  final MatchHps matchHps;

  @override
  Widget build(BuildContext context) {
    double width = (Get.width - 26.w - 8.w) / 2;
    double height = 32.w;
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            GridView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.w,
                crossAxisSpacing: 8.w,
                childAspectRatio: width / height,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    ShopCartController.to.addBet(
                      matchEntity,
                      matchHps,
                      null,
                      matchHps.ol.elementAt(index),
                      betType: OddsBetType.guanjun,
                    );
                  },
                  child:  BetButton(
                    height: height,
                    width: width,
                    direction: BetButtonLayoutDirection.horizontal,
                    matchHpsHlOl: matchHps.ol.elementAt(index),
                  ),
                );
              },
              itemCount: matchHps.ol.length,
            ),
            SizedBox(
              height: 10.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      padding: EdgeInsets.only(bottom: 4.h, top: 2.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.isDarkMode
                ? Colors.white.withOpacity(0.07999999821186066)
                : const Color(0xFFE4E6F0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              matchHps.hps,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.8999999761581421)
                    : const Color(0xFF303442),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${DateUtil.formatDateMs(matchHps.hmed.toInt(), format: LocaleKeys.time7.tr)}${LocaleKeys.match_main_cut_off.tr}',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.30000001192092896)
                  : const Color(0xFFAFB3C8),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
