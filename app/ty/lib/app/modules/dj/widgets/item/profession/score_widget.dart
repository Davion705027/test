import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key,required this.matchEntity, required this.name, required this.score});

  final String name;
  final String score;
  final MatchEntity matchEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      // color: Color(0xff303442),
                      color: context.isDarkMode? Colors.white.withOpacity(0.5):Color(0xff303442)
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          matchEntity.ms != 110 && !show_start_counting_down(matchEntity) && !show_counting_down(matchEntity)?
          SizedBox():
          Text(
            score,
            style: TextStyle(
              fontSize: 14.sp,
              // color: const Color(0xff303442),
              color: context.isDarkMode? Colors.white.withOpacity(0.5):Color(0xff303442),
              fontWeight: FontWeight.w700,
              fontFamily: 'DIN Alternate',
            ),
          )
        ],
      ),
    );
  }

  /**
   * @description: 多少分钟后开赛显示
   * @param {Object} item 赛事对象
   * @return {String}
   */
  bool show_start_counting_down  (MatchEntity item)  {
    if (item.mcg == null) {
      return false;
    }
    var r = false;
// 滚球中不需要显示多少分钟后开赛
    if (item!=null && item.ms == 1) {
      return r;
    }
    return r;
  }
//赛事状态 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
  /**
   * @description: 进行中(但不是收藏页)的赛事显示累加计时|倒计时
   * @param {Object} item 赛事对象
   * @return {Boolean}
   */
  bool show_counting_down  (MatchEntity item)  {
    return [1, 2, 10].contains(item.ms * 1);
  }

}
