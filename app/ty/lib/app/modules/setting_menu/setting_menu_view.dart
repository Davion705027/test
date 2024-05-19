import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/assets/preloadImg.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/widgets/menu_switch_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/widgets/menu_widget.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import 'setting_menu_controller.dart';

class SettingMenuPage extends StatefulWidget {
  const SettingMenuPage({Key? key}) : super(key: key);

  @override
  State<SettingMenuPage> createState() => _SettingMenuPageState();
}

class _SettingMenuPageState extends State<SettingMenuPage> {
  final controller = Get.find<SettingMenuController>();
  final logic = Get.find<SettingMenuController>().logic;

  @override
  Widget build(BuildContext context) {
    PreloadImg.preloadOnSetting(context);
    return GetBuilder<SettingMenuController>(
      builder: (controller) {
        return Container(
          color: controller.isDarkMode
              ? const Color(0xFF1E2029)
              : const Color(0xFFF2F2F6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  return ConfigController.to.accessConfig.value.filterSwitch
                      ? Column(
                          children: [
                            //联赛删选
                            _leagueDeletion(),
                            Container(
                              height: 10,
                            )
                          ],
                        )
                      : Container();
                }),
                //投注模式
                _bettingMode(),
                //排序规则
                _sortingRules(),
                //盘口设置
                _handicapSettings(),
                //主题风格
                _themeStyle(),
                //每日活动
                _dailyActivities(),
                //自定义快捷投注金额
                _customBetAmount(),
                //一键投注
                _oneClickBetting(),
                //选择语言
                _chooseLanguage(),
                //盘口教程
                _handicapTutorial(),
                //规则说明
                _ruleDescription(),

                // 公告中心
                _noticeCenter(),

                // 日志管理 不需要上生产
                _appLogger(),
                //退出登录
                _signOut(),
                //关闭
                _close(),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _appLogger(){
    return MenuWidget(
      onTap: () => controller.toAppLogger(),
      title: '日志管理',
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
    );
  }

  //联赛删选
  Widget _leagueDeletion() {
    return MenuWidget(
      onTap: () => controller.onLeagueFilter(),
      title: LocaleKeys.footer_menu_league_filter.tr,
      summary: LeagueManager.tid.isEmpty
          ? LocaleKeys.footer_menu_all.tr
          : '( ${LocaleKeys.footer_menu_selected.tr}${LeagueManager.tid.length})',
      subTitle: LocaleKeys.footer_menu_more.tr,
      imageUrl: "assets/images/icon/league_icon.png",
      isDark: controller.isDarkMode,
      dividing: false,
    );
  }

  //投注模式
  Widget _bettingMode() {
    return MenuSwitchWidget(
      title: LocaleKeys.footer_menu_bet_model.tr,
      isDark: controller.isDarkMode,
      switchA: LocaleKeys.footer_menu_new_v.tr,
      switchAParameter: controller.bettingMode,
      switchAOnTap: () => controller.onBettingMode(1),
      switchB: LocaleKeys.footer_menu_pro_v.tr,
      switchBParameter: controller.bettingMode,
      switchBOnTap: () => controller.onBettingMode(2),
      dividing: false,
    );
  }

  //排序规则
  Widget _sortingRules() {
    return MenuSwitchWidget(
      title: LocaleKeys.footer_menu_sort_title.tr,
      isDark: controller.isDarkMode,
      switchA: LocaleKeys.footer_menu_hot.tr,
      switchAParameter: controller.sortingRules,
      switchAOnTap: () => controller.onSortingRules(1),
      switchB: LocaleKeys.footer_menu_time.tr,
      switchBParameter: controller.sortingRules,
      switchBOnTap: () => controller.onSortingRules(2),
      dividing: true,
    );
  }

  //盘口设置
  Widget _handicapSettings() {
    return MenuSwitchWidget(
        title: LocaleKeys.footer_menu_odds_set.tr,
        isDark: controller.isDarkMode,
        switchA: LocaleKeys.app_dec.tr,
        switchAParameter: controller.handicapSettings,
        switchAOnTap: () => controller.onHandicapSettings(1),
        switchB: LocaleKeys.app_hk.tr,
        switchBParameter: controller.handicapSettings,
        switchBOnTap: () => controller.onHandicapSettings(2),
        dividing: true,
        disableSwitch: controller.isChampion);
  }

  //主题风格
  Widget _themeStyle() {
    return MenuSwitchWidget(
      title: LocaleKeys.footer_menu_theme.tr,
      isDark: controller.isDarkMode,
      switchA: LocaleKeys.footer_menu_daytime.tr,
      switchAParameter: controller.themeStyle,
      switchAOnTap: () => controller.onThemeStyle(1),
      switchB: LocaleKeys.footer_menu_night.tr,
      switchBParameter: controller.themeStyle,
      switchBOnTap: () => controller.onThemeStyle(2),
      dividing: true,
    );
  }

  //每日活动
  Widget _dailyActivities() {
    return GetBuilder<SettingMenuController>(
      id: 'SettingMenuShowActivity',
      initState: (_) {},
      builder: (controller) {
        return controller.showActivity
            ? MenuSwitchWidget(
                title: LocaleKeys.app_h5_filter_daily_activities.tr,
                isDark: controller.isDarkMode,
                switchA: LocaleKeys.footer_menu_turn_on.tr,
                switchAParameter: controller.dailyActivities,
                switchAOnTap: () => controller.onDailyActivities(1),
                switchB: LocaleKeys.common_close.tr,
                switchBParameter: controller.dailyActivities,
                switchBOnTap: () => controller.onDailyActivities(2),
                dividing: true,
              )
            : Container();
      },
    );
  }

  //自定义投注金额
  Widget _customBetAmount() {
    return MenuWidget(
      onTap: () => controller.onCustomBetAmount(),
      title: LocaleKeys.app_h5_filter_customized_amount.tr,
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
    );
  }

  //一键投注
  Widget _oneClickBetting() {
    return MenuWidget(
      onTap: () => controller.onOneClickBetting(),
      title: LocaleKeys.bet_one_click_bet.tr,
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
    );
  }

  //盘口教程
  Widget _handicapTutorial() {
    return MenuWidget(
      onTap: () => controller.onTutorial(),
      title: LocaleKeys.app_h5_cathectic_handicap_tutorial.tr,
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
    );
  }

  //规则说明
  Widget _ruleDescription() {
    return MenuWidget(
      onTap: () => controller.toRuleDescription(),
      title: LocaleKeys.common_rule_description.tr,
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
    );
  }

  // 公告中心
  Widget _noticeCenter() {
    return MenuWidget(
      onTap: controller.toNoticeCenter,
      title: LocaleKeys.app_notice_center.tr,
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
    );
  }

  //选择语言
  Widget _chooseLanguage() {
    return MenuWidget(
      onTap: () => controller.toLanguage(),
      title: LocaleKeys.setting_menu_chan_lan.tr,
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
    );
  }

  //退出登录
  Widget _signOut() {
    return MenuWidget(
      onTap: () => controller.toSignOut(),
      title: LocaleKeys.app_signOut.tr,
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: '',
      summary: '',
      dividing: true,
    );
  }

  //关闭
  Widget _close() {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        height: 52.h,
        color: controller.isDarkMode
            ? Colors.white.withOpacity(0.03999999910593033)
            : Colors.white,
        margin: EdgeInsets.only(
          top: 10.h,
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.common_close.tr,
                style: TextStyle(
                  color: controller.isDarkMode
                      ? Colors.white.withOpacity(0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: 18.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SettingMenuController>();
    super.dispose();
  }
}
