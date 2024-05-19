import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../../services/api/analyze_v_s_info_entity.dart';

class AnalyzeMatchHistoryChildItem extends StatelessWidget {
  AnalyzeVSInfoEntity analyzeVSInfoEntity;
  AnalyzeMatchHistoryChildItem(this.analyzeVSInfoEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Expanded(
            flex: 2,
            child:  Container(
              alignment: Alignment.center,
              child:  Container(
                width: 20.w,
                height: 20.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.w)),
                    color:getBgColor(analyzeVSInfoEntity.positionTotal?.toInt() ?? 0)
                ),
                child: Text(
                  "${analyzeVSInfoEntity.positionTotal?.toInt() ?? 0}",
                  style: TextStyle(fontSize: 11.sp, color: getTextColor(analyzeVSInfoEntity.positionTotal?.toInt() ?? 0)),
                ),
              ),
            ),

          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "${analyzeVSInfoEntity.teamName}",
                style: TextStyle(
                    fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Text(
              "${analyzeVSInfoEntity.matchCount}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${analyzeVSInfoEntity.winTotal?.toInt() ?? 0}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${analyzeVSInfoEntity.lossTotal?.toInt() ?? 0}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${analyzeVSInfoEntity.drawTotal?.toInt() ?? 0 }",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${analyzeVSInfoEntity.goalsForTotal?.toInt() ?? 0}/${analyzeVSInfoEntity.goalsAgainstTotal?.toInt() ?? 0}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${analyzeVSInfoEntity.goalDiffTotal?.toInt() ?? 0}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${analyzeVSInfoEntity.pointsTotal?.toInt() ?? 0}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
            ),
          ),
        ],
      ),
    );
  }
  Color getTextColor(int index){
    Color bgColor= Colors.white;
    if(index==3) {
      bgColor= Get.theme.resultTextColor;
    }
    return bgColor;
  }


  Color getBgColor(int index){
    Color bgColor= Color(0xFFC6C9CE);
    if(index==1) {
      bgColor= Color(0xFFFF4400);
    }else  if(index==2) {
      bgColor= Color(0xFF189CFF);
    }else  if(index==3) {
      bgColor= Color(0xFFFF4400);
    }
    return bgColor;
  }
}
