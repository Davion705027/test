import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../utils/oss_util.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton(
      {Key? key,
      required this.onChild,
      required this.offChild,
      required this.onChanged,
      this.hasIcon = false,
      required this.value,
      this.enable = true})
      : super(key: key);
  final Widget onChild;
  final Widget offChild;
  final bool hasIcon;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    double width = (Get.width - 32.w) / 3;

    /// 实现一个切换按钮
    return Container(
      width: width,
      decoration: context.isDarkMode
          ? ShapeDecoration(
              color: Colors.white.withOpacity(0.03999999910593033),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            )
          : BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    'assets/images/home/switch_sports.png',
                  ),
                ),
                fit: BoxFit.fill,
              ),
            ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if (value || !enable) return;
              onChanged(true);
            },
            child: DefaultTextStyle(
              style: value && enable
                  ? TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.699999988079071)
                          : const Color(0xff303442),
                    )
                  : TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.30000001192092896)
                          : const Color(0xff7981A4),
                    ),
              child: Container(
                margin: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: (value && context.isDarkMode && enable)
                    ? ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [
                            Colors.white.withOpacity(0.05000000074505806),
                            Colors.white.withOpacity(0.10000000149011612),
                            Colors.white.withOpacity(0.029999999329447746)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    : value && enable
                        ? ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Colors.white,
                                Color(0xFFEEF1F8),
                                Color(0xFFF8FDFF)
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x337981A3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          )
                        : null,
                width: width * 0.5 - 4,
                child: Container(
                  margin: const EdgeInsets.all(2),
                  child: hasIcon
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            onChild,
                            ImageView(
                                value && enable
                                    ? 'assets/images/home/icon_switch_sel.png'
                                    : context.isDarkMode?'assets/images/home/icon_switch_nor_night.png':"assets/images/home/icon_switch_nor2.png",
                                width: 16.w)
                          ],
                        )
                      : onChild,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (!value || !enable) return;
              onChanged(false);
            },
            child: DefaultTextStyle(
              style: !value && enable
                  ? TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.699999988079071)
                          : const Color(0xff303442),
                    )
                  : TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.30000001192092896)
                          : const Color(0xff7981A4),
                    ),
              child: Container(
                margin: const EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: (!value && context.isDarkMode && enable)
                    ? ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [
                            Colors.white.withOpacity(0.05000000074505806),
                            Colors.white.withOpacity(0.10000000149011612),
                            Colors.white.withOpacity(0.029999999329447746)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    : !value && enable
                        ? ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Colors.white,
                                Color(0xFFEEF1F8),
                                Color(0xFFF8FDFF)
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x337981A3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          )
                        : null,
                height: 24.h,
                width: width * 0.5 - 4,
                child: hasIcon
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: width * 0.5 - 4 - 20.w, minWidth: 5),
                            child: offChild,
                          ),
                           ImageView(
                              !value && enable
                                  ? 'assets/images/home/icon_switch_sel.png'
                                  : context.isDarkMode?'assets/images/home/icon_switch_nor_night.png':"assets/images/home/icon_switch_nor2.png",
                              width: 16.w)
                        ],
                      )
                    : offChild,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
