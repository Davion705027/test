import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';

/// 棒球比分模板
class ScoreChild3 extends StatefulWidget {
  const ScoreChild3({super.key, required this.match});

  final MatchEntity match;

  @override
  State<ScoreChild3> createState() => _ScoreChild3State();
}

class _ScoreChild3State extends State<ScoreChild3> {
  @override
  void initState() {
    //页面刷新后检查mmp的阶段，来判断是否需要填充比分
    if (mmpObj.keys.contains(widget.match.mmp)) {
      Bus.getInstance()
          .emit(EventType.nativeDetailData, '${mmpObj[widget.match.mmp]}|0:0');
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild3 oldWidget) {
    if (mmpObj.keys.contains(widget.match.mmp)) {
      Bus.getInstance()
          .emit(EventType.nativeDetailData, '${mmpObj[widget.match.mmp]}|0:0');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    MatchEntity match = widget.match;

    if (match.mmp == "0") {
      return Container();
    }

    // mmp 32 等待加时  40 加时赛  110加时赛结束
    // msc S7表示公共加时赛比分
    List<String> scoreList = scoreArray(match);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 一垒二垒三垒
              SizedBox(
                width: 12.w,
                height: 12.h,
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: BaseballDiamondPainter(
                        mbolp: match.mbolp == "1",
                        mbthlp: match.mbthlp == "1",
                        mbtlp: match.mbtlp == "1"),
                  ),
                ),
              ).marginOnly(right: 8.w),
              _buildInfo(LocaleKeys.match_info_ball.tr, match.mbkn)
                  .marginOnly(right: 6.w),
              _buildInfo(LocaleKeys.match_info_strike.tr, match.mbhn)
                  .marginOnly(right: 6.w),
              _buildInfo(LocaleKeys.match_info_strike_out.tr, match.mbcn)
                  .marginOnly(right: 6.w),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (scoreList.length >= 5)
                CustomPaint(
                  size: Size(3.w, 6.w),
                  painter: TrianglePainter(TriangleDirection.left),
                ),
              Container(
                  width: 135.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: scoreList.map((e) {
                        int index = scoreList.indexOf(e) + 1;
                        // 棒球客队先进攻，客队先得分  只有一个数字的时候，是客队的得分。下半局是主队进攻，才是主队得分，主队的分在前面
                        if (mmpArr.contains(match.mmp) &&
                            index == scoreList.length) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e.split(':')[1],
                                style: TextStyle(
                                  color: index == scoreList.length &&
                                          match.mo != 1
                                      ? const Color.fromRGBO(255, 206, 99, 1)
                                      : Colors.white,
                                  fontSize: 13.sp,
                                  fontFamily: 'Akrobat',
                                ),
                              ).marginOnly(right: 2.w),
                              // 向上的三角形
                              CustomPaint(
                                size: Size(6.w, 8.w),
                                painter: TrianglePainter(TriangleDirection.top),
                              )
                            ],
                          ).marginOnly(right: 8.w);
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e.split(':')[0],
                                style: TextStyle(
                                  color: index == scoreList.length &&
                                          match.mo != 1
                                      ? const Color.fromRGBO(255, 206, 99, 1)
                                      : Colors.white,
                                  fontSize: 13.sp,
                                  fontFamily: 'Akrobat',
                                ),
                              ),
                              Text(
                                "-${e.split(':')[1]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontFamily: 'Akrobat',
                                ),
                              )
                            ],
                          ).marginOnly(right: 8.w);
                        }
                      }).toList(),
                    ),
                  )),
              if (scoreList.length >= 5)
                CustomPaint(
                  size: Size(3.w, 6.w),
                  painter: TrianglePainter(TriangleDirection.right),
                )
            ],
          )
        ]);
  }

  Widget _buildInfo(String text, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$text:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontFamily: 'Akrobat',
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: const Color.fromRGBO(23, 156, 255, 1),
              fontSize: 13.sp,
              fontFamily: 'Akrobat',
            ),
          ),
        ],
      ),
    );
  }

  ///@description 棒球比分集合
  ///@return {Array} 棒球比分
  List<String> scoreArray(MatchEntity match) {
    List<String> scoreArr = [];
    List<String> msc = match.msc;

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });

    List<String> mscArray = [];
    for (var i = 120; i <= 159; i++) {
      mscArray.add('S$i');
    }

    // 循环只取出接口返回的比分里面符合棒球球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    return scoreArr;
  }
}

