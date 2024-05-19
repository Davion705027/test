import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../login/login_head_import.dart';

class MultiScoreWidget extends StatelessWidget {
  MatchEntity match;

  MultiScoreWidget(this.match);

  @override
  Widget build(BuildContext context) {
    Get.log("match.csid  = ${match.csid }");
      if(match.csid != '2' && match.csid != '9'){
        return SizedBox();
      }
      int startIndex = 0;
      int endIndex = 0;
    if(match.csid == '2'){//篮球
       startIndex = 19;
       endIndex = 23;
    }else if(match.csid == '9'){//排球
      startIndex = 120;
      endIndex = 125;
    }
      List<Widget> list = [];
      var mscmap = {
        for (var item in match.msc)
          item.split("|")[0]: item.split("|")[1].replaceAll(":","-")
      };
      var lastKey = '';
      for(int i = startIndex;i<endIndex;i++){
        if(mscmap.containsKey('S$i')){
          lastKey = 'S$i';
        }
      }
      for(int i = startIndex;i<endIndex;i++){
        if(mscmap['S$i'] != null && mscmap['S$i'] != ''){
          list.add(Text("${mscmap['S$i']!} ",style: TextStyle(color: lastKey=='S$i'?Color(0xFF179CFF):Color(0xFF303442)),));
        }
      }

    return Row(
      children: list,
    ).marginOnly(top: 5.h);
  }
}
