import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

class GlobalExpandToggleWidget extends StatefulWidget {
  const GlobalExpandToggleWidget({
    super.key,
    required this.iconSrc,
    required this.title,
    required this.isExpand,
    this.onExpandChanged,
    required this.borderColor,
  });

  final String iconSrc;
  final String title;
  final bool isExpand;
  final Color borderColor;

  final ValueChanged<bool>? onExpandChanged;

  factory GlobalExpandToggleWidget.all({
    Key? key,
    required bool isExpand,
    String? iconSrc,
    String? title,
    Color? borderColor,
    ValueChanged<bool>? onExpandChanged,
  }) =>
      GlobalExpandToggleWidget(
        iconSrc: iconSrc ?? 'assets/images/league/icon_all.svg',
        title: title ?? LocaleKeys.filter_all_leagues.tr,
        borderColor: borderColor ?? '#FEAE2B'.hexColor.withOpacity(0.4),
        isExpand: isExpand,
        onExpandChanged: onExpandChanged,
      );

  @override
  State<GlobalExpandToggleWidget> createState() =>
      _GlobalExpandToggleWidgetState();
}

class _GlobalExpandToggleWidgetState extends State<GlobalExpandToggleWidget> {
  late ValueNotifier<bool> _isExpand;

  _onExpandToggle() {
    _isExpand.value = !_isExpand.value;
    widget.onExpandChanged?.call(_isExpand.value);
  }

  @override
  void initState() {
    _isExpand = ValueNotifier(widget.isExpand);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GlobalExpandToggleWidget oldWidget) {
    if (_isExpand.value != widget.isExpand) {
      _isExpand.value = widget.isExpand;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _isExpand.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onExpandToggle,
      child: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? Colors.white.withOpacity(0.03999999910593033)
              : AppColor.colorWhite,
          border: Border(
            top: BorderSide(
              color: widget.borderColor,
              width: 2,
            ),
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageView(
              widget.iconSrc,
              width: 12.w,
              height: 12.w,
            ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color:
                      Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _isExpand,
              builder: (context, isExpand, child) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: ImageView(
                    isExpand
                        ? (Get.isDarkMode
                            ? 'assets/images/league/seaction_expand_darkmode2.png'
                            : 'assets/images/league/seaction_expand.png')
                        : (Get.isDarkMode
                            ? 'assets/images/league/seaction_collpose_darkmode.png'
                            : 'assets/images/league/seaction_collpose.png'),
                    key: ValueKey(isExpand),
                    width: 16.w,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
