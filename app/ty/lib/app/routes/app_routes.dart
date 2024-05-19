part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static final AppRouteObserver observer = AppRouteObserver();
  static List<String> history = [];

  ///SDK 入口
  static const home = _Paths.home;
  static const homeView = _Paths.homeView;

  static const mainTab = _Paths.mainTab;

  ///启动页
  static const splash = _Paths.splash;

  ///模拟登录
  static const login = _Paths.login;
  // token 过期
  static const tokenExpired = _Paths.tokenExpired;
  // 日志
  static const appLogger = _Paths.appLogger;

  /// 赛果
  static const matchResults = _Paths.matchResults;

  /// 赛果详情
  static const matchResultsDetails = _Paths.matchResultsDetails;

  /// 规则说明
  static const ruleDescription = _Paths.ruleDescription;

  /// 公告中心
  static const noticeCenter = _Paths.noticeCenter;

  /// 盘口教程
  static const tutorial = _Paths.tutorial;

  /// 赛事详情
  static const matchDetail = _Paths.matchDetail;

  /// 国际化语言切换
  static const language = _Paths.language;

  /// 大小球模拟训练
  static const simulationTraining = _Paths.simulationTraining;
  static const CHAMPION = _Paths.CHAMPION;
  static const DJView = _Paths.DJView;

  ///每日活动
  static const dailyActivities = _Paths.dailyActivities;

  ///自定义快捷投注金额
  static const quickBetAmount = _Paths.quickBetAmount;

  ///一键投注
  static const oneClickBetting = _Paths.oneClickBetting;

  // VR
  static const vrHomePage = _Paths.vrHomePage;
  static const vrLivingPage = _Paths.vrLivingPage;
  static const vrSportDetail = _Paths.vrSportDetail;
  static const vrCompetitionDetailPage = _Paths.vrCompetitionDetailPage;
}

abstract class _Paths {
  _Paths._();

  static const home = '/home';
  static const homeView = '/HomeView';
  static const login = '/login';
  static const splash = '/splash';
  static const mainTab = '/mainTab';
  static const matchResults = '/matchResults';
  static const matchResultsDetails = '/matchResultsDetails';
  static const ruleDescription = '/ruleDescription';
  static const noticeCenter = '/noticeCenter';
  static const tutorial = '/tutorial';
  static const matchDetail = '/matchDetail';
  static const language = '/language';
  static const simulationTraining = '/simulationTraining';
  static const vrHomePage = '/vrHomePage';
  static const vrLivingPage = '/vrLivingPage';
  static const vrCompetitionDetailPage = '/vrCompetitionDetailPage';
  static const vrSportDetail = '/vrSportDetail';
  static const CHAMPION = '/champion';
  static const DJView = '/djView';
  static const dailyActivities = '/dailyActivities';
  static const quickBetAmount = '/quickBetAmount';
  static const tokenExpired = '/tokenExpired';
  static const oneClickBetting = '/oneClickBetting';
  static const appLogger = '/appLogger';
}
