import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';


class AnalyzeDivider extends StatelessWidget {
  Color? bgColor;
  AnalyzeDivider({super.key, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: bgColor??Colors.transparent,
      height:  0.2,
      alignment: Alignment.centerLeft,
      child: Divider(
        height: 0.2,
        color:  Get.theme.betPanelUnderlineColor,
      ),
    );
  }

}
