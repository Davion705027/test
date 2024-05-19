import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/base/base_bet_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_theme.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/single_bet/single_bet_landscape_result_view.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/widgets/number_keyboard_landscape.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../../../core/format/common/module/format-currency.dart';
import '../../../global/user_controller.dart';
import '../../../services/models/res/bet_result_entity.dart';
import '../shop_cart_util.dart';
import '../../../widgets/image_view.dart';
import '../../../../generated/locales.g.dart';
import '../model/shop_cart_type.dart';
import '../widgets/balance_refresh_widget.dart';
import 'single_bet_controller.dart';


class SingleBetLandscapeComponent<T extends BaseBetController> extends StatelessWidget {
  SingleBetLandscapeComponent({Key? key}) : super(key: key);

  final  logic = ShopCartController.to.currentBetController as SingleBetController;
  final state = ShopCartController.to.state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (logic.itemCount > 0) {
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
                  color: Colors.black.withOpacity(0.0),
                ),
              ),

              Positioned(
                  bottom: 0,
                  right: 0,
                  child:Container(
                    width: 375,
                    height: 1.sh,
                    child:Stack(
                        children: [
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: () {
                                logic.closeBet();
                              },
                              child: Container(
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child:Container(
                              width: 375,
                              //height: 275,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF353537),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned.fill(
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        gradient: RadialGradient(
                                          colors: [
                                            Color(0xFF555547), // 中心最亮的颜色
                                            Color(0xFF353537),  // 其他颜色
                                          ],
                                          stops: [0.1, 1.0],
                                          radius: 0.7,
                                          center: Alignment.center,
                                        ),
                                      ),
                                    ),

                                  ),

                                  Obx(() {
                                    if (logic.betStatus.value ==
                                        ShopCartBetStatus.Normal) {
                                      return _buildBetView(context);
                                    }else if (logic.betStatus.value == ShopCartBetStatus.Betting
                                        ||  logic.betStatus.value == ShopCartBetStatus.Success
                                        || logic.betStatus.value == ShopCartBetStatus.Failure) {
                                      return SingleBetLandscapeResultView();
                                    }else{
                                      return Container();
                                    }
                                  }
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
              )
            ],

        );
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
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        //child: const ImageView('assets/images/shopcart/icon_close_white.svg', width: 18,height: 18,),
          child:Icon(Icons.close_outlined,color:Colors.white,size: 16,),
      ),
    );
  }

  Widget _buildBetView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBetItem(),
        _buildInputWidget(),
        _buildKeyboardWidget(),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget _buildBetItem() {
    ShopCartItem shopCartItem = logic!.itemList.safeFirst!;
    if(shopCartItem.isColsed){
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
          ),
          child: Row(

              children: [
                _buildCloseButton(),
                Expanded(
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageView('assets/images/shopcart/closed_pic1.png',width: 36,),
                        const SizedBox(width: 4),
                        Text(
                          LocaleKeys.bet_close.tr,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]
                  ),
                ),

              ]
          )
      );
    }else {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
          ),
          child: Row(
            children: [
              _buildCloseButton(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child:FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Container(
                                    width: 2,
                                    height: 16,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF127DCC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1.50),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Obx(()=>Text(
                                    '${shopCartItem.handicap} ${shopCartItem.handicapHv.value}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(() {
                            final oddColor = shopCartItem.oddStateType.value ==
                                OddStateType.oddUp
                                ? Color(0xFFF53F3F)
                                : shopCartItem.oddStateType.value ==
                                OddStateType.oddDown
                                ? Color(0xFF00B42A)
                                : Colors.white.withOpacity(0.9);
                            return Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '@',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: oddColor,
                                      fontSize: 14,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w600,

                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    shopCartItem.oddFinally.value,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: oddColor,
                                      fontSize: 16,
                                      fontFamily: 'Akrobat',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child:FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 6),
                                    Text(
                                      shopCartItem.playName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 12,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,

                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    if(shopCartItem.sportId == 1)
                                      ...[Text(
                                        shopCartItem.markScore,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 12,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                        const SizedBox(width: 2),
                                      ],
                                  ],
                                ),
                              ),
                            ),
                            Obx(() {
                              final oddColor = shopCartItem.oddStateType
                                  .value == OddStateType.oddUp ? Color(
                                  0xFFF53F3F) : shopCartItem.oddStateType
                                  .value == OddStateType.oddDown ? Color(
                                  0xFF00B42A) : Colors.white.withOpacity(0.9);
                              return Container(
                                child: shopCartItem.oddStateType.value !=
                                    OddStateType.none ? Text(
                                  LocaleKeys.common_odds_change.tr,
                                  style: TextStyle(
                                    color: oddColor,
                                    fontSize: 12,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ) : null,
                              );
                            }),
                          ],
                        )

                    ),

                  ],
                ),
              )
            ],
          )
      );
    }
  }


  Widget _buildInputWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(()=>Text(
                      '${LocaleKeys.common_money.tr}: ${TYFormatCurrency.formatCurrency(UserController.to.balanceAmount.value)} ${LocaleKeys.common_unit.tr}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,

                      ),
                    )
                    ),
                    const SizedBox(width: 4),
                    BalanceRefreshWidget(width:16,height:16),
                  ],
                ),
                GetBuilder(
                    id: "input",
                    init:logic,
                    builder: (controller) {
                      double maxValue = double.tryParse(logic!.maxValue)??0.0;
                      //maxValue = min(maxValue,UserController.to.balanceAmount.value);
                      return Text(
                        '${LocaleKeys.bet_bet_val2.tr}: ${TYFormatCurrency.formatCurrency(maxValue)} ${LocaleKeys
                            .common_unit.tr}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withOpacity(0.08),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: logic.amountController,
                    focusNode: logic.amountFocusNode,
                    style: TextStyle(
                        fontSize: 14,
                        color:Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500
                    ),
                    //autofocus: true,
                    enableInteractiveSelection: false,
                    showCursor: true,
                    readOnly: true,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:BorderSide(
                          color:  Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:BorderSide(
                          color:  Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      hintText:LocaleKeys.bet_input_v2.tr,
                      //hintText:'${LocaleKeys.app_h5_bet_limit.tr} ${TYFormatCurrency.formatCurrency(double.tryParse(logic.minValue)??0.0)}-${TYFormatCurrency.formatCurrency(double.tryParse(logic.maxValue)??0.0)}',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.2),
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Text(
                  LocaleKeys.common_unit.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${LocaleKeys.bet_bet_win.tr}: ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      Obx(() {
                        String winTotal = TYFormatCurrency
                            .formatCurrency(
                            logic!.profitAmount(0));
                        return Text(
                          winTotal,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        );

                      }),
                      Text(
                        LocaleKeys.common_unit.tr,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageView('assets/images/shopcart/icon_question_nor2.png', width: 12,
                        onTap: (){
                          _buildAutoAcceptTips();
                        },
                      ),
                      const SizedBox(width: 2),
                      InkWell(
                        onTap: () async{
                          await UserController.to.setUserPersonalise(toAccept: UserController.to.userPersonaliseEntity.toAccept == '1'?'0':'1');
                          UserController.to.update(['auto_accept']);
                        },
                        child:Container(
                          width:130,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child:FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                LocaleKeys.bet_bet_auto_msg_1.tr,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ))),
                              const SizedBox(width: 2),
                              GetBuilder<UserController>(
                                  id: "auto_accept",
                                  init: UserController.to,
                                  builder: (controller) {
                                    return  Container(
                                      width: 14,
                                      height: 14,
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
                                  }
                              ),
                            ]
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardWidget(){
    return Obx(() {
      List<Color> colors = [Color(0XFF179CFF), Color(0XFF45B0FF)];

      return NumberKeyboardLandscape(
        onTextInput: (myText) {
          logic.insertText(myText);
        },
        onBackspace: () {
          logic.backspace();
        },
        onBet: () async {
          bool result = await logic.doBet();
        },
        isBetEnabled:!logic!.isSpecialState,
      );
    }
    );
  }

  void _buildAutoAcceptTips(){

      showToastWidget(
        Stack(
            children: [
              //灰色背景
              GestureDetector(
                onTap: () {
                  dismissAllToast(showAnim:true);
                },
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              Center(child:Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF303442),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: 0.4.sw,
                  padding: EdgeInsets.all(20),
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(LocaleKeys.app_combine_bets_tips.tr,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(LocaleKeys.app_combine_bets_msg2.tr,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          dismissAllToast(showAnim:true);
                        },
                        child: Text(LocaleKeys.ac_rules_understand.tr,
                          style: const TextStyle(
                            color: Color(0xFF179CFF),
                            fontSize: 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    ],
                  )
              ),
              ),
            ]
        ),
        duration: Duration(hours: 1),
        handleTouch:true,
      );
    }

}
