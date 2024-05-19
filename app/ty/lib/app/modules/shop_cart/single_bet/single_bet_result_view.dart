import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_type.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../widgets/bet_item_widget.dart';
import '../widgets/bet_order_widget.dart';

class SingleBetResultView extends StatelessWidget {
  SingleBetResultView({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController!;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Obx(() {
            String titleImage;
            String titleText;
            switch (logic.betStatus.value) {
              case ShopCartBetStatus.Success:
                titleImage = 'assets/images/shopcart/order_status_standby1.png';
                titleText = LocaleKeys.app_h5_bet_bet_confirm.tr;
                break;
              case ShopCartBetStatus.Invalid: //TODO 盘口已失效
              case ShopCartBetStatus.Failure:
                titleImage = 'assets/images/shopcart/order_status_failure1.png';
                titleText = LocaleKeys.bet_bet_err.tr;
                break;
              case ShopCartBetStatus.PrebookSuccess:
                titleImage =
                    'assets/images/shopcart/order_status_prebook_success2.png';
                titleText = LocaleKeys.pre_record_booked.tr;
                break;
              case ShopCartBetStatus.Prebooking:
                titleImage = 'assets/images/shopcart/order_status_standby1.png';
                titleText = LocaleKeys.pre_record_booking.tr;
                break;
              case ShopCartBetStatus.Betting:
              default:
                // TODO: Handle this case.
              titleImage = 'assets/images/shopcart/order_status_success1.png';
                titleText = LocaleKeys.bet_bet_loading.tr;
                break;
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  padding: EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                    color: Color(0x0A179CFF),
                    shape: OvalBorder(),
                  ),
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: ShapeDecoration(
                      color: Color(0x0F179CFF),
                      shape: OvalBorder(),
                    ),
                    child: ImageView(
                      titleImage,
                      width: 140.sp,
                      height: 140.sp,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  titleText,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF179CFF),
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if(logic.betStatus.value == ShopCartBetStatus.PrebookSuccess)
                  ...[
                    const SizedBox(height: 8),
                    Text(
                      LocaleKeys.pre_record_booked_tips.tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF179CFF),
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
              ],
            );
          }),
        ),
        BetItemWidget(
          logic!.itemList.first,
          orderDetailResp: logic!.orderRespList.safeFirst,
        ),
        BetOrderWidget(
            logic!.orderRespList.safeFirst ?? BetResultOrderDetailRespList()),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                  child: Text(
                    LocaleKeys.app_h5_bet_confirm.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
