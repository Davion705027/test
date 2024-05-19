import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../widgets/bet_item_widget.dart';
import '../widgets/bet_order_widget.dart';
import '../widgets/bet_series_order_widget.dart';
import 'mix_bet_controller.dart';

class MixBetResultComponent extends StatelessWidget {
  MixBetResultComponent({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController! as MixBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    //在绘制完后判断是否可滚动
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      logic.postFrameCallback();
    });
    return Container(
        constraints: BoxConstraints(
          maxHeight: 0.8.sh,
        ),
        padding: EdgeInsets.only(bottom: 30),
        decoration: ShapeDecoration(
          color: themeData.shopcartBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
        child: Stack(children: [
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Obx(() {
                    String titleImage;
                    String titleText;
                    switch (logic.betStatus.value) {
                      case ShopCartBetStatus.Success:
                        titleText = LocaleKeys.app_h5_bet_bet_confirm.tr;
                        titleImage =
                            'assets/images/shopcart/tandem_success1.png';
                        break;
                      case ShopCartBetStatus.Failure:
                        titleImage = 'assets/images/shopcart/tandem_failed1.png';
                        titleText = LocaleKeys.app_h5_bet_bet_error.tr;

                        break;
                      case ShopCartBetStatus.Betting:
                      default:
                        // TODO: Handle this case.
                        titleImage =
                            'assets/images/shopcart/tandem_success1.png';
                        titleText = LocaleKeys.bet_bet_loading.tr;
                        break;
                    }
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageView(
                          titleImage,
                          width: 20.sp,
                          height: 20.sp,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          titleText,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: themeData.shopcartTextColor,
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    controller: logic.scrollController,
                    child: Column(
                      children: [
                        ..._buildBetItems(),
                        ...logic!.seriesOrderRespList
                            .map((e) => BetSeriesOrderWidget(e))
                            .toList(),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: ShapeDecoration(
                    color: Color(0xFF179CFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      logic.clearData();
                      logic.closeBet();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() {
                                      String titleImage;
                                      String titleText;
                                      switch (logic.betStatus.value) {
                                        case ShopCartBetStatus.Success:
                                          titleText =
                                              LocaleKeys.app_h5_bet_bet_confirm.tr;
                                          break;
                                        case ShopCartBetStatus.Failure:
                                          titleText =
                                              LocaleKeys.bet_bet_err.tr;
                                          break;
                                        case ShopCartBetStatus.Betting:
                                        default:
                                          titleText = LocaleKeys.bet_bet_loading.tr;
                                          break;
                                      }
                                      return Text(
                                        titleText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: LocaleKeys.bet_sum.tr,
                                                style: TextStyle(
                                                  color: Colors.white.withOpacity(0.6),
                                                  fontSize: 14,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              WidgetSpan(
                                                alignment: PlaceholderAlignment.middle,
                                                child: Text(
                                                  TYFormatCurrency.formatCurrency(
                                                      logic.orderTotal / 100),
                                                  style: TextStyle(
                                                    color: Colors.white.withOpacity(0.6),
                                                    fontSize: 16,
                                                    fontFamily: 'Akrobat',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ]
                                        )
                                    ),
                                  ])
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(14, 0, 14, 12),
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: ShapeDecoration(
                    color: themeData.shopcartContentBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      logic.keepBet();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.app_h5_bet_keep_go_bet.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF179CFF),
                                    fontSize: 16,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
          Positioned(
            bottom: 120 + 5,
            left: (1.sw - 20) / 2,
            child: Obx(
              () => Offstage(
                offstage: !logic.showScrollFlag.value,
                child: ImageView(
                  "assets/images/shopcart/icon_scrolldown1.png",
                  //Assets.home.item.iconLock.path,
                  height: 20,
                  width: 20,
                  onTap: (){
                    logic.scrollController.animateTo(logic.scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.ease);
                  },
                ),
              ),
            ),
          ),
        ]));
  }

  List<Widget> _buildBetItems() {
    List<Widget> betItems = [];
    for (int i = 0; i < logic.itemList.length; i++) {
      BetResultOrderDetailRespList? orderResp;
      if (i < logic!.orderRespList.length) {
        orderResp = logic!.orderRespList[i];
      }
      betItems.add(BetItemWidget(
        logic.itemList[i],
        orderDetailResp: orderResp,
      ));
    }
    return betItems;
  }
}
