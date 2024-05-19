import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/corner_play_temp.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secondary_game_play_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';

import '../../../controllers/secondary_expand_controller.dart';
import '../counting-down/counting-down.dart';

class ItemBodyWidget extends StatelessWidget {
  ItemBodyWidget({super.key, required this.matchEntity});

  final MatchEntity matchEntity;

  @override
  Widget build(BuildContext context) {
    DataStoreController controller = DataStoreController.to;
    return GetBuilder<DataStoreController>(
        init: controller,
        id: controller.getMatchId(matchEntity.mid),
        builder: (logic) {
          MatchEntity match =
              controller.getMatchById(matchEntity.mid) ?? matchEntity;
          return RepaintBoundary(
            child: InkWell(
              onTap: () async {
                ///去详情
                final res = await Get.toNamed(Routes.matchDetail, arguments: {
                  'mid': match.mid,
                  'csid': match.csid,
                })?.then((value) {
                  HomeController.to.fetchData();
                  SecondaryController.clearMap();
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      ///  item分割线
                      Divider(
                        indent: 8.w,
                        endIndent: 8.w,
                        height: 0.4.h,
                        color: context.isDarkMode
                            ? Colors.white.withAlpha(10)
                            : const Color(0xffE4E6ED),
                      ).paddingOnly(bottom: 2.h,),

                      /// item顶部title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: _buildHeader(context, match),
                      ),
                    ],
                  ),
                  /*
                  * 赛事信息 比分
                  * */
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: CornerPlayTemp(match: match, hps: match.hps),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child:
                        /// 子玩法
                        GestureDetector(
                      onTap: () {},
                      child: SecondayGamePlayWidget(
                        matchEntity: match,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget  _buildHeader(BuildContext context, MatchEntity matchEntity) {
    return GetBuilder<CollectionController>(
        init: CollectionController.to,
        builder: (logic) {
          bool showStartCountingDown =
              MatchUtil.showStartCountingDown(matchEntity);
          bool showCountingDown = MatchUtil.showCountingDown(matchEntity);
          return SizedBox(
            child: Row(children: [
              if (!HomeController.to.homeState.menu.isMatchBet)
                Obx(() {
                  if (ConfigController.to.accessConfig.value.collectSwitch) {
                    return InkWell(
                      onTap: () {
                        CollectionController.to.addOrCancelMatch(matchEntity);
                      },
                      child: ImageView(
                        matchEntity.mf ||
                                CollectionController.to.commonCollectionMidList
                                    .contains(matchEntity.mid)
                            ? 'assets/images/home/ico_fav_nor_sel.svg'
                            :  context.isDarkMode?'assets/images/home/ico_fav_nor.png':'assets/images/home/ico_fav_nor_light.png',
                        width: 16.w,
                        height: 16.w,
                      ),
                    ).marginOnly(right: 4.w);
                  } else {
                    return 0.verticalSpace;
                  }
                }),
              Row(
                children: [
                  // 1 开赛   110 即将开赛
                  //  ms = 1 110 才匹配（已开赛的）其他直接显示时间。

                  //  <!--开赛日期 ms != 110 (不为即将开赛)  subMenuType = 13网球(进行中不显示，赛前需要显示)-->
                  ///  kyapp 没有显示即将开始 倒计时 这里不需要判断倒计时
                  /*       if (matchEntity.ms != 110 &&
                      !showStartCountingDown &&
                      !showCountingDown)*/

                  if (matchEntity.ms != 110 && !showCountingDown)
                    Row(
                      children: [
                        Text(
                          DateUtil.formatDateMs(
                              int.tryParse(matchEntity.mgt) ?? 0,
                              format: isZh()
                                  ? LocaleKeys.time11.tr
                                  : LocaleKeys.time4.tr),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? Colors.white.withOpacity(0.30000001192092896)
                                : const Color(0xffAFB3C8),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        )
                      ],
                    ),
                  // <!-- 赛事回合数mfo match.ms != 1(不为开赛)-->
                  if (matchEntity.mfo != null &&
                      ![1, 110].contains(matchEntity.ms) && //网球单独处理
                      matchEntity != null &&
                      [5, 7, 8, 9, 10].contains(int.parse(matchEntity.csid)))
                    Row(
                      children: [
                        Text(
                          matchEntity.mfo,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? Colors.white.withOpacity(0.30000001192092896)
                                : const Color(0xffAFB3C8),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        )
                      ],
                    ),

                  ///  即将开赛 ms = 110  显示即将开赛
                  if (matchEntity.ms == 110)
                    Text(
                      'ms_110'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.30000001192092896)
                            : const Color(0xffAFB3C8),
                      ),
                    ).marginOnly(right: 4.w),

                  //  <!-- 一小时内开赛  -->
                  /*      if (matchEntity.ms != 110 && showStartCountingDown)
                    Text(
                      LocaleKeys.list_after_time_start.tr.replaceFirst('{0}',
                          MatchUtil.getStartCountTime(matchEntity).toString()),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.30000001192092896)
                            : const Color(0xffAFB3C8),
                      ),
                    ),*/
                  // CountingdownStart(matchEntity,matchEntity.mgt),

                  //  <!--倒计时或正计时-->
                  if (matchEntity.ms != 110 &&
                      showCountingDown &&
                      HomeController.to.visiable)
                    Countingdown(matchEntity),
                  // TimeWidget(
                  //   matchEntity: matchEntity
                  // ),

                  // if ([1, 110].contains(matchEntity.ms))
                  //   Text(
                  //     // tid 联赛id归位一类，
                  //     'mmp_${matchEntity.csid}_${matchEntity.mmp}'.tr,
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 12.sp,
                  //       color: context.isDarkMode
                  //           ? Colors.white.withOpacity(0.30000001192092896)
                  //           : const Color(0xffAFB3C8),
                  //     ),
                  //   ).marginOnly(right: 4.w),
                  // TimeWidget(
                  //   matchEntity: matchEntity,
                  // ),
                ],
              ),
              const Spacer(),
              Obx(() {
                return Text(
                  ConfigController.to.accessConfig.value.handicapNum
                      ? '${matchEntity.mc}+'
                      : LocaleKeys.footer_menu_more.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                    fontFamily: 'PingFang SC',
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                );
              }),
              ImageView(
                context.isDarkMode
                    ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
                    : 'assets/images/league/ico_arrowright_nor.png',
                width: 12.w,
                height: 12.w,
              ),
            ]),
          );
        });
  }
}
