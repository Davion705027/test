import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/match_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/combine_info.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../../widgets/image_view.dart';
import '../../../controllers/collection_controller.dart';

///联赛标题
class MatchGroupHeaderWidget extends StatelessWidget {
  const MatchGroupHeaderWidget({super.key, required this.combineInfo});

  final CombineInfo combineInfo;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionController>(
        init: CollectionController.to,
        builder: (logic) {
          return InkWell(
            onTap: () {
              bool isFold = FoldMatchManager.isFoldByTid(
                  combineInfo.tid!, combineInfo.sectionGroupEnum!);
              FoldMatchManager.setFoldByTid(
                  combineInfo.tid!, combineInfo.sectionGroupEnum!, !isFold);
              HomeController.to.update();
            },
            child: Container(
              height: 28.h,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 2.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      // 右上 右下圆角
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2.w),
                        bottomRight: Radius.circular(2.w),
                      ),
                      color: const Color(0xff179CFF),
                    ),
                  ),
                  if (!HomeController.to.homeState.menu.isMatchBet)
                    Obx(() {
                      if (ConfigController
                          .to.accessConfig.value.collectSwitch) {
                        return InkWell(
                          onTap: () {
                            CollectionController.to
                                .addOrCancelTournament(combineInfo.tid!);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: ImageView(
                              CollectionController.to.commonCollectionTidList
                                      .contains(combineInfo.tid)
                                  ? 'assets/images/home/ico_fav_nor_sel.svg'
                                  :  context.isDarkMode?'assets/images/home/ico_fav_nor.png':'assets/images/home/ico_fav_nor_light.png',
                              width: 16.w,
                              height: 16.w,
                            ),
                          ),
                        );
                      } else {
                        return 0.verticalSpace;
                      }
                    }),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(child: Text(
                    combineInfo.tn ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.8999999761581421)
                          : const Color(0xff303442),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),

                  4.horizontalSpace,
                  ///折叠显示数量
                  if (FoldMatchManager.isFoldByTid(
                      combineInfo.tid, combineInfo.sectionGroupEnum!))
                    Text(
                      textAlign: TextAlign.center,
                      combineInfo.matchCount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DIN Alternate',
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.8999999761581421)
                            : const Color(0xffAFB3C8),
                        fontSize: 12.sp,
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    alignment: Alignment.center,
                    child: ImageView(
                      !FoldMatchManager.isFoldByTid(
                              combineInfo.tid!, combineInfo.sectionGroupEnum!)
                          ? context.isDarkMode
                              ? 'assets/images/league/item_expand_darkmode.png'
                              : 'assets/images/league/item_expand.png'
                          : context.isDarkMode
                              ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
                              : 'assets/images/league/ico_arrowright_nor.png',
                      width: 12.w,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
