import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_bet_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/user_controller.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../../../utils/oss_util.dart';
import '../../match_detail/models/odds_button_enum.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../shop_cart_util.dart';

class BetItemWidget extends StatelessWidget {
  BetItemWidget(this.shopCartItem,
      {this.orderDetailResp, this.isParlay = false, Key? key})
      : super(key: key);
  ShopCartItem shopCartItem;
  BetResultOrderDetailRespList? orderDetailResp;
  bool isParlay;

  final logic = ShopCartController.to.currentBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Obx(() {
      return Container(
        margin: const EdgeInsets.fromLTRB(14, 2, 14, 2),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: logic!.betStatus.value == ShopCartBetStatus.Normal &&
                  (shopCartItem.isColsed ||
                      (isParlay && !shopCartItem.canParlay))
              ? themeData.shopcartClosedContentBackgroundColor
              : themeData.shopcartContentBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (shopCartItem.isColsed &&
                      (logic!.betStatus.value == ShopCartBetStatus.Normal || logic!.betStatus.value == ShopCartBetStatus.Prebook))
                    ..._buildClosedItem(context)
                  else
                    ..._buildNormalItem(context),
                ],
              ),
            ),
            if (isParlay)
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: ImageView(
                    Get.isDarkMode ?'assets/images/shopcart/item_remove_light.png':'assets/images/shopcart/item_remove_dark.png',
                    width: 30,
                    height: 20,
                    //boxFit: BoxFit.scaleDown,
                    onTap: () {
                      logic!.delShopCartItem(shopCartItem);
                    },
                  ),
              ),

          ],
        ),
      );
    });
  }

  List<Widget> _buildNormalItem(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return [
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                //height: 20,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //投注成功后的玩法名称用接口返回的
                      if (orderDetailResp != null)
                        Expanded(
                            child:Text(
                              orderDetailResp!.playOptionName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: themeData.shopcartTextColor,
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            )
                        )
                      else
                      //Vr 单独处理
                        if(shopCartItem.betType == OddsBetType.vr
                            && ['1002', '1011', '1009', '1010'].contains(shopCartItem.sportId)
                            && [20033,20034, 20035, 20036, 20037, 20038].contains(int.tryParse(shopCartItem.playId))
                        )
                          _buildVrHandicap(context)
                        else
                            Expanded(
                              child:Obx(()=>Text(
                                  '${shopCartItem.handicap} ${shopCartItem.handicapHv.value}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: themeData.shopcartTextColor,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),

              ),
            ),
            const SizedBox(width: 12),
            //投注成功后的玩法名称用接口返回的
            if (orderDetailResp != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '@',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: themeData.shopcartTextColor,
                      fontSize: 14.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    orderDetailResp!.oddsValues,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: themeData.shopcartTextColor,
                      fontSize: 22.sp,
                      fontFamily: 'Akrobat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            else
              ///投注弹框 赔率变更
              Obx(() {
                final oddColor = shopCartItem.oddStateType.value ==
                        OddStateType.oddUp
                    ? const Color(0xFFF53F3F)
                    : shopCartItem.oddStateType.value == OddStateType.oddDown
                        ? const Color(0xFF00B42A)
                        : themeData.shopcartTextColor;
                String oddsUpDownImageName =  shopCartItem.oddStateType.value == OddStateType.oddUp ? 'assets/images/detail/odds_up.svg':
                shopCartItem.oddStateType.value == OddStateType.oddDown ?
                'assets/images/detail/odds_down.svg' : '';
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '@',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: oddColor,
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      shopCartItem.oddFinally.value,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: oddColor,
                        fontSize: 22.sp,
                        fontFamily: 'Akrobat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ///升降图标
                   Visibility(
                       visible: oddsUpDownImageName.isNotEmpty,
                       child: Row(
                     children: [
                       const SizedBox(width: 2),
                       ImageView(
                         oddsUpDownImageName,
                         width: 10.w,
                       ),
                     ],
                   ))
                  ],
                );
              }),
          ],
        ),
      ),
      const SizedBox(height: 6),
      SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0XFF179CFF),
                      // Set the color of the bottom border
                      width: 2, // Set the width of the bottom border
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child:Wrap(
                              crossAxisAlignment : WrapCrossAlignment.center,
                              children: [
                                if (shopCartItem.matchType == 2) ...[
                                  Text(
                                    '(${LocaleKeys.bet_bet_inplay.tr})',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF179CFF),
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                ],
                                //投注成功后的玩法名称用接口返回的
                                if (orderDetailResp != null)
                                  Text(
                                    orderDetailResp!.playName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                else
                                  Text(
                                    shopCartItem.playName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                const SizedBox(width: 2),
                                if (shopCartItem.sportId == '1') ...[
                                  Text(
                                    shopCartItem.markScore,
                                    style: TextStyle(
                                      color: themeData.shopcartLabelColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                ],
                                Text(
                                  '(${UserController.to.curOddsLabel(shopCartItem.oddsHsw).tr})',
                                  style: TextStyle(
                                    color: const Color(0xFF179CFF),
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (orderDetailResp == null)
                            if (isParlay && !shopCartItem.canParlay)
                              Text(
                                LocaleKeys.app_h5_bet_no_support_collusion.tr,
                                style: TextStyle(
                                  color: const Color(0xFFF53F3F),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            else
                              Obx(() {
                                final oddColor =
                                    shopCartItem.oddStateType.value ==
                                            OddStateType.oddUp
                                        ? const Color(0xFFF53F3F)
                                        : shopCartItem.oddStateType.value ==
                                                OddStateType.oddDown
                                            ? const Color(0xFF00B42A)
                                            : themeData.shopcartTextColor;
                                return Container(
                                  child: shopCartItem.oddStateType.value !=
                                          OddStateType.none
                                      ? Text(
                                          LocaleKeys.common_odds_change.tr,
                                          style: TextStyle(
                                            color: oddColor,
                                            fontSize: 12.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : null,
                                );
                              }),
                        ],
                      ),
                    ),
                    if (shopCartItem.home.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                            children: [
                              Expanded(child:Text(
                                '${shopCartItem.home} VS ${shopCartItem.away} ${shopCartItem.matchType == 2 && shopCartItem.scoreHomeAway.isNotEmpty
                                    ? '(' + shopCartItem.scoreHomeAway + ')'
                                    : ''}',
                                style: TextStyle(
                                  color: themeData.shopcartLabelColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ),
                            ]
                        ),
                      ),
                    ],
                    if (logic is SingleBetController) ...[
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                            children: [
                              Expanded(
                                child:Text(
                                  shopCartItem.tidName,
                                  style: TextStyle(
                                    color: themeData.shopcartLabelColor,
                                    fontSize: 12.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            /*复刻版已去除
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: themeData.shopcartItemNumberBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '6',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: themeData.shopcartLabelColor,
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,

                      ),
                    ),
                  ),
                   */
          ],
        ),
      ),
    ];
  }

  Widget _buildVrHandicap(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final handicapHvArray = shopCartItem.handicapHv.value.split(',');
    final handicapArray = shopCartItem.handicap.split(',');
    List<Widget> handicapList = [];
    for(int i=0;i<handicapArray.length;i++){
      final text = handicapArray[i];
      String hv = '';
      if(i<handicapHvArray.length) {
        hv = handicapHvArray[i];
      }
      handicapList.add(Row(
        children: [
          if(hv.isNotEmpty)
            ImageView(
              'assets/images/vr/vr_dog_horse_rank${hv}.svg',
              width: 20.w,
              height: 20.w,
            ),
          const SizedBox(width: 2),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeData.shopcartTextColor,
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: handicapList,
    );
  }

  List<Widget> _buildClosedItem(BuildContext context) {
    return [
      SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: 74,
                height: 74,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      OssUtil.getServerPath(
                        'assets/images/shopcart/closed_bg2.png',
                      ),
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                child: const ImageView(
                  'assets/images/shopcart/closed_pic2.png',
                  width: 74,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                LocaleKeys.bet_close.tr,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFF7981A3),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ))
    ];
  }
}
