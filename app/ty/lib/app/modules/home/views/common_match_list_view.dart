import 'package:collection/collection.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/bet_title_group_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/item_body_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/seaction_header_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/sport_header_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

import '../../../global/data_store_operate/data_store_ctr_ws.dart';
import '../../../widgets/scroll_index_widget.dart';
import '../controllers/match_expand_controller.dart';
import '../logic/home_controller_logic.dart';
import '../widgets/item/noob/noon_item_body_widget.dart';
import '../widgets/item/profession/match_group_header_widget.dart';

var kFirstIndex = 0;
var kLastIndex = 10;

class CommonMatchListView extends StatefulWidget {
  const CommonMatchListView({super.key});

  @override
  State<CommonMatchListView> createState() => _CommonMatchListViewState();
}

class _CommonMatchListViewState extends State<CommonMatchListView> {
  late ScrollController _scrollController;
  bool showTop = false;
  List lastMidList = [];
  ///判断两个列表是否相同
  Function listEq = const ListEquality().equals;
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        _scrollListener();
      });
    ///初始化返回顶部
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Bus.getInstance().on(EventType.scrollToTop, (value) {
        if (mounted) {
          try {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut);
          } catch (e) {
            print(e);
          }
        }

      });
    });
    super.initState();

  }

  @override
  void dispose() {
    Bus.getInstance().off(EventType.scrollToTop);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    /// 超过一屏显示返回顶部按钮
    if (_scrollController.offset > MediaQuery.of(context).size.height) {
      if (!showTop) {
        setState(() {
          showTop = true;
        });
      }
    } else {
      if (showTop) {
        setState(() {
          showTop = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 在改变主题模式后恢复滚动位置
    if (_scrollController.hasClients) {
      double position = _scrollController.position.pixels;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(position);
      });
    }
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        color: context.isDarkMode ? null : const Color(0xfff2f2f6),
        child: Stack(
          children: [
            ///滚动监听控件
            ScrollIndexWidget(
              endCallBack: (bool endScroll) {
                HomeController.to.homeState.endScroll = endScroll;
              },
              callBack: (int firstIndex, int lastIndex) {
                kFirstIndex = firstIndex;
                kLastIndex = lastIndex;
                List<String> midList = [];
                midList = HomeControllerLogic.getNextMatchIds(
                  HomeController.to.homeState.combineList,
                  firstIndex,
                  lastIndex,
                );

                Future(() {
                  if (!listEq(lastMidList, midList)) {
                    ///此处不拦会重复调用，光用isFetching判断不够，难道能并行
                    HomeControllerLogic.preLoadNextMatchBaseInfoList(midList);
                    lastMidList = midList;
                  }
                });
              },
              child: _body(controller),
            ),
            if (showTop)
              Positioned(
                right: 14.w,
                bottom: 90,
                child: ImageView(
                  context.isDarkMode
                      ? 'assets/images/home/back_top_d.png'
                      : 'assets/images/home/back_top_l.png',
                  width: context.isDarkMode ? 30.w : 40.w,
                  height: context.isDarkMode ? 30.w : 40.w,
                  onTap: () {
                    ///滑动至指定位置
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
          ],
        ),
      );
    });
  }

  _body(HomeController controller) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      itemCount: controller.homeState.combineList.length,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
     // cacheExtent: 500.0, // 设置不可见区缓存范围
      itemBuilder: (BuildContext context, int index) {
        CombineInfo? combineInfo = controller.homeState.combineList.safe(index);
        if (combineInfo == null) return 0.verticalSpace;
        if (controller.homeState.isProfess) {
          /// 如果是大的分组标题  进行中 未开始等
          if (combineInfo.type == CombineType.sectionHeader) {
            return SectionHeaderWidget(
              isExpand:
                  !FoldMatchManager.isGroupFold(combineInfo.sectionGroupEnum!),
              onExpand: (value) {
                ///设置组折叠状态
                FoldMatchManager.setGroupFold(
                    combineInfo.sectionGroupEnum!, !value);
                ///子折叠
                HomeController.to.homeState.combineList.forEach((element) {
                  if (element.sectionGroupEnum ==
                      combineInfo.sectionGroupEnum) {
                    FoldMatchManager.setFoldByTid(
                        element.tid, element.sectionGroupEnum!, !value);
                  }
                });
                controller.update();
              },
              sectionGroupEnum: combineInfo.sectionGroupEnum!,
            );
          }
        /// 球种数量统计
          if (combineInfo.type == CombineType.sportHeader) {
            return SportHeaderWidget(
              title: '${combineInfo.sportTitle}(${combineInfo.sportCount})',
            );
          }

          if (combineInfo.type == CombineType.matchWithHeader) {
            bool isFold = FoldMatchManager.isFoldByTid(
                combineInfo.tid, combineInfo.sectionGroupEnum!);

            bool isClose = MatchDataBaseWS.closeMatch(
                mhs: combineInfo.data!.mhs,
                mmp: combineInfo.data!.mmp,
                ms: combineInfo.data!.ms);
            if (isClose) {
              return const SizedBox();
            }
            return Container(
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.03999999910593033)
                    : const Color(0xffF8F9FA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                  bottomLeft: combineInfo.isLastMatch || isFold
                      ? Radius.circular(8.r)
                      : Radius.zero,
                  bottomRight: combineInfo.isLastMatch || isFold
                      ? Radius.circular(8.r)
                      : Radius.zero,
                ),
                border: context.isDarkMode
                    ? null
                    : Border(
                        top: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        left: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        right: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        bottom: combineInfo.isLastMatch || isFold
                            ? const BorderSide(
                                color: Color(0xffFFFFFF),
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
              ),
              margin: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                  bottom: combineInfo.isLastMatch || isFold ? 8.w : 0),
              // padding: EdgeInsets.only(left: 8.w),
              child: Column(
                children: [
                  ///列表联赛标题
                  MatchGroupHeaderWidget(combineInfo: combineInfo),
                  ///没有折叠展示数据
                  if (!isFold)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          height: 0.4.w,
                          color: context.isDarkMode
                              ? Colors.white.withAlpha(10)
                              : const Color(0xffE4E6ED),
                        ),
                        ///列表sub标题 全场独赢\让球\大小等
                        BetTitleGroupWidget(
                          hps: combineInfo.data!.hps,
                          matchEntity: combineInfo.data!,
                        ).paddingOnly(bottom: 1.h),
                        ///body数据
                        ItemBodyWidget(
                          matchEntity: combineInfo.data!,
                        ),
                        if (combineInfo.isLastMatch) 2.verticalSpace,
                      ],
                    ),
                ],
              ),
            );
          }
      /// 没有头部等比赛展示
          if (combineInfo.type == CombineType.match) {
            bool isFold = FoldMatchManager.isFoldByTid(
                combineInfo.tid, combineInfo.sectionGroupEnum!);
            if (isFold) return 0.verticalSpace;
            return Container(
              margin: EdgeInsets.only(
                bottom: combineInfo.isLastMatch ? 8.w : 0,
                left: 5.w,
                right: 5.w,
              ),
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.03999999910593033)
                    : const Color(0xffF8F9FA),
                borderRadius: BorderRadius.only(
                  bottomLeft: combineInfo.isLastMatch
                      ? Radius.circular(4.r)
                      : Radius.zero,
                  bottomRight: combineInfo.isLastMatch
                      ? Radius.circular(4.r)
                      : Radius.zero,
                ),
                border: context.isDarkMode
                    ? null
                    : Border(
                        left: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        right: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        bottom: combineInfo.isLastMatch
                            ? const BorderSide(
                                color: Color(0xffFFFFFF),
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
              ),
              child: ItemBodyWidget(
                matchEntity: combineInfo.data!,
              ),
            );
          }

          return 0.verticalSpace;
        } else {
          ///新手版 赛事列表
          if (combineInfo.type == CombineType.sectionHeader) {
            return SectionHeaderWidget(
              isExpand:
                  !FoldMatchManager.isGroupFold(combineInfo.sectionGroupEnum!),
              onExpand: (value) {
                FoldMatchManager.setGroupFold(
                    combineInfo.sectionGroupEnum!, !value);
                HomeController.to.homeState.combineList.forEach((element) {
                  if (element.sectionGroupEnum ==
                      combineInfo.sectionGroupEnum) {
                    FoldMatchManager.setFoldByTid(
                        element.tid, element.sectionGroupEnum!, !value);
                  }
                });
                controller.update();
              },
              sectionGroupEnum: combineInfo.sectionGroupEnum!,
            );
          }

          if (combineInfo.type == CombineType.sportHeader) {
            return SportHeaderWidget(
              title: '${combineInfo.sportTitle}(${combineInfo.sportCount})',
            );
          }

          if (combineInfo.type == CombineType.matchWithHeader) {
            bool isFold = FoldMatchManager.isFoldByTid(
                combineInfo.tid, combineInfo.sectionGroupEnum!);

            bool isClose = MatchDataBaseWS.closeMatch(
                mhs: combineInfo.data!.mhs,
                mmp: combineInfo.data!.mmp,
                ms: combineInfo.data!.ms);
            if (isClose) {
              return const SizedBox();
            }

            ///联赛头部展开和收起

            return Container(
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.03999999910593033)
                    : const Color(0xffF8F9FA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                  bottomLeft: combineInfo.isLastMatch || isFold
                      ? Radius.circular(8.r)
                      : Radius.zero,
                  bottomRight: combineInfo.isLastMatch || isFold
                      ? Radius.circular(8.r)
                      : Radius.zero,
                ),
                border: context.isDarkMode
                    ? null
                    : Border(
                        top: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        left: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        right: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        bottom: combineInfo.isLastMatch || isFold
                            ? const BorderSide(
                                color: Color(0xffFFFFFF),
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
              ),
              margin: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                  bottom: combineInfo.isLastMatch || isFold ? 8.w : 0),
              child: Column(
                children: [
                  ///新手版  联赛标题
                  MatchGroupHeaderWidget(combineInfo: combineInfo),
                  isFold
                      ? const SizedBox()
                  ///数据body
                      :NoobItemBodyWidget(
                      matchEntity: combineInfo.data!,combineType: combineInfo.type,),//折叠控制
                  // if (combineInfo.isLastMatch) 8.verticalSpace,
                ],
              ),
            );
          }
           ///没有头部
          if (combineInfo.type == CombineType.match) {
            bool isFold = FoldMatchManager.isFoldByTid(
                combineInfo.tid, combineInfo.sectionGroupEnum!);
            if (isFold) return 0.verticalSpace;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              margin: EdgeInsets.only(
                bottom: combineInfo.isLastMatch ? 8.w : 0,
                left: 5.w,
                right: 5.w,
              ),
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.03999999910593033)
                    : const Color(0xffF8F9FA),
                borderRadius: BorderRadius.only(
                  bottomLeft: combineInfo.isLastMatch
                      ? Radius.circular(8.r)
                      : Radius.zero,
                  bottomRight: combineInfo.isLastMatch
                      ? Radius.circular(8.r)
                      : Radius.zero,
                ),
                border: context.isDarkMode
                    ? null
                    : Border(
                        left: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        right: const BorderSide(
                          color: Color(0xffFFFFFF),
                          width: 1,
                        ),
                        bottom: combineInfo.isLastMatch
                            ? const BorderSide(
                                color: Color(0xffFFFFFF),
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
              ),
              child: NoobItemBodyWidget(
                matchEntity: combineInfo.data!,
                combineType: combineInfo.type,
              ), //折叠控制
            );
          }
          return 0.verticalSpace;
        }
      },
    );
  }
}
