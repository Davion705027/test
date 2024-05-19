import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../services/api/analyze_v_s_info_entity.dart';

class AnalyzeMatchHistoryBasketBallChildItem extends StatelessWidget {
  AnalyzeVSInfoEntity analyzeVSInfoEntity;
  int index;
  AnalyzeMatchHistoryBasketBallChildItem(this.index,this.analyzeVSInfoEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double totalDouble= ((analyzeVSInfoEntity.matchCount??0)+(analyzeVSInfoEntity.winTotal?.toInt() ?? 0)).toDouble();
    totalDouble=(totalDouble==0)?1:totalDouble;
    return Container(
      height: 40.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w,
            alignment: Alignment.centerLeft,
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
          Expanded(
            flex: 3,

            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                softWrap: true,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "${analyzeVSInfoEntity.teamName}",
                style: TextStyle(
                    fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child:Container(
              alignment: Alignment.center,
              child: Text(
                softWrap: true,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "${analyzeVSInfoEntity.winTotal}",
                style: TextStyle(
                    fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
              ),
            ),


          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                softWrap: true,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "${analyzeVSInfoEntity.lossTotal?.toInt() ?? 0}",
                style: TextStyle(
                    fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
              ),
            ),


          ),
          Expanded(
            flex: 2,
            child:Container(
              alignment: Alignment.center,
              child: Text(
                softWrap: true,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "${((analyzeVSInfoEntity.matchCount??0)/totalDouble*100).toStringAsFixed(1)}%",
                style: TextStyle(
                    fontSize: 11.sp, color: Get.theme.tabPanelSelectedColor),
              ),
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
