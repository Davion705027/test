import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/collection_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../services/models/res/match_entity.dart';
import '../../../../widgets/image_view.dart';
///列表联赛头部
class MatchListItemHeaderWidget extends StatelessWidget {
  MatchListItemHeaderWidget(
      {super.key,
      required this.matchEntity,
      required this.onExpandChange,
      this.hasCollection = true,
      this.length = '',
      this.isGuanjun = false});

  final MatchEntity matchEntity;
  final ValueChanged<bool> onExpandChange;
  final bool hasCollection;
  String length;
  bool isGuanjun;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionController>(
        init: CollectionController(),
        id: '$COLLECTION_TID${matchEntity.tid}',
        builder: (logic) {
          return GestureDetector(
            onTap: () {
              onExpandChange(!(matchEntity.isExpand));
            },
            child: Container(
              height: 24.h,
              alignment: Alignment.centerLeft,
              child: Row(
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
                  if (hasCollection)
                    isGuanjun == true
                        ? InkWell(
                            onTap: () {
                              ///添加/取消 收藏
                              CollectionController.to
                                  .addOrCancelTournamentGuanjun(matchEntity);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: ImageView(
                                (matchEntity.tf ||
                                        CollectionController
                                            .to.championCollectionMidList
                                            .contains(matchEntity.mid))
                                    ? 'assets/images/home/ico_fav_nor_sel.svg'
                                    :  context.isDarkMode?'assets/images/home/ico_fav_nor.png':'assets/images/home/ico_fav_nor_light.png',
                                width: 16.w,
                                height: 16.w,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              ///添加/取消 收藏

                              CollectionController.to
                                  .addOrCancelMatch(matchEntity);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: ImageView(
                                (matchEntity.mf ||
                                        CollectionController
                                            .to.commonCollectionMidList
                                            .contains(matchEntity.mid))
                                    ? 'assets/images/home/ico_fav_nor_sel.svg'
                                    :  context.isDarkMode?'assets/images/home/ico_fav_nor.png':'assets/images/home/ico_fav_nor_light.png',
                                width: 16.w,
                                height: 16.w,
                              ),
                            ),
                          ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: Text(
                      matchEntity.tn,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.8999999761581421)
                            : const Color(0xff303442),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  length == ''
                      ? const SizedBox()
                      : Text(
                          length,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFFAFB3C8),
                          ),
                        ),
                  Container(
                    width: 24.h,
                    height: 24.h,
                    alignment: Alignment.center,
                    child: ImageView(
                      matchEntity.isExpand
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
