import 'package:flutter_ty_app/app/modules/app_logger/app_logger_binding.dart';
import 'package:flutter_ty_app/app/modules/app_logger/app_logger_view.dart';
import 'package:flutter_ty_app/app/modules/login/login_binding.dart';
import 'package:flutter_ty_app/app/modules/login/login_view.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_binding.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_view.dart';
import 'package:flutter_ty_app/app/modules/result/result_binding.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_details_binding.dart';
import 'package:flutter_ty_app/app/modules/result/results_details/results_details_view.dart';
import 'package:flutter_ty_app/app/modules/sdk_home/sdk_home_binding.dart';
import 'package:flutter_ty_app/app/modules/sdk_home/sdk_home_view.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/daily_activities/daily_activities_binding.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/daily_activities/daily_activities_view.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/language/language_binding.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/language/language_view.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/notice_center/notice_center_binding.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/notice_center/notice_center_view.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/one_click_betting/one_click_betting_binding.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/one_click_betting/one_click_betting_view.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/quick_bet_amount/quick_bet_amount_binding.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/rule_description/rule_description_binding.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/rule_description/rule_description_view.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/simulation_training/simulation_training_binding.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/simulation_training/simulation_training_view.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/tutorial_binding.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/tutorial_view.dart';
import 'package:flutter_ty_app/app/modules/splash/splash_binding.dart';
import 'package:flutter_ty_app/app/modules/vr/bindings/vr_home_binding.dart';
import 'package:flutter_ty_app/app/modules/vr/views/competition_detail/vr_competition_detail_binding.dart';
import 'package:flutter_ty_app/app/modules/vr/views/competition_detail/vr_competition_detail_view.dart';
import 'package:flutter_ty_app/app/modules/vr/views/living/bindings/living_binding.dart';
import 'package:flutter_ty_app/app/modules/vr/views/living/view/living_view.dart';
import 'package:flutter_ty_app/app/modules/vr/views/vr_home_view.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/bindings/vr_sport_detail_binding.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/vr_sport_detail_view.dart';
import 'package:flutter_ty_app/app/routes/app_route_observer.dart';
import 'package:get/get.dart';

import '../modules/dj/bindings/dj_binding.dart';
import '../modules/dj/views/dj_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/match_detail/bindings/match_detail_binding.dart';
import '../modules/match_detail/views/match_detail_view.dart';
import '../modules/result/result_view.dart';
import '../modules/setting_menu/quick_bet_amount/quick_bet_amount_view.dart';
import '../modules/splash/splash_view.dart';
import '../modules/token_expired/token_expired_binding.dart';
import '../modules/token_expired/token_expired_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const init_APP = Routes.splash;
  static const init_SDK = Routes.home;

  static final routes = [
    /// sdk
    GetPage(
      name: _Paths.home,
      page: () => const SdkHomePage(),
      binding: SdkHomeBinding(),
    ),

    /// 启动页
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    ///模拟登陆
    GetPage(
      name: _Paths.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.homeView,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.mainTab,
      page: () => const MainTabPage(),
      binding: MainTabBinding(),
      transition: Transition.noTransition,
    ),

    /// 赛果
    GetPage(
      name: _Paths.matchResults,
      page: () => const ResultPage(),
      binding: ResultBinding(),
    ),

    /// 赛果详情
    GetPage(
      name: _Paths.matchResultsDetails,
      page: () => const ResultsDetailsPage(),
      binding: ResultsDetailsBinding(),
    ),

    /// 规则说明
    GetPage(
      name: _Paths.ruleDescription,
      page: () => const RuleDescriptionPage(),
      binding: RuleDescriptionBinding(),
    ),

    /// 公告中心
    GetPage(
      name: _Paths.noticeCenter,
      page: () => const NoticeCenterPage(),
      binding: NoticeCenterBinding(),
    ),

    /// 盘口教程
    GetPage(
      name: _Paths.tutorial,
      page: () => const TutorialPage(),
      binding: TutorialBinding(),
    ),

    /// 赛事详情
    GetPage(
      name: _Paths.matchDetail,
      page: () => const MatchDetailView(),
      binding: MatchDetailBinding(),
    ),
    GetPage(
      name: _Paths.vrSportDetail,
      page: () => const VrSportDetailPage(),
      binding: VrSportDetailBinding(),
    ),

    ///国际化语言切换
    GetPage(
      name: _Paths.language,
      page: () => const LanguagePage(),
      binding: LanguageBinding(),
    ),

    ///模拟练习
    GetPage(
      name: _Paths.simulationTraining,
      page: () => const SimulationTrainingPage(),
      binding: SimulationTrainingBinding(),
    ),
    GetPage(
      name: _Paths.vrHomePage,
      page: () => const VrHomeView(),
      binding: VrHomeBinding(),
    ),
    GetPage(
      name: _Paths.vrLivingPage,
      page: () => const VrLivingView(),
      binding: VrLivingBinding(),
    ),
    GetPage(
      name: _Paths.vrCompetitionDetailPage,
      page: () => const VrCompetitionDetailView(),
      binding: VrCompetitionDetailBinding(),
    ),
    GetPage(
      name: _Paths.DJView,
      page: () => DJView(),
      binding: DJBinding(),
    ),

    GetPage(
      name: _Paths.dailyActivities,
      page: () => const DailyActivitiesPage(),
      binding: DailyActivitiesBinding(),
    ),

    /// 自定义投注金额
    GetPage(
      name: _Paths.quickBetAmount,
      page: () => const QuickBetAmountPage(),
      binding: QuickBetAmountBinding(),
    ),

    ///toke 失效
    GetPage(
      name: _Paths.tokenExpired,
      page: () => const TokenExpiredPage(),
      binding: TokenExpiredBinding(),
    ),

    ///一键投注
    GetPage(
      name: _Paths.oneClickBetting,
      page: () => const OneClickBettingPage(),
      binding: OneClickBettingBinding(),
    ),
    // app 日志
    GetPage(
      name: _Paths.appLogger,
      page: () => const AppLoggerPage(),
      binding: AppLoggerBinding(),
    ),

  ];
}
