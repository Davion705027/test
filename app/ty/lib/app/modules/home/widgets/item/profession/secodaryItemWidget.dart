
import '../../../../login/login_head_import.dart';

class secodaryItemWidget extends StatelessWidget {
  const secodaryItemWidget(
      {super.key,
        required this.title,
        required this.isSelected,
        required this.onTap});

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        //constraints: BoxConstraints(maxWidth: 50.h, minWidth: 40.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.03999999910593033)
              : Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          border: isSelected
              ? Border.all(
            color: const Color(0xff3AA6FC),
            width: 1.w,
          )
              : Border.all(
            color: Colors.transparent,
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? const Color(0xff3AA6FC)
                    : context.isDarkMode
                    ? const Color(0xffe5ffffff)
                    : const Color(0xff303442),
              ),
            ).marginSymmetric(horizontal: 5.w),
            Icon(
                isSelected
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 10.w,
                color: isSelected
                    ? const Color(0xff3AA6FC)
                    : const Color(0xff949AB6)),
          ],
        ),
      ),
    );
  }
}