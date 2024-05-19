import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/// 全屏赛事分析
class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
       LocaleKeys.ouzhou_detail_event_analysis.tr,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