//详情页显示为上半局需要显示箭头的阶段
List<String> mmpArr = [
  '401',
  '422',
  '403',
  '424',
  '405',
  '426',
  '407',
  '428',
  '409',
  '430',
  '411',
  '432',
  '413',
  '434',
  '415',
  '436',
  '417',
  '43910',
  '43810',
  '41911',
  '43811',
  '41912',
  '43812',
  '41913',
  '43813',
  '41914',
  '43814',
  '41915',
  '43815',
  '41916',
  '43816',
  '41917',
  '43817',
  '41918',
  '43818',
  '41919',
  '43819',
  '41920'
];
//根据赛事阶段mmp填充比分  比如 当 mmp是424 "第二，三局间休息" 时，要将第三局比分'S122'自动填充
//填充的比分只是临时有效，并没有存到持久化里面，所以页面刷新后也要判断处理一遍
Map<String, String> mmpObj = {
//默认9局
  '401': 'S120',
  '422': 'S121',
  '424': 'S122',
  '426': 'S123',
  '428': 'S124',
  '430': 'S125',
  '432': 'S126',
  '434': 'S127',
  '436': 'S128',
//下面是加时赛阶段（这里写到第20局）
  '438': 'S129',
  '43810': 'S130',
  '43811': 'S131',
  '43812': 'S132',
  '43813': 'S132',
  '43814': 'S134',
  '43815': 'S135',
  '43816': 'S136',
  '43817': 'S137',
  '43818': 'S138',
  '43819': 'S139',
};

class BaseballDiamondPainter extends CustomPainter {
  // 一垒二垒三垒
  final bool mbtlp;
  final bool mbolp;
  final bool mbthlp;
  final Color mbColor;
  final Color normalColor;

  BaseballDiamondPainter({
    super.repaint,
    this.mbtlp = false,
    this.mbolp = false,
    this.mbthlp = false,
    this.mbColor = const Color.fromRGBO(23, 156, 255, 1),
    this.normalColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    // 定义菱形的宽度和高度
    double diamondWidth = 8.w;
    double diamondHeight = 8.h;

    // 两个菱形之间的距离
    double distance = 4.w;

    Paint paint = Paint()..style = PaintingStyle.fill;
    // Color.fromRGBO(23, 156, 255, 1)
    if (mbtlp) {
      paint.color = mbColor;
    } else {
      paint.color = normalColor;
    }
    // 绘制上面的菱形 二垒
    Path topDiamondPath = Path()
      ..moveTo(width / 2, height / 2 - diamondHeight) // 上中点
      ..lineTo(
          width / 2 - diamondWidth / 2, height / 2 - diamondHeight / 2) // 左上角
      ..lineTo(width / 2, height / 2) // 下中点
      ..lineTo(
          width / 2 + diamondWidth / 2, height / 2 - diamondHeight / 2) // 右上角
      ..close();
    canvas.drawPath(topDiamondPath, paint);

    if (mbthlp) {
      paint.color = mbColor;
    } else {
      paint.color = normalColor;
    }
    // 绘制左下角的菱形 三垒
    Path leftDiamondPath = Path()
      ..moveTo(width / 2 - diamondWidth / 2 - distance,
          height / 2 + diamondHeight / 2 - distance / 2) // 左下角
      ..lineTo(width / 2 - distance,
          height / 2 + diamondHeight - distance / 2) // 下左角
      ..lineTo(width / 2 + diamondWidth / 2 - distance,
          height / 2 + diamondHeight / 2 - distance / 2) // 下右角
      ..lineTo(width / 2 - distance, height / 2 - distance / 2) // 上中点
      ..close();
    canvas.drawPath(leftDiamondPath, paint);
    if (mbolp) {
      paint.color = mbColor;
    } else {
      paint.color = normalColor;
    }
    // 绘制右下角的菱形 一垒
    Path rightDiamondPath = Path()
      ..moveTo(width / 2 + diamondWidth / 2 + distance,
          height / 2 + diamondHeight / 2 - distance / 2) // 右下角
      ..lineTo(width / 2 + distance,
          height / 2 + diamondHeight - distance / 2) // 下右角
      ..lineTo(width / 2 - diamondWidth / 2 + distance,
          height / 2 + diamondHeight / 2 - distance / 2) // 下左角
      ..lineTo(width / 2 + distance, height / 2 - distance / 2) // 上中点
      ..close();
    canvas.drawPath(rightDiamondPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

enum TriangleDirection {
  left,
  right,
  top,
}

class TrianglePainter extends CustomPainter {
  final TriangleDirection direction;

  TrianglePainter(this.direction);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = direction == TriangleDirection.top ? Colors.white : Colors.blue
      ..style = PaintingStyle.fill;

    Path path = Path();

    if (direction == TriangleDirection.left) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height / 2);
    } else if (direction == TriangleDirection.right) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height / 2);
    }
    // 向上
    else {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
