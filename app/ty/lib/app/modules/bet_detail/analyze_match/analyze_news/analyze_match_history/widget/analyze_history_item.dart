import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/utils/AnalyzeUtils.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/header_type_enum.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_back_video_info_entity_entity_entity_entity.dart';

import '../../../../../match_detail/controllers/analyze_tab_controller.dart';
import '../../../../../match_detail/controllers/match_detail_controller.dart';

class AnalyzeHistoryItem extends StatelessWidget {
  AnalyzeBackVideoInfoEntityEntityEntityEventList
      analyzeBackVideoInfoEntityEntityEventList;


  AnalyzeHistoryItem(this.analyzeBackVideoInfoEntityEntityEventList,
      {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        if (ObjectUtil.isNotEmpty(
            analyzeBackVideoInfoEntityEntityEventList.fragmentVideo)) {
          MatchDetailController detailController =
          Get.find<MatchDetailController>(tag: AnalyzeTabController.to.tag);
          detailController.detailState.headerType.value = HeaderType.replay;
          DateTime now = DateTime.now();
          DateTime startOfDay = DateTime(now.year, now.month, now.day);
          String t = startOfDay.millisecondsSinceEpoch.toString();
          String url =
              '${StringKV.liveUrl.get()}/videoReplay.html?src=${analyzeBackVideoInfoEntityEntityEventList.fragmentVideo}&lang=&volume=1&t=$t';
          detailController.detailState.replayUrl = url;
          detailController.detailState.webViewController
              ?.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
        }
      },
      child: Container(
        width: 126.w,
        height: 142.w,
        margin: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.w)),
                  child: ImageView(
                    analyzeBackVideoInfoEntityEntityEventList.fragmentPic ?? "",
                    width: 126.w,
                    height: 70.w,
                    boxFit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.play_arrow,
                    size: 20.w,
                    color: Color(0xFFDBDADC),
                  ),
                ),
                Positioned(
                    left: 6.w,
                    right: 6.w,
                    bottom: 0.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${analyzeBackVideoInfoEntityEntityEventList.t1}-${analyzeBackVideoInfoEntityEntityEventList.t2}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "${analyzeBackVideoInfoEntityEntityEventList.secondsFromStart?.secondsToCountdown}",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 4.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Container(
                 constraints: BoxConstraints(maxWidth: 80.w),
                 child:  Text(
                   "  ${analyzeBackVideoInfoEntityEntityEventList.homeAway ?? ""}",
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                     color: Get.theme.oddsButtonValueFontColor,
                     fontWeight: FontWeight.w700,
                     fontSize: 10.sp,
                   ),
                 ),

               ),
               Container(
                 width: 50.w,
                 child:  Text(
                   "${AnalyzeUtils.getMap()['${analyzeBackVideoInfoEntityEntityEventList.eventCode}'] ?? ""}${analyzeBackVideoInfoEntityEntityEventList.firstNum}  ",
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                     color: Color(0xFF7981A4),
                     fontWeight: FontWeight.w700,
                     fontSize: 10.sp,
                   ),
                 ),
               ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
