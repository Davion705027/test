import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/widget/detal_progress_bar.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_history_dog_entity.dart';
import 'package:flutter_ty_app/app/utils/oss_util.dart';

class sportHistoryDogView extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10.w,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
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
              color: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.only(left: 5.w, right: 5.w),
              decoration:  BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.04):Colors.white, borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  ListView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return itemBuild(context,index);
                    },
                    itemCount: controller.state.historyScoreDog.length,
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget progressItem(index) {
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
    int homeProgress = group[0].toInt()*10;
    int awayProgress = group[1].toInt()*10;
    return Container(
      margin: EdgeInsets.only(top: 13.w,left: 10.w,right: 10.w),

      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.w),
          alignment: Alignment.center,
          width: 70,
          child: Text(
            scoreStr.replaceAll(':', ' - '),
            style: const TextStyle(
                color: Color(0xff303442),
                fontWeight: FontWeight.w700,
                fontSize: 14),
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
            SizedBox(width: 7.w,),
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

  resultItem(String resultScore, List scorelist) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
          decoration: BoxDecoration(
              color: const Color(0xffF2F2F6),
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            children: [
         /*     Text(
                resultScore,
                style: TextStyle(
                    color: const Color(0xff303442),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),*/
              gridview(scorelist),
            ],
          ),
        ));
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
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
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
            'assets/images/vr/$imageStr.svg',
            // fit: BoxFit.contain,
            width: 20,
            height: 16,
          );
        },
        itemCount: resultList.length,
      ),
    );
  }

  Widget itemBuild(BuildContext context,int index) {
    /*
    {"code":"0000000","data":[{"number":"1","form":44,"star":"3","name":"奥拉齐奥","forecast":[3,0,2,0,3]},{"number":"2","form":34,"star":"2","name":"南多","forecast":[0,0,0,0,0]},{"number":"3","form":61,"star":"5","name":"埃德·戈里","forecast":[0,2,1,0,1]},{"number":"4","form":40,"star":"3","name":"皮里图","forecast":[0,1,1,0,0]},{"number":"5","form":56,"star":"4","name":"比亚焦","forecast":[0,1,1,3,0]},{"number":"6","form":63,"star":"5","name":"","forecast":[2,0,2,0,0]}],"msg":"成功","ts":1710606701343}
 */
    VrHistoryDogEntity bean = controller.state.historyScoreDog[index];
    double fristW = 40.w;

    Color? textColor = context.isDarkMode
        ? Colors.white.withOpacity(0.9):const Color(0xff303442);

    FontWeight? textFont =  FontWeight.w500;

    var resultList = bean.forecast.map((e){return e==0?'X':'$e';}).toList();

    var result = '';
    resultList.forEach((element) {result+=' $element';});



    // bean.star.toInt()
    List<Widget> starWidget = [];
    for (int i = 0; i < 5; i++) {

      if(i<(bean.star??"0").toInt()){
        starWidget.add(ImageView( 'assets/images/vr/ico_fav_sel.svg', width: 14.w,height: 14.w,));
      }else{
        starWidget.add(ImageView( 'assets/images/vr/ico_fav.svg', width: 14.w,height: 14.w,));
      }
      starWidget.add(SizedBox(width: 4.w,));
    }
    // ico_fav_sel
    return SizedBox(
      child: Column(
        children: [
          SizedBox(height: 20.w,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child:Column(

                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 4.w,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index < 7? SizedBox(
                            width: fristW,
                            child: ImageView(
                              'assets/images/vr/vr_dog_horse_rank${index+1}.svg',
                              height: 18.w,
                              width: 18.w,
                            ),
                          )
                              : SizedBox(
                            width: fristW,
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: 18.w,
                                height: 18.w,
                                // decoration: BoxDecoration(
                                //     color: Colors.white.withOpacity(0.16),
                                //     borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  (index+1).toString(),
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              bean.name,
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: textColor, fontSize: 12.sp, fontWeight: textFont),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),

              ),

              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.04):const Color(0xffF2F2F6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.w,horizontal: 12.w),
                  child: Column(
                    children: [
                      Row(children: [
                        Text(
                          LocaleKeys.virtual_sports_results_previous.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textColor, fontSize: 12.sp, fontWeight: textFont),
                        ),
                        SizedBox(width: 8.w),

                        Text(
                          result,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xff179CFF), fontSize: 12.sp, fontWeight: textFont),
                        ),
                      ],),
                      SizedBox(height: 10.w,),
                      Row(children: [
                        Text(
                          LocaleKeys.virtual_sports_comprehensive_rating.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textColor, fontSize: 12.sp, fontWeight: textFont),
                        ),
                        SizedBox(width: 8.w),

                        Expanded(
                          child: Row(
                            children: starWidget,
                          ),
                        )
                      ],),
                      SizedBox(height: 10.w,),
                      Row(children: [
                        Text(
                          LocaleKeys.virtual_sports_vitality_performance.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textColor, fontSize: 12.sp, fontWeight: textFont),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: detailProgressBarWidget(
                            progress: bean.form,
                            type: detailProgressBarType.right,
                            isBig: true,
                              colorRight: const Color(0xffE95B5B),
                          ),
                        ),
                        SizedBox(width: 8.w,),
                        Text(
                          '${bean.form}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white.withOpacity(0.5):const Color(0xff303442), fontSize: 12.sp, fontWeight: textFont),
                        ),
                      ],),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 12.w,)
            ],
          ),
          SizedBox(height: 20.w,)
        ],
      ),
    );
  }
}
