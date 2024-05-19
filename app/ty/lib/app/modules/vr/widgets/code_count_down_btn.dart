import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:get/get.dart';

typedef GetCodeFunction = Future<bool> Function();

class CodeCountDownBtn extends StatefulWidget {
  const CodeCountDownBtn({
    super.key,
    this.maxSeconds = 60,
    this.onGetCode,
    this.focusNode,
  });

  final int maxSeconds;
  final GetCodeFunction? onGetCode;
  final FocusNode? focusNode;

  @override
  State<CodeCountDownBtn> createState() => _CodeCountDownBtnState();
}

class _CodeCountDownBtnState extends State<CodeCountDownBtn> {
  Timer? _timer;
  late int _countDown;

  Future<void> _onTap() async {
    if (_timer != null) return;
    bool success = false;
    if (widget.onGetCode != null) {
      success = await widget.onGetCode?.call() ?? false;
    }

    if (!success) return;
    widget.focusNode?.requestFocus();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_countDown <= 1) {
        _timer?.cancel();
        _timer = null;
        setState(() {
          _countDown = widget.maxSeconds;
        });
        return;
      }
      setState(() {
        _countDown -= 1;
      });
    });
  }

  @override
  void initState() {
    _countDown = widget.maxSeconds;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 30),
        child: Text(
          _countDown == widget.maxSeconds
              ? 'Send code'.tr
              : '${'Resend code'.tr}(${_countDown.toString().padLeft(2, '0')}s)',
          style: TextStyle(
            fontSize: 14,
            color: _countDown == widget.maxSeconds
                ? '#597EF7'.hexColor
                : '#B2B2B2'.hexColor,
          ),
        ).center,
      ),
    );
  }


  Widget getCountDownView(){
    return InkWell(
      onTap: _onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 30),
        child: Text(
          _countDown == widget.maxSeconds
              ? 'Send code'.tr
              : '${'Resend code'.tr}(${_countDown.toString().padLeft(2, '0')}s)',
          style: TextStyle(
            fontSize: 14,
            color: _countDown == widget.maxSeconds
                ? '#597EF7'.hexColor
                : '#B2B2B2'.hexColor,
          ),
        ).center,
      ),
    );
  }
}
