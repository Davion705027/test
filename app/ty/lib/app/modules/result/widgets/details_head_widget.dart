import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/image_view.dart';
import '../../match_detail/widgets/header/score/match_detail_score.dart';
import 'HeaderModel.dart';

///赛果导航头部
class DetailsHeadWidget extends StatelessWidget {
  const DetailsHeadWidget({
    super.key,
    required this.isDark,
    required this.typePicture,
    required this.onHeadMenu,
    required this.detailData,
    required this.onRefresh,
    required this.animationController,
    required this.headerMap,
  });

  final bool isDark;
  final String typePicture;
  final VoidCallback? onHeadMenu;
  final MatchEntity? detailData;
  final VoidCallback? onRefresh;
  final AnimationController animationController;
  final HeaderModel headerMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(
                typePicture
            ),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: ImageView(
                      'assets/images/icon/icon_arrowleft_nor.png',
                      width: 16.w,
                      height: 16.h,
                      color: Colors.white,
                    )
                  ),
                  if(detailData != null)
                    InkWell(
                      onTap: onHeadMenu,
                      child: SizedBox(
                        height: 44.h,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: calculateTextSize(detailData!.tn, TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'PingFang SC',
                                color: Colors.white,
                              )).width > 180?
                              Marquee(
                                text: detailData!.tn,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'PingFang SC',
                                  color: Colors.white,
                                ),
                                velocity:  30.0,
                                blankSpace: 10.w,
                              ):Text(
                                detailData!.tn,
                                textAlign: TextAlign.center,
                                style:TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'PingFang SC',
                                color: Colors.white,
                              )),
                            ),
                            Container(
                              width: 5.w,
                            ),
                            ImageView(
                              'assets/images/icon/t_down.png',
                              width: 10.w,
                              height: 10.h,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  InkWell(
                    onTap: onRefresh,
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 2.0)
                          .animate(animationController),
                      child: ImageView(
                        'assets/images/shopcart/refresh1.png',
                        color: Colors.white,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        '${detailData?.mhn ?? ''} v ${detailData?.man ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        headerMap.score,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: 15.h,
                ),
                child: Text(
                  headerMap.time,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontFamily: 'DIN',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: 10.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                        LocaleKeys.mmp_3_999_app_h5.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // mng 是否中立场 1:是中立场，0:非中立场 --- 仅足球
                        if(![5, 10, 7, 8, 13].contains(int.tryParse(detailData?.csid ??"" )) && detailData?.mng != 0)
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 0.5),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 0),
                            child: const Text(
                              "N",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        SizedBox(width: 15.w),
                      ],
                    ),
                    if (detailData != null) Expanded(child: MatchDetailScore(match: detailData!))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Size calculateTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
