import 'package:flutter_ty_app/app/core/format/index.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/widgets/bet_question_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../global/user_controller.dart';
import '../model/shop_cart_type.dart';
import '../shop_cart_controller.dart';
import '../widgets/auto_accept_widget.dart';
import '../widgets/bet_input_widget.dart';
import '../widgets/bet_item_widget.dart';
import '../widgets/bet_slide_widget.dart';
import '../widgets/number_keyboard.dart';
import '../widgets/shop_cart_ball.dart';
import '../widgets/shop_cart_head.dart';
import 'mix_bet_controller.dart';
import 'mix_bet_result_view.dart';

class MixBetComponent<T extends BaseBetController> extends StatelessWidget {
  MixBetComponent({Key? key}) : super(key: key);

  final logic = ShopCartController.to.currentBetController! as MixBetController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (logic.itemCount > 0) {
        if (logic.state.showShopCart.value) {
          return Stack(
            children: [
              //灰色背景
              GestureDetector(
                onTap: () {
                  logic.closeBet();
                },
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
              //投注框
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: 1.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildCloseButton(),
                          Obx(() {
                            if (logic.betStatus.value ==
                                ShopCartBetStatus.Normal) {
                              return _buildBetView(context);
                            } else if (logic.betStatus.value ==
                                    ShopCartBetStatus.Betting ||
                                logic.betStatus.value ==
                                    ShopCartBetStatus.Success ||
                                logic.betStatus.value ==
                                    ShopCartBetStatus.Failure) {
                              return MixBetResultComponent();
                            } else {
                              return Container();
                            }
                          }),
                        ],
                      )))
            ],
          );
        } else {
          if (!logic.state.isMaintabDialogicOpen.value) {
            //显示收拢球
            return Positioned(bottom: 100, right: 10, child: ShopCartBall());
          } else {
            return Container();
          }
        }
      } else {
        return Container();
      }
    });
  }

  Widget _buildCloseButton() {
    return InkWell(
      onTap: () {
        logic.closeBet();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: Get.theme.shopcartCloseButtonColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child:Icon(Icons.close_outlined,color:Colors.white,size: 20,),
          )
      ),
    );
  }

  Widget _buildBetView(BuildContext context) {
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      child: Stack(
        children: [
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShopCartHead(LocaleKeys.app_h5_bet_parlay.tr),
                Flexible(
                  child: SingleChildScrollView(
                    controller: logic.scrollController,
                    child: Column(children: [
                      ...logic.itemList
                          .map((element) => BetItemWidget(
                                element,
                                isParlay: true,
                              ))
                          .toList(),
                      _buildInputWidget(context),
                      if (logic.itemCount < logic.maxSeriesNum)
                        _buildAddWidget(context),
                    ]),
                  ),
                ),
                GetBuilder<T>(
                    id: "keyboard",
                    init: logic as T,
                    builder: (controller) {
                      if (controller.showKeyBoard) {
                        return NumberKeyboard(
                          currentValue: controller.amountController.text,
                          onTextInput: (myText) {
                            controller.insertText(myText);
                          },
                          onTextSet: (myText) {
                            controller.replaceText(myText);
                          },
                          onBackspace: () {
                            controller.backspace();
                          },
                          onCollapse: () {
                            controller.keyboardVisiable(false);
                          },
                          onMaxValue: () {
                            controller.maxInputText();
                          },
                          quickValues: logic.userCvoMoney,
                        );
                      } else {
                        return Container();
                      }
                    }),
                AutoAcceptWidget(),
                _buildBetButton(context),
              ]),
          Positioned(
            bottom: 50.h + 16 + 16.sp + 16 + (logic.showKeyBoard ? 200 : 0) + 5,
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
        ],
      ),
    );
  }

  Widget _buildInputWidget(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Obx(() {
      return Column(
        children: logic.betSpecialSeries.asMap().entries.map((e) {
          final element = e.value;
          final index = e.key;
          FocusNode focusNode = logic.amountFocusNodeList[index];
          TextEditingController textEditingController =
              logic.amountControllerList[index];
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              decoration: ShapeDecoration(
                color: themeData.shopcartContentBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal:12,vertical: 8),
                      child:Row(
                        children: [
                          Expanded(
                              flex: 10,
                              child: Row(
                                children: [
                                  BetQuestionWidget(element),
                                  const SizedBox(width: 2),
                                  Text(
                                    //element.name.replaceAll('串', LocaleKeys.app_h5_bet_toltipc.tr),
                                    element.localeName.tr,
                                    style: TextStyle(
                                      color: themeData.shopcartTextColor,
                                      fontSize: 14.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 11,
                              child: Row(children: [
                                Text(
                                  element.count.toString() + 'x',
                                  style: TextStyle(
                                    color: themeData.shopcartLabelColor,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                    child: GetBuilder<T>(
                                        id: "input",
                                        init: logic as T,
                                        builder: (controller) {
                                          return BetInputWidget(
                                            textEditingController,
                                            focusNode,
                                            logic.minValueOfSerie(index),
                                            logic.maxValueOfSerie(index),
                                            themeData.shopcartBackgroundColor,
                                            focusColor: themeData.shopcartInputBorderFocusColor,
                                            unfocusColor: themeData.shopcartInputBorderUnfocusColor,
                                            textAlign: TextAlign.end,
                                            height: 32,
                                            borderRadius: 8,
                                          );
                                        })),
                              ]))
                        ],
                      ),
                  ),
                  GetBuilder<T>(
                      id: "input_total",
                      init: logic as T,
                      builder: (controller) {
                        if (focusNode.hasFocus ||
                            textEditingController.text.length > 0) {
                          double inputAmount = double.tryParse(
                                  logic.amountControllerList[index].text) ??
                              0.0;
                          String inputSummy = TYFormatMoney.formatMoney(
                              inputAmount *
                                  logic.betSpecialSeries[index].count);
                          String profitAmount = TYFormatMoney.formatMoney(
                              logic.profitAmount(index));
                          return Container(
                              padding:
                                  EdgeInsets.only(top: 4, left: 16, right: 16,bottom: 6),
                              height: 16.sp + 10,
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Get.theme.shopcartDividerColor,
                                      width: 0.5,
                                    ),
                                  ),
                              ),
                              child: Row(

                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child:FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child:RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${LocaleKeys.app_h5_bet_expect_win.tr}:',
                                              style: TextStyle(
                                                color: themeData.shopcartLabelColor,
                                                fontSize: 12.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: profitAmount + ' ',
                                              style: TextStyle(
                                                color: Color(0xFFF53F3F),
                                                fontSize: 12.sp,
                                                fontFamily: 'Akrobat',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: UserController.to.currCurrency(),
                                              style: TextStyle(
                                                color: themeData.shopcartLabelColor,
                                                fontSize: 12.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  ),
                                  Expanded(
                                    child:FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerRight,
                                      child:RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: LocaleKeys.bet_sum2.tr + ':',
                                              style: TextStyle(
                                                color: themeData.shopcartLabelColor,
                                                fontSize: 12.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: inputSummy+' ',
                                              style: TextStyle(
                                                color: themeData.shopcartLabelColor,
                                                fontSize: 12.sp,
                                                fontFamily: 'Akrobat',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: UserController.to.currCurrency(),
                                              style: TextStyle(
                                                color: themeData.shopcartLabelColor,
                                                fontSize: 12.sp,
                                                fontFamily: 'PingFang SC',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  ),
                                ],
                              ));
                        } else {
                          return Container();
                        }
                      })
                ],
              ));
        }).toList(),
      );
    });
  }

  Widget _buildAddWidget(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return InkWell(
        onTap: () {
          logic!.closeBet();
        },
        child: Container(
          height: 46,
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: themeData.shopcartContentBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageView(
                'assets/images/shopcart/add_event.png',
                width: 18,
                height: 18,
                color: const Color(0xFF179CFF),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                LocaleKeys.app_h5_bet_add_event.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF179CFF),
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildBetButton(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                logic.clearData();
              },
              child: Container(
                width: 50.h,
                height: 50.h,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: themeData.shopcartParlayChangeBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.h),
                  ),
                ),
                child: ImageView(
                  'assets/images/shopcart/bet_clear1.png',
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: BetSlideWidget(
                profitOrTotal: 2,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              child: Container(
                width: 50.h,
                height: 50.h,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.symmetric(horizontal: 5.h),
                decoration: ShapeDecoration(
                  color: themeData.shopcartParlayChangeBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.h),
                  ),
                ),
                child: Text(
                  LocaleKeys.common_single.tr.replaceAll('投注','\n投注'),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xFF179CFF),
                    fontSize: 14.h,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: () {
                logic!.goSingle();
              },
            ),
          ],
        ));
  }
}
