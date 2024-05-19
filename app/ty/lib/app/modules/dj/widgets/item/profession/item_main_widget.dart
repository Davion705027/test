import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_ctr_ws.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/models/dj_group_expand_info.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/dj_match_list_item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/media_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/profession/odd_group_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/profession/score_widget.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/bet_title_group_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../match_detail/widgets/header/stage/templates/stage_child101.dart';

class ItemMainWidget extends StatefulWidget {
  const ItemMainWidget(
      {super.key,
      required this.sectionGroupEnum,
      required this.matchEntity,
      this.showGroupHead = true,
      this.count = 0});

  final SectionGroupEnum sectionGroupEnum;
  final MatchEntity matchEntity;
  final bool showGroupHead;
  final int count;

  @override
  State<ItemMainWidget> createState() => _ItemMainWidgetState();
}

class _ItemMainWidgetState extends State<ItemMainWidget> {
  bool _isExpand = true;

  @override
  void initState() {
    _isExpand = widget.matchEntity.isExpand ?? false;
    Bus.getInstance().on(EventType.djGroupExpand, (DJGroupExpandInfo data) {
      if (data.groupEnum == widget.sectionGroupEnum) {
        if (mounted) {
          setState(() {
            _isExpand = data.isExpand;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
      id: MATCH_ID + widget.matchEntity.mid,
      builder: (DataStoreController controller) {
        // Get.log(
        //     "ItemMainWidget = ${controller.getMatchById(widget.matchEntity.mid)}");
        controller.getMatchById(widget.matchEntity.mid);
        MatchEntity matchEntity =
            controller.getMatchById(widget.matchEntity.mid) ??
                widget.matchEntity;
        // bool isClose = MatchDataBaseWS.closeMatch(
        //     mhs: matchEntity.mhs, mmp: matchEntity.mmp, ms: matchEntity.ms);
        bool isClose = DJController.to.isClose(matchEntity);

        Get.log("DJ = ItemBodyWidget matchEntity.mid = ${matchEntity.mid} match.ms = ${matchEntity.ms}");
        /// 赛事结束
        if (isClose) {
          return const SizedBox();
        }
        return InkWell(
          onTap: () {
            Get.toNamed(Routes.matchDetail, arguments: {
              'mid': matchEntity.mid,
              'csid': matchEntity.csid,
              'isESports': true,
            })?.then((value) {
              // Dj退出详情刷新列表
              DJController.to.getDateList();
            });
          },
          child: Container(
            // padding: DJController.to
            //             .isCollop(matchEntity, widget.sectionGroupEnum) ||
            //         !widget.showGroupHead
            //     ? EdgeInsets.zero
            //     : EdgeInsets.only(left: 5.w, right: 5.w,),


              padding: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                color:context.isDarkMode
                    ? Colors.white.withOpacity(0.03999999910593033)
                    :  Colors.white.withOpacity(0.5),
                // color: context.isDarkMode
                //     ? Colors.white.withOpacity(0.03999999910593033)
                //     : const Color(0xffF8F9FA),
                // borderRadius: BorderRadius.circular(8.r),
                // border: context.isDarkMode
                //     ? null
                //     : Border.all(
                //         color: const Color(0xffFFFFFF),
                //         width: DJController.to.isCollop(
                //                     matchEntity, widget.sectionGroupEnum) &&
                //                 !widget.showGroupHead
                //             ? 0
                //             : 1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  !widget.showGroupHead
                      ? const SizedBox.shrink()
                      : Column(
                        children: [
                          DJMatchListItemHeaderWidget(
                              matchEntity: matchEntity,
                              onExpandChange: (value) {
                                 DJController.to.clickCollop(value,matchEntity, widget.sectionGroupEnum);
                              },
                              onCollectionChange: (bool value) {
                                matchEntity.isCollection = value;
                                setState(() {});
                              },
                              count: widget.count),
                        ],
                      ),
                  DJController.to.isCollop(matchEntity, widget.sectionGroupEnum)
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            children: [
                              !widget.showGroupHead
                                  ? const SizedBox.shrink()
                                  : BetTitleGroupWidget(
                                hps: matchEntity.hps,
                                matchEntity: matchEntity,
                              ),
                              // DJItemBodyWidget(
                              //   matchEntity: widget.match,
                              // ),

                              Divider(
                                height: 1,
                                color: context.isDarkMode
                                    ? Colors.white
                                        .withOpacity(0.03999999910593033)
                                    : const Color(0xffE5E5E5),
                              ),
                              _buildHeader(matchEntity),
                              SizedBox(
                                height: 68.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              ScoreWidget(
                                                  matchEntity: matchEntity,
                                                  name: matchEntity.mhn,
                                                  score: TYFormatScore
                                                          .formatTotalScore(
                                                              matchEntity)
                                                      .home
                                                      .toString()),
                                              // Spacer(),
                                              ScoreWidget(
                                                  matchEntity: matchEntity,
                                                  name: matchEntity.man,
                                                  score: TYFormatScore
                                                          .formatTotalScore(
                                                              matchEntity)
                                                      .away
                                                      .toString()),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        OddGroupWidget(
                                            matchEntity: matchEntity),
                                      ],
                                    ),
                                    // const Spacer(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              MediaWidget(matchEntity: matchEntity),

                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(MatchEntity matchEntity) {
    return SizedBox(
      height: 20.h,
      child: Row(children: [
        ConfigController.to.accessConfig.value.collectSwitch? GestureDetector(
          onTap: () {
            MatchApi.instance()
                .addOrCancelMatch(UserController.to.getUid(), matchEntity.mid,
                    matchEntity.mf ? 0 : 1)
                .then((value) {
              setState(() {
                matchEntity.mf = !matchEntity.mf;
                if (matchEntity.mf == false) {
                  Get.log(
                      "DJController.to.DJState.djListEntity = before ${DJController.to.DJState.djListEntity}");
                  DJController.to.DJState.djListEntity?.removeWhere(
                      (element) => element.mid == matchEntity.mid);
                  Get.log(
                      "DJController.to.DJState.djListEntity = ${DJController.to.DJState.djListEntity}");
                  DJController.to.update();
                }
              });

              // DJController.to.DJState.gameId = sportInfo.mi;
              // DJController.to.changeGame(
              //     DJController.to.DJState.gameId , ConfigController.to.getDjEuid( DJController.to.DJState.gameId ));
            });
          },
          child: ImageView(
            matchEntity.mf
                ? 'assets/images/home/ico_fav_nor_sel.svg'
                :  context.isDarkMode?'assets/images/home/ico_fav_nor.png':'assets/images/home/ico_fav_nor_light.png',
            width: 16.w,
            height: 16.w,
          ),
        ):SizedBox.shrink(),
        SizedBox(
          width: 4.w,
        ),
        matchEntity.ms != 110 &&
                !show_start_counting_down(matchEntity) &&
                !show_counting_down(matchEntity)
            ? Text(
                '${
                    DateUtil.formatDateMs(
                        int.tryParse(matchEntity.mgt) ?? 0,
                        format: isZh()
                            ? LocaleKeys.time11.tr
                            : LocaleKeys.time4.tr)
                    /*FormatDate.formatMgtTimeMD((int.parse(matchEntity.mgt)))*/} ${matchEntity.mfo}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: const Color(0xffAFB3C8),
                ),
              )
            : StageChild101(
                isPinnedAppbar: true,
                match: matchEntity,
                isMatchSelect: true,
              ),
        isShowChuan()
            ? Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: context.isDarkMode? Colors.white.withOpacity(0.1):Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(4.w),
                  border: Border.all( color: context.isDarkMode?Colors.transparent:Colors.white,width: 1),
                  boxShadow: [BoxShadow(
                    color: context.isDarkMode?Colors.transparent:Colors.grey.withOpacity(0.3),
                    offset: Offset(-1,2),
                    // blurRadius: 45
                  )]
                ),
                child: Text(
                  //LocaleKeys.app_h5_bet_parlay.tr,
                  Get.locale?.languageCode=='zh' || Get.locale?.languageCode=='tw'?'串':'P',
                  style: TextStyle(color: Colors.blue, fontSize: 10.sp),
                ),
              )
            : const SizedBox(),
        const Spacer(),
        Text(
          '${matchEntity.mc}+',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: const Color(0xffAFB3C8),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        ImageView(
          context.isDarkMode
              ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
              : 'assets/images/league/ico_arrowright_nor.png',
          width: 12.w,
          height: 12.w,
        ),
      ]),
    );
  }

  /**
   * @description: 多少分钟后开赛显示
   * @param {Object} item 赛事对象
   * @return {String}
   */
  bool show_start_counting_down(MatchEntity item) {
    if (item.mcg == null) {
      return false;
    }
    var r = false;
// 滚球中不需要显示多少分钟后开赛
    if (item != null && item.ms == 1) {
      return r;
    }
    return r;
  }

//赛事状态 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
  /**
   * @description: 进行中(但不是收藏页)的赛事显示累加计时|倒计时
   * @param {Object} item 赛事对象
   * @return {Boolean}
   */
  bool show_counting_down(MatchEntity item) {
    return [1, 2, 10].contains(item.ms * 1);
  }

  isShowChuan() {
    return widget.matchEntity.hps[0].hl[0].hipo == 1;
  }
}
