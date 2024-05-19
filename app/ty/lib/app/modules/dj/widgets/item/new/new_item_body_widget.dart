import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-score.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/dj_match_list_item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/media_widget.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_button.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child101.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';

class NewItemBodyWidget extends StatefulWidget {
  const NewItemBodyWidget(
      {super.key,
      required this.matchEntity,
      required this.sectionGroupEnum,
      this.showGroupHead = true,
      this.count = 0});

  final MatchEntity matchEntity;
  final bool showGroupHead;
  final SectionGroupEnum sectionGroupEnum;
  final int count;

  @override
  State<NewItemBodyWidget> createState() => _NewItemBodyWidgetState();
}

class _NewItemBodyWidgetState extends State<NewItemBodyWidget> {
  bool _isCollection = false;

  @override
  void initState() {
    _isCollection = widget.matchEntity.isCollection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
        id: MATCH_ID + widget.matchEntity.mid,
        builder: (DataStoreController controller) {
          Get.log(
              "NewItemBodyWidget = ${controller.getMatchById(widget.matchEntity.mid)}");
          MatchEntity matchEntity =
              controller.getMatchById(widget.matchEntity.mid) ??
                  widget.matchEntity;
          // bool isClose = MatchDataBaseWS.closeMatch(
          //     mhs: matchEntity.mhs, mmp: matchEntity.mmp, ms: matchEntity.ms);
          bool isClose = DJController.to.isClose(matchEntity);

          Get.log(
              "DJ = ItemBodyWidget matchEntity.mid = ${matchEntity.mid} match.ms = ${matchEntity.ms}");

          /// 赛事结束
          if (isClose) {
            return const SizedBox();
          }
          return Container(
            padding: DJController.to
                        .isCollop(matchEntity, widget.sectionGroupEnum) &&
                    !widget.showGroupHead
                ? EdgeInsets.zero
                : EdgeInsets.only(left: 5.w, right: 5.w, bottom: 8.h),
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.03999999910593033)
                  : const Color(0xffF8F9FA),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.08)
                      : const Color(0xffFFFFFF),
                  width: DJController.to
                              .isCollop(matchEntity, widget.sectionGroupEnum) &&
                          !widget.showGroupHead
                      ? 0
                      : 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                !widget.showGroupHead
                    ? const SizedBox.shrink()
                    : DJMatchListItemHeaderWidget(
                        matchEntity: matchEntity,
                        onExpandChange: (value) {
                          DJController.to.clickCollop(
                              value, matchEntity, widget.sectionGroupEnum);
                        },
                        onCollectionChange: (bool value) {},
                        count: widget.count,
                      ),
                DJController.to.isCollop(matchEntity, widget.sectionGroupEnum)
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          _buildHeader(matchEntity),
                          _buildTeam(matchEntity),
                          _buildBetGroup(matchEntity),
                          SizedBox(
                            height: 6.h,
                          ),
                        ],
                      ),
              ],
            ),
          );
        });
  }

  _buildBetGroup(MatchEntity item) {
    List<MatchHps> hps = item.hps;
    return Container(
      height: 32.w,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConfigController.to.accessConfig.value.collectSwitch
                    ? InkWell(
                        onTap: () {
                          MatchApi.instance()
                              .addOrCancelMatch(UserController.to.getUid(),
                                  item.mid, item.mf ? 0 : 1)
                              .then((value) {
                            setState(() {
                              item.mf = !item.mf;
                            });
                            // DJController.to.DJState.gameId = sportInfo.mi;
                            // DJController.to.changeGame(
                            //     DJController.to.DJState.gameId , ConfigController.to.getDjEuid( DJController.to.DJState.gameId ));
                          });
                        },
                        child: ImageView(
                          item.mf
                              ? 'assets/images/home/ico_fav_nor_sel.svg'
                              : context.isDarkMode? context.isDarkMode?'assets/images/home/ico_fav_nor.png':'assets/images/home/ico_fav_nor_light.png':'assets/images/home/ico_fav_nor_light.png',
                          width: 16.w,
                          height: 16.w,
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              MatchHpsHlOl ol;
              MatchHps element = hps[0];
              if (element != null &&
                  element.hl != null &&
                  element.hl[0] != null &&
                  element.hl[0].ol != null &&
                  element.hl[0].ol.length > 0) {
                ol = element.hl[0].ol[index];
              } else {
                var fakeOl = MatchHpsHlOl();
                fakeOl.ov = -1;
                ol = fakeOl;
              }
              return OddsButton(
                  betType: OddsBetType.esport,
                  height: 49.h,
                  width: 120.w,
                  match: item,
                  hps: hps[0],
                  ol: ol,
                  // name: ol.ott + ol.on,
                  hl: hps[0].hl.safeFirst,
                  radius:
                      4.0); /* OddButton(
                height: 32.w,
                width: 90.w,
                hps: MatchHps(),
                odd_item:e,
                matchEntity: MatchEntity(),
              );*/
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 2.w,
              );
            },
            itemCount: 2,
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  _buildTeam(MatchEntity item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    '${item.mhn}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.9)
                          : const Color(0xFF303442),
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                ImageView(
                  (item.mhlu as List).safeFirst,
                  width: 20.w,
                  height: 20.w,
                  dj: true,
                ),
              ],
            ),
          ),
          Container(
            width: 20.w,
            height: 20.w,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            alignment: Alignment.center,
            child: Text(
              'VS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.9)
                    : const Color(0xFF303442),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageView(
                  (item.malu as List).safeFirst,
                  // (widget.matchEntity.malu as List).safeFirst ??
                  //     'assets/images/home/home_team_logo.svg',
                  width: 20.w,
                  height: 20.w,
                  dj: true,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Text(
                    '${item.man}',
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.9)
                          : const Color(0xFF303442),
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildHeader(MatchEntity item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Get.toNamed(Routes.matchDetail, arguments: {
                  'mid': item.mid,
                  'csid': item.csid,
                  'isESports': true,
                })?.then((value) {
                  // Dj退出详情刷新列表
                  DJController.to.getDateList();
                });
              },
              child: MediaWidget(matchEntity: item)),
          SizedBox(
            width: 4.w,
          ),
          // Text(
          //   '02月28日 00:00',
          //   style: TextStyle(
          //     color: Color(0xFFAFB3C8),
          //     fontSize: 10.sp,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          item.ms != 110 &&
                  !show_start_counting_down(item) &&
                  !show_counting_down(item)
              ? Text(
                  '${
                  DateUtil.formatDateMs(
                  int.tryParse(item.mgt) ?? 0,
    format: isZh()
    ? LocaleKeys.time11.tr
        : LocaleKeys.time4.tr)
                   /*   FormatDate.formatMgtTimeMD((int.parse(item.mgt)))*/
    } ${item.mfo}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.5)
                        : const Color(0xffAFB3C8),
                  ),
                )
              : StageChild101(
                  isPinnedAppbar: true,
                  match: item,
                  isMatchSelect: true,
                ),
          SizedBox(
            width: 4.w,
          ),
          item.ms != 0
              ? Text(
                  '${TYFormatScore.formatTotalScore(item).text}',
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.9)
                        : const Color(0xFF303442),
                    fontSize: 10.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox(),
          const Spacer(),

          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.matchDetail, arguments: {
                'mid': item.mid,
                'csid': item.csid,
                'isESports': true,
              })?.then((value) {
                // Dj退出详情刷新列表
                DJController.to.getDateList();
              });
            },
            child: Row(
              children: [
                Text(
                  '${LocaleKeys.footer_menu_more.tr} (${item.mc})',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xFFAFB3C8),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ImageView(
                  context.isDarkMode
                      ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
                      : 'assets/images/league/ico_arrowright_nor.png',
                  width: 12.w,
                  height: 12.w,
                ),
              ],
            ),
          ),
        ],
      ),
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
}
