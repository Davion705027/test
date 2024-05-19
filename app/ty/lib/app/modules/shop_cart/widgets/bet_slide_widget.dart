import 'package:flutter_ty_app/app/core/format/common/module/format-currency.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';

import '../../../../generated/locales.g.dart';
import '../shop_cart_controller.dart';
import '../single_bet/single_prebook/single_prebook_controller.dart';

class BetSlideWidget extends StatefulWidget {
  BetSlideWidget({this.profitOrTotal = 1, this.isPrebook = false, Key? key})
      : super(key: key);
  int profitOrTotal; //1单关显示可盈，2串关显示合计
  bool isPrebook;

  @override
  _BetSlideState createState() => _BetSlideState();
}

class _BetSlideState extends State<BetSlideWidget> {
  double _positionX = 0.0;
  bool _isCompleted = false;
  bool _betting = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    //用isPrebook来区分预约投注
    final logic = widget.isPrebook
        ? Get.find<SinglePrebookController>()
        : ShopCartController.to.currentBetController;
    return Obx(() {
      List<Color> colors = [const Color(0XFF179CFF), const Color(0XFF45B0FF)];

      bool isSpecialState = logic!.isSpecialState;
      if (isSpecialState) {
        colors = [
          themeData.shopcartButtonDisableBackgroundColor,
          themeData.shopcartButtonDisableBackgroundColor
        ];
      }
      return Container(
          padding: EdgeInsets.all(3.h),
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.h),
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            double containerWidth = constraints.maxWidth;
            return GestureDetector(
                onHorizontalDragUpdate: !isSpecialState
                    ? (details) {
                        if (!_isCompleted) {
                          setState(() {
                            // 更新按钮位置
                            _positionX += details.primaryDelta!;
                            _positionX =
                                _positionX.clamp(0, containerWidth - 44.h);

                            // 判断是否拖到最右边，执行事件
                            if (_positionX >= containerWidth - 44.h - 0.1) {
                              _isCompleted = true;
                            }
                          });
                        }
                      }
                    : null,
                onHorizontalDragEnd: (details) async {
                  // 手势结束时，如果已完成，执行事件
                  if (_isCompleted) {
                    // 执行你的事件
                    if (!_betting) {
                      _betting = true;
                      bool result = await logic!.doBet();
                      _betting = false;
                      if (!result) {
                        setState(() {
                          _positionX = 0;
                        });
                        _isCompleted = false;
                      }
                    }
                  } else {
                    setState(() {
                      _positionX = 0;
                    });
                  }
                },
                child: Stack(
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(44.h + 4, 0, 14, 0),
                        height: 44.h,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child:FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  if (!isSpecialState)
                                    Text(
                                      widget.isPrebook
                                          ? LocaleKeys.bet_bet_book_confirm.tr
                                          : LocaleKeys.app_betting.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  else
                                    Text(
                                      logic!.specialStateReason,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  if (!isSpecialState)
                                    Opacity(
                                      opacity: 0.60,
                                      child: Obx(() {
                                        if (widget.profitOrTotal == 1) {
                                          String winTotal =
                                          TYFormatCurrency.formatCurrency(
                                              logic.profitAmount(0));
                                          return RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: LocaleKeys.app_h5_bet_bet_win.tr,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: winTotal,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                        fontFamily: 'Akrobat',
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          );
                                        } else {
                                          String inputTotal =
                                          TYFormatCurrency.formatCurrency(
                                              logic.inputTotal);
                                          return RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: LocaleKeys.bet_sum.tr,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'PingFang SC',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                      alignment: PlaceholderAlignment.middle,
                                                      child: Text(
                                                        inputTotal,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.sp,
                                                          fontFamily: 'Akrobat',
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                              )
                                          );
                                        }
                                      }),
                                    ),
                                ],
                              ),
                            )),
                            Row(
                              children: [
                                Opacity(
                                  opacity: 0.20,
                                  child: ImageView(
                                      'assets/images/shopcart/arrow_right_3.svg',
                                      width: 12.h),
                                ),
                                Opacity(
                                  opacity: 0.40,
                                  child: ImageView(
                                      'assets/images/shopcart/arrow_right_3.svg',
                                      width: 12.h),
                                ),
                                Opacity(
                                  opacity: 0.70,
                                  child: ImageView(
                                      'assets/images/shopcart/arrow_right_3.svg',
                                      width: 12.h),
                                )
                              ],
                            )
                          ],
                        )
                    ),
                    Positioned(
                        left: _positionX,
                        child: Container(
                          width: 44.h,
                          height: 44.h,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Opacity(
                                  opacity: 0.20,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 44.h,
                                    height: 44.h,
                                    decoration: ShapeDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      shape: const OvalBorder(),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0xCC000000),
                                          blurRadius: 20,
                                          offset: Offset(0, 6),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 3.h,
                                top: 3.h,
                                child: Container(
                                  width: 38.h,
                                  height: 38.h,
                                  decoration: ShapeDecoration(
                                    color: Colors.white.withOpacity(0.96),
                                    shape: const OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12.h,
                                top: 12.h,
                                child: Opacity(
                                  opacity: 0.80,
                                  child: Container(
                                    width: 20.h,
                                    height: 20.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 20.h,
                                            height: 20.h,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(),
                                            child: ImageView(
                                                'assets/images/shopcart/arrow_right.svg',
                                                color: isSpecialState
                                                    ? themeData
                                                        .shopcartButtonDisableBackgroundColor
                                                    : null,
                                                width: 8.h,
                                                height: 14.h,
                                                boxFit: BoxFit.none),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ));
          }));
    });
  }
}
