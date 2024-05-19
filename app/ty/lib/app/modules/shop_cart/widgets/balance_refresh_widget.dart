import 'package:flutter/material.dart';

import '../../../global/user_controller.dart';
import '../../../widgets/image_view.dart';

class BalanceRefreshWidget extends StatefulWidget {
  const BalanceRefreshWidget({this.width=20,this.height=20,Key? key}) : super(key: key);
  final double width;
  final double height;

  @override
  _BalanceRefreshState createState() => _BalanceRefreshState();
}

class _BalanceRefreshState extends State<BalanceRefreshWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController,
      child: ImageView('assets/images/shopcart/refresh1.png',
        width: widget.width,
        height: widget.height,
        onTap: () async{
          if(!_animationController.isAnimating) {
            _animationController.repeat();
            await UserController.to.getBalance();

            Future.delayed(Duration(milliseconds: ((1 - _animationController.value)*1000).toInt() ),(){
              _animationController.stop();
            });
          }
        },
      ),
    );
  }
}