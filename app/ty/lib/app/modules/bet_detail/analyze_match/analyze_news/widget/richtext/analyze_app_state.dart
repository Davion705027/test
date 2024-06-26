import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/widget/richtext/analyze_image_resizer.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../widgets/image_view.dart';
import 'analyze_app_state_manager.dart';
import 'analyze_formatting_toolbar.dart' show ToggleButtonsState;
import 'analyze_replacements.dart';

class AppState {
  const AppState({
    required this.replacementsController,
    required this.textEditingDeltaHistory,
    required this.toggleButtonsState,
  });

  final ReplacementTextEditingController replacementsController;
  final List<TextEditingDelta> textEditingDeltaHistory;
  final Set<ToggleButtonsState> toggleButtonsState;

  AppState copyWith({
    ReplacementTextEditingController? replacementsController,
    List<TextEditingDelta>? textEditingDeltaHistory,
    Set<ToggleButtonsState>? toggleButtonsState,
  }) {
    return AppState(
      replacementsController:
          replacementsController ?? this.replacementsController,
      textEditingDeltaHistory:
          textEditingDeltaHistory ?? this.textEditingDeltaHistory,
      toggleButtonsState: toggleButtonsState ?? this.toggleButtonsState,
    );
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({super.key, required this.child});

  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  State<AppStateWidget> createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  AppState _data = AppState(
    replacementsController: ReplacementTextEditingController(
        //默认文本
        text: 'Hello Taxze'),
    textEditingDeltaHistory: <TextEditingDelta>[],
    toggleButtonsState: <ToggleButtonsState>{},
  );

  void updateTextEditingDeltaHistory(List<TextEditingDelta> textEditingDeltas) {
    _data = _data.copyWith(textEditingDeltaHistory: <TextEditingDelta>[
      ..._data.textEditingDeltaHistory,
      ...textEditingDeltas
    ]);
    setState(() {});
  }

  void updateToggleButtonsStateOnSelectionChanged(
      TextSelection selection, ReplacementTextEditingController controller) {
    // 当选择发生变化时，我们希望在new处检查替换选择。根据找到的替换来启用或禁用切换按钮在新的选择。
    final List<TextStyle> replacementStyles =
        controller.getReplacementsAtSelection(selection);
    final Set<ToggleButtonsState> hasChanged = {};

    if (replacementStyles.isEmpty) {
      _data = _data.copyWith(
        toggleButtonsState: Set.from(_data.toggleButtonsState)
          ..removeAll({
            ToggleButtonsState.bold,
            ToggleButtonsState.italic,
            ToggleButtonsState.underline,
          }),
      );
    }

    for (final TextStyle style in replacementStyles) {
      if (style.fontWeight != null &&
          !hasChanged.contains(ToggleButtonsState.bold)) {
        _data = _data.copyWith(
          toggleButtonsState: Set.from(_data.toggleButtonsState)
            ..add(ToggleButtonsState.bold),
        );
        hasChanged.add(ToggleButtonsState.bold);
      }

      if (style.fontStyle != null &&
          !hasChanged.contains(ToggleButtonsState.italic)) {
        _data = _data.copyWith(
          toggleButtonsState: Set.from(_data.toggleButtonsState)
            ..add(ToggleButtonsState.italic),
        );
        hasChanged.add(ToggleButtonsState.italic);
      }

      if (style.decoration != null &&
          !hasChanged.contains(ToggleButtonsState.underline)) {
        _data = _data.copyWith(
          toggleButtonsState: Set.from(_data.toggleButtonsState)
            ..add(ToggleButtonsState.underline),
        );
        hasChanged.add(ToggleButtonsState.underline);
      }
    }

    for (final TextStyle style in replacementStyles) {
      if (style.fontWeight == null &&
          !hasChanged.contains(ToggleButtonsState.bold)) {
        _data = _data.copyWith(
          toggleButtonsState: Set.from(_data.toggleButtonsState)
            ..remove(ToggleButtonsState.bold),
        );
        hasChanged.add(ToggleButtonsState.bold);
      }

      if (style.fontStyle == null &&
          !hasChanged.contains(ToggleButtonsState.italic)) {
        _data = _data.copyWith(
          toggleButtonsState: Set.from(_data.toggleButtonsState)
            ..remove(ToggleButtonsState.italic),
        );
        hasChanged.add(ToggleButtonsState.italic);
      }

      if (style.decoration == null &&
          !hasChanged.contains(ToggleButtonsState.underline)) {
        _data = _data.copyWith(
          toggleButtonsState: Set.from(_data.toggleButtonsState)
            ..remove(ToggleButtonsState.underline),
        );
        hasChanged.add(ToggleButtonsState.underline);
      }
    }

    setState(() {});
  }

  Future<void> updateToggleButtonsStateOnButtonPressed(int index) async {
    Map<int, TextStyle> attributeMap = const <int, TextStyle>{
      0: TextStyle(fontWeight: FontWeight.bold),
      1: TextStyle(fontStyle: FontStyle.italic),
      2: TextStyle(decoration: TextDecoration.underline),
    };

    final ReplacementTextEditingController controller =
        _data.replacementsController;
    final TextRange replacementRange = TextRange(
      start: controller.selection.start,
      end: controller.selection.end,
    );

    final targetToggleButtonState = ToggleButtonsState.values[index];

    if (_data.toggleButtonsState.contains(targetToggleButtonState)) {
      _data = _data.copyWith(
        toggleButtonsState: Set.from(_data.toggleButtonsState)
          ..remove(targetToggleButtonState),
      );
    } else {
      _data = _data.copyWith(
        toggleButtonsState: Set.from(_data.toggleButtonsState)
          ..add(targetToggleButtonState),
      );
    }

    if (_data.toggleButtonsState.contains(targetToggleButtonState)) {
      controller.applyReplacement(
        TextEditingInlineSpanReplacement(
          replacementRange,
          (string, range) => TextSpan(text: string, style: attributeMap[index]),
          true,
        ),
      );
      _data = _data.copyWith(replacementsController: controller);
      setState(() {});
    } else {
      controller.disableExpand(attributeMap[index]!);
      controller.removeReplacementsAtRange(
          replacementRange, attributeMap[index]);
      _data = _data.copyWith(replacementsController: controller);
      setState(() {});
    }
  }

  getImage(BuildContext context) async {
    final ReplacementTextEditingController controller =
        _data.replacementsController;
    final TextRange replacementRange = TextRange(
      start: controller.selection.start,
      end: controller.selection.end,
    );
    File? image;
    //默认尺寸
    double width = 100.0;
    double height = 100.0;
    var getImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(getImage!.path);
    controller.applyReplacement(
      TextEditingInlineSpanReplacement(
          replacementRange,
          (string, range) => WidgetSpan(
                  child: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup<void>(
                      context: context,
                      builder: (context) {
                        return ImageResizer(
                            onImageResize: (w, h) {
                                width = w;
                                height = h;
                            },
                            imageWidth: width,
                            imageHeight: height,
                            maxWidth: MediaQuery.of(context).size.width * 0.5,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.5);
                      });
                },
                child: ImageView(
                  getImage!.path!,
                  width: width,
                  height: height,
                ),
              )),
          true,
          isWidget: true),
    );
    _data = _data.copyWith(replacementsController: controller);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppStateManager(
      state: _data,
      child: widget.child,
    );
  }
}
