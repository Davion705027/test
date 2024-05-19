import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../widgets/image_view.dart';
import '../shop_cart_controller.dart';

//自动接受最新赔率
class AutoAcceptWidget extends StatelessWidget {
  AutoAcceptWidget({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        height: 16.sp,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: InkWell(
          onTap: () async {
            await UserController.to.setUserPersonalise(
                toAccept:
                    UserController.to.userPersonaliseEntity.toAccept == '1'
                        ? '0'
                        : '1');
            UserController.to.update(['auto_accept']);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 16.sp,
                height: 16.sp,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 1,
                      child:  GetBuilder<UserController>(
                          id: "auto_accept",
                          init: UserController.to,
                          builder: (controller) {
                          return  Container(
                                width: 14.sp,
                                height: 14.sp,
                                decoration: BoxDecoration(
                                  color: UserController
                                      .to.userPersonaliseEntity.toAccept ==
                                      '1'?Color(0xFF179CFF):Colors.transparent,
                                  border:UserController
                                      .to.userPersonaliseEntity.toAccept ==
                                      '1'?Border.all(color: Color(0xFF179CFF), width: 1): Border.all(color: Colors.grey, width: 1),
                                  borderRadius:  BorderRadius.circular(4)
                                ),
                                child:UserController
                                    .to.userPersonaliseEntity.toAccept ==
                                    '1'?ImageView(
                                    'assets/images/shopcart/check.png',
                                    width: 14.sp):Container(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Text(
                LocaleKeys.bet_bet_auto_msg_1.tr,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: themeData.shopcartLabelColor,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }
}
