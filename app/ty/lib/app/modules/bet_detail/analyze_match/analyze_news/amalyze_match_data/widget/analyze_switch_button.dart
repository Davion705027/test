import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';


class AnalyzeSwitchButton extends StatefulWidget {
  ValueChanged<bool>? onChanged;

  AnalyzeSwitchButton({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
   return AnalyzeSwitchButtonState(true);
  }
}

class AnalyzeSwitchButtonState extends State<AnalyzeSwitchButton> {
  bool value;

  AnalyzeSwitchButtonState(
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        value=!value;
        setState(() {
        });
        if(widget.onChanged!=null) {
          widget.onChanged!(value);
        }
      },
      child: ImageView(
          value
              ? 'assets/images/home/icon_switch_sel.png'
              : 'assets/images/home/icon_switch_nor.png',
          width: 16.w),
    );
  }
}
