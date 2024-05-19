import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';

class GlobalFadeTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const GlobalFadeTransition({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  _GlobalFadeTransitionState createState() => _GlobalFadeTransitionState();
}

class _GlobalFadeTransitionState extends State<GlobalFadeTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );


    _controller.addListener(() {
      if(_controller.isAnimating){
        if(!HomeController.to.visiable){
          _controller.stop(canceled: true);
          _controller.dispose();
        }
      }
    });


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
