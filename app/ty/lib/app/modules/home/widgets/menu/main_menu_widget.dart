import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../setting_menu/league_filter/manager/league_manager.dart';

///赛事类型菜单
class MainMenuWidget extends StatefulWidget {
  const MainMenuWidget({super.key, required this.onValueChanged});

  final ValueChanged<MainMenu> onValueChanged;

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  final _tabs = MainMenu.menuList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          //SDK 返回按钮
          if(oBContext!=null)
            InkWell(
              onTap: () {
                Navigator.pop(oBContext!);
              },
              child: Container(
                margin:  EdgeInsets.only(
                  left: 10.w,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: context.isDarkMode? Colors.white :Colors.black,
                  size: 22.w,
                ),
              ),
            ),
          GetBuilder<HomeController>(builder: (controller) {
            return Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _tabs
                      .asMap()
                      .entries
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            widget.onValueChanged(e.value);
                            //更新联赛删选默认时间
                            DateTime now = DateTime.now();
                            LeagueManager.md = DateTime(now.year, now.month, now.day, 00, 00, 00).millisecondsSinceEpoch.toString();
                          },
                          child: Text(
                            'new_menu_${e.value.mi}'.tr,
                            style: e.value.mi == controller.homeState.menu.mi
                                ? TextStyle(
                                    color: const Color(0xFF127DCC),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  )
                                : TextStyle(
                                    color: const Color(0xFFAFB3C8),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                          ).paddingSymmetric(horizontal: 6),
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          }),
          _buildBalance(context),
        ],
      ),
    );
  }

  Widget _buildBalance(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Container(
        height: 22.h,
        padding: EdgeInsets.only(left: 6.w, right: 6.w, ),
        margin: EdgeInsets.only(left: 8.w),
        decoration: ShapeDecoration(
          color: context.isDarkMode? Colors.white.withOpacity(0.03999999910593033):const Color(0xFFF2F2F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            UserController.to.getBalance();
          },
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              ImageView('assets/images/home/icon_trans_nor.svg',
                  width: 16.w, height: 16.w),
              Container(
                width: 5.w,
              ),
              Text(
                controller.balance.value != null
                    ? controller.toAmountSplit(
                    controller.balance.value!.amount.toString())
                    : '-',
                style: TextStyle(
                  color: context.isDarkMode?const Color(0xE5FFFFFF):const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'DIN Alternate',
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
