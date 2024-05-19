import 'dart:math';

import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/widget/detal_progress_bar.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';

class sportHistoryDataView extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    List<int> left = [];
    List<int> right = [];
    if (controller.state.historyScore.isNotEmpty) {
      controller.state.historyScore.forEach((element) {
        List<String> group = element.split(':');
        if (group[0].toInt() > group[1].toInt()) {
          left.add(1);
          right.add(-1);
        } else if (group[0].toInt() < group[1].toInt()) {
          left.add(-1);
          right.add(1);
        } else if (group[0].toInt() == group[1].toInt()) {
          left.add(0);
          right.add(0);
        }
      });
    }

    return Container(
      decoration: context.isDarkMode
          ?  BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(
              'assets/images/home/color_background_skin.png',
            ),
          ),
          fit: BoxFit.cover,
        ),
      )
          : const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: context.isDarkMode
                ? Colors.white.withOpacity(0.04)
                : Colors.white,
            borderRadius: BorderRadius.circular(8.r)),
        margin: EdgeInsets.all(5.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return progressItem(context, index);
                },
                itemCount: controller.state.historyScore.length,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 15.w, bottom: 15.w, left: 10.w, right: 10.w),
                child: Row(
                  children: [
                    resultItem(context, 'left', left),
                    SizedBox(
                      width: 10.w,
                    ),
                    resultItem(context, 'right', right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    /* return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10.w,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 5.w, right: 5.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              children: [
                ListView.builder(
                  physics:const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return progressItem(index);
                  },
                  itemCount: controller.state.historyScore.length,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 15.w, bottom: 15.w, left: 10.w, right: 10.w),
                  child: Row(
                    children: [
                      resultItem('%', left),
                      SizedBox(
                        width: 10.w,
                      ),
                      resultItem('%', right),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );*/
  }

  Widget progressItem(BuildContext context, index) {
    String scoreStr = controller.state.historyScore[index];
    // scoreStr = '3:7';
    // List scoreIntList = scoreStr.split(':');
    // int homeScore = int.parse(scoreIntList.first);
    // int awatScore = int.parse(scoreIntList.last);
    // int sum = homeScore + awatScore;
    // if (sum == 0) sum = 1;
    //
    // int homeProgress = (homeScore / sum * 100).round();
    // int awayProgress = (awatScore / sum * 100).round();

    List<String> group = scoreStr.split(':');
    int homeProgress = group[0].toInt() * 10;
    int awayProgress = group[1].toInt() * 10;
    return Container(
      margin: EdgeInsets.only(top: 13.w, left: 12.w, right: 12.w),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.w),
          alignment: Alignment.center,
          width: 70,
          child: Text(
            scoreStr.replaceAll(':', ' - '),
            style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.9)
                    : const Color(0xff303442),
                fontWeight: FontWeight.w700,
                fontSize: 10.sp),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: detailProgressBarWidget(
                progress: homeProgress,
                type: detailProgressBarType.left,
                isBig: true,
              ),
            ),
            SizedBox(
              width: 7.w,
            ),
            Expanded(
              flex: 1,
              child: detailProgressBarWidget(
                progress: awayProgress,
                type: detailProgressBarType.right,
                isBig: true,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  resultItem(BuildContext context, String resultScore, List scorelist) {
    final score = scorelist.where((element) => element == 1).length;
    // 胜率
    final percent =
        '${(score / (max(1, scorelist.length)) * 100).toStringAsFixed(0)}%';
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.04)
              : const Color(0xffF2F2F6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Text(
              percent,
              style: TextStyle(
                color:
                context.isDarkMode
                    ? Colors.white.withOpacity(0.9)
                    :  const Color(0xff303442),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            rowRecord(scorelist),
          ],
        ),
      ),
    );
  }

  rowRecord(List resultList) {
    int columnNum = (resultList.length / 7 + 1).toInt();
    int lastRowNum = (resultList.length % 7).toInt();

    Get.log("resultList.length = ${resultList.length}");
    Get.log("columnNum = $columnNum  lastRowNum = $lastRowNum");
    List<Widget> column = [];

    for (int i = 0; i < columnNum; i++) {
      int currentMaxRow = 7;
      if (i == columnNum - 1) {
        currentMaxRow = lastRowNum;
      }

      List<Widget> row = [];
      for (int j = 0; j < currentMaxRow; j++) {
        int resultInt = resultList[i * 7 + j];
        String imageStr = 'Wimage';
        if (resultInt == 0) {
          imageStr = 'Dimage';
        } else if (resultInt == -1) {
          imageStr = 'Limage';
        }

        row.add(SizedBox(
          width: 4.w,
        ));
        row.add(ImageView(
          'assets/images/vr/$imageStr.png',
          width: 20.w,
          height: 16.w,
        ));
      }
      column.add(SizedBox(
        height: 5.w,
      ));
      column.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: row,
      ));
    }

    // for(int i = 0;i<resultList.length;i++){
    //   int resultInt = resultList[i];
    //   String imageStr = 'Wimage';
    //   if (resultInt == 0) {
    //     imageStr = 'Dimage';
    //   } else if (resultInt == -1) {
    //     imageStr = 'Limage';
    //   }
    //
    //   row.add(ImageView(
    //     'assets/images/vr/$imageStr.png',
    //     width: 20.w,
    //     height: 16.w,
    //   ));
    // }

    return Column(
      children: column,
    );
  }

  gridview(List resultList) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 7.w),
      width: double.maxFinite,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 2.w,
          childAspectRatio: 1.4,
        ),
        itemBuilder: (BuildContext context, int index) {
          int resultInt = resultList[index];
          String imageStr = 'Wimage';
          if (resultInt == 0) {
            imageStr = 'Dimage';
          } else if (resultInt == -1) {
            imageStr = 'Limage';
          }
          return ImageView(
            'assets/images/vr/$imageStr.png',
            // fit: BoxFit.contain,
            width: 20.w,
            height: 16.w,
          );
        },
        itemCount: resultList.length,
      ),
    );
  }
}
