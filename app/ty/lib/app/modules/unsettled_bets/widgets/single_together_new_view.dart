import '../../login/login_head_import.dart';
import 'dashed_line_painter_view.dart';
import 'information_line_view.dart';
import 'information_view.dart';

class SingleTogetherNewView extends StatefulWidget {
  const SingleTogetherNewView({
    Key? key,
    required this.marketValue,
    required this.oddFinally,
    required this.playName,
    required this.scoreBenchmark,
    required this.matchInfo,
    this.settleScore = "",
    this.betResult = "",
    required this.sportName,
    required this.topType,
    required this.bottomType,
    required this.betResultColor,
  }) : super(key: key);

  final String marketValue,
      oddFinally,
      playName,
      scoreBenchmark,
      matchInfo,
      settleScore,
      betResult,
      sportName;

  final bool betResultColor;

  /// topType:0  是不显示头部的线条 topType:1  显示头部的线条
  final int topType;

  /// bottomType:0  不显示线条
  /// bottomType:1  显示实线蓝色线条
  /// bottomType:2  显示虚线蓝色线条
  final int bottomType;

  @override
  State<SingleTogetherNewView> createState() => _SingleTogetherViewState();
}

class _SingleTogetherViewState extends State<SingleTogetherNewView> {
  final GlobalKey _menuItemKey = GlobalKey();
  double hight1 = 0.0; //获取计算弹框位置ç

  @override
  Widget build(BuildContext context) {
    //int height = 115;
    //if (widget.settleScore.isEmpty && widget.betResult.isEmpty) {
    //  height = height - 20;
    //}
    //if (widget.scoreBenchmark.isEmpty) {
    //  height = height - 20;
    //}

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox _menuIte =
          _menuItemKey!.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        hight1 = _menuIte.size.height;
      });
      //  print("SingleTogetherView:${_menuIte.size.height}");
    });

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 1.w,
                height: 16,
                color: widget.topType == 0
                    ? null
                    : context.isDarkMode
                        ? const Color(0xFF127DCC)
                        : const Color(0xff179CFF),
              ),
              Container(
                width: 6.w,
                height: 6,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: context.isDarkMode
                          ? const Color(0xFF127DCC)
                          : const Color(0xff179CFF),
                    ),
                  ),
                ),
              ),
              Container(
                child: widget.bottomType == 2
                    ? RepaintBoundary(
                        child: CustomPaint(
                          size: Size(1, hight1 > 0 ? hight1 - 6 - 16 : 10),
                          painter: DashedLinePainter(
                            color: context.isDarkMode
                                ? const Color(0xFF127DCC)
                                : const Color(0xff179CFF),
                          ),
                        ),
                      )
                    : Container(
                        height: hight1 > 0 ? hight1 - 6 - 16 : 10,
                        width: 1.w,
                        color: widget.bottomType == 0
                            ? null
                            : context.isDarkMode
                                ? const Color(0xFF127DCC)
                                : const Color(0xff179CFF),
                      ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     width: 1.w,
              //     color: const Color(0xFF179CFF),
              //   ),
              // )
            ],
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            key: _menuItemKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.marketValue,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.8999999761581421)
                              : const Color(0xFF303442),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.oddFinally,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xFF179CFF),
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                InformationLineView(
                  top: 4,
                  information: widget.playName,
                  multiLine: false,
                  Type: 0,
                ),
                if (widget.scoreBenchmark.isNotEmpty)
                  InformationLineView(
                    top: 4,
                    information: widget.scoreBenchmark,
                    multiLine: true,
                    Type: 0,
                  ),
                InformationLineView(
                  top: 4,
                  information: widget.matchInfo,
                  multiLine: true,
                  Type: 1,
                ),
                if (widget.settleScore.isNotEmpty ||
                    widget.betResult.isNotEmpty)
                  InformationView(
                    top: 4,
                    information: widget.settleScore,
                    outcome: widget.betResult,
                    InformationColorType: widget.betResultColor ? 3 : 0,
                  ),
                InformationLineView(
                  top: 4,
                  multiLine: true,
                  information: widget.sportName,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
