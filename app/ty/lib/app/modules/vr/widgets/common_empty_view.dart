import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

class CommonEmptyView extends StatelessWidget {
  const CommonEmptyView({
    super.key,
    this.icon,
    this.title = 'No data',
    this.subtitle = '',
  });

  final Widget? icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon ??
            ImageView(
              'assets/images/detail/no-data-night.svg',
              width: 186.80.w,
            ),
        const SizedBox(height: 20),
        Text(
          title.tr,
          style: TextStyle(
            color: '#323232'.hexColor,
            fontSize: 16,
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 5),
          Text(
            subtitle.tr,
            style: TextStyle(
              color: '#B2B2B2'.hexColor,
              fontSize: 13,
            ),
          ),
        ],
      ],
    );
  }
}
