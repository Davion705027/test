import 'dart:io';

import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:video_player/video_player.dart';

enum VideoTypeOther {
  network,
  file,
  asset,
}

class VrVideoPlayerPlusOther extends StatefulWidget {
  // 视频类型 本地 /网络
  final VideoTypeOther videoType;

  // 加载好视频后跳转到第几秒开始播放?
  final int? seekToSecond;

  // 循环播放
  final bool looping;

  // 视频地址
  final String videoPath;

  //自动播放？
  final bool autoPlay;
  final void Function(
    Duration videoPosition,
    bool isFinished,
    VrSportReplayDetailScoreRanking? scoreInfo,
  )? onVideoPositionChanged;

  final List<String> teams;

  final String curSeconds;

  final bool showScoreInfo;

  final VrSportReplayDetailValue? replayDetailValue;

  const VrVideoPlayerPlusOther({
    Key? key,
    required this.videoType,
    required this.videoPath,
    this.autoPlay = true,
    this.looping = false,
    this.seekToSecond,
    this.teams = const [],
    this.curSeconds = '',
    this.showScoreInfo = false,
    this.replayDetailValue,
    this.onVideoPositionChanged,
  }) : super(key: key);

  const VrVideoPlayerPlusOther.network(
    this.videoPath, {
    Key? key,
    this.videoType = VideoTypeOther.network,
    this.autoPlay = false,
    this.looping = false,
    this.seekToSecond,
    this.teams = const [],
    this.curSeconds = '',
    this.showScoreInfo = false,
    this.replayDetailValue,
    this.onVideoPositionChanged,
  }) : super(key: key);

  const VrVideoPlayerPlusOther.file(
    this.videoPath, {
    Key? key,
    this.videoType = VideoTypeOther.file,
    this.autoPlay = false,
    this.looping = false,
    this.seekToSecond,
    this.teams = const [],
    this.curSeconds = '',
    this.showScoreInfo = false,
    this.replayDetailValue,
    this.onVideoPositionChanged,
  }) : super(key: key);

  const VrVideoPlayerPlusOther.asset(
    this.videoPath, {
    Key? key,
    this.videoType = VideoTypeOther.asset,
    this.autoPlay = false,
    this.looping = false,
    this.seekToSecond,
    this.teams = const [],
    this.curSeconds = '',
    this.showScoreInfo = false,
    this.replayDetailValue,
    this.onVideoPositionChanged,
  }) : super(key: key);

  @override
  VrVideoPlayerPlusState createState() => VrVideoPlayerPlusState();
}

class VrVideoPlayerPlusState extends State<VrVideoPlayerPlusOther> {
  late final VideoPlayerController _videoCtl;

  // 视频总秒数，初始为1，后面视频加载好后会赋值
  int _videoTotalSecond = 1;

  late ValueNotifier<int> _videoPosition;
  late ValueNotifier<VrSportReplayDetailScoreRanking?> _scoreInfo;
  _videoPlayerControllerListener() {
    final position = _videoCtl.value.position;
    _videoPosition.value = position.inSeconds;
    _scoreInfo.value = _teamsScore(position.inMilliseconds);
    widget.onVideoPositionChanged?.call(
      _videoCtl.value.position,
      _videoPosition.value >= _videoTotalSecond,
      _scoreInfo.value,
    );
  }

  late ValueNotifier<bool> _videoMute;
  void _initVideoPlayerController() {
    switch (widget.videoType) {
      case VideoTypeOther.network:
        _videoCtl =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
      case VideoTypeOther.file:
        _videoCtl = VideoPlayerController.file(File(widget.videoPath));
      case VideoTypeOther.asset:
        _videoCtl = VideoPlayerController.asset(widget.videoPath);
    }

    _videoCtl
      ..initialize().then(
        (_) {
          // 确保在初始化视频后显示第一帧，直至在按下播放按钮。
          if (widget.autoPlay) {
            _videoCtl.play();
          }

          _videoCtl.setLooping(widget.looping);
          _videoTotalSecond = _videoCtl.value.duration.inSeconds;

          _videoCtl.setVolume(0);

          //确保跳转的秒数小于等于视频的总秒数，如果大于则不跳转
          if (widget.seekToSecond != null) {
            if (widget.seekToSecond! <= _videoTotalSecond) {
              _videoCtl.seekTo(widget.seekToSecond!.seconds);
            }
          }

          if (mounted) setState(() {});
        },
      )
      ..addListener(_videoPlayerControllerListener);
  }

  @override
  void initState() {
    _videoPosition = ValueNotifier(1);
    _videoMute = ValueNotifier(true);
    _scoreInfo = ValueNotifier(null);
    _initVideoPlayerController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPosition.dispose();
    _videoMute.dispose();
    _scoreInfo.dispose();
    _videoCtl.removeListener(_videoPlayerControllerListener);
    _videoCtl.dispose();
  }


  Widget _buildScoreViews() {
    final minHeight = 25.w;
    return UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black26,
              constraints: BoxConstraints(minHeight: minHeight),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Row(
                children: [
                  Text(
                    widget.teams.firstOrNull ?? '布莱顿海鸥',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _scoreInfo,
                    builder: (context, scoreInfo, child) {
                      return Text(
                        '${scoreInfo?.home ?? '0'}-${scoreInfo?.away ?? '0'}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  ).marginSymmetric(horizontal: 30),
                  Text(
                    widget.teams.lastOrNull ?? '维拉人',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              constraints: BoxConstraints(minWidth: 20, minHeight: minHeight),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: widget.curSeconds.isNotEmpty
                  ? Text(
                widget.curSeconds,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColor.colorWhite,
                  fontStyle: FontStyle.italic,
                ),
              ).center
                  : ValueListenableBuilder(
                valueListenable: _videoPosition,
                builder: (context, seconds, child) {
                  return Text(
                    "$seconds'",
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColor.colorWhite,
                      fontStyle: FontStyle.italic,
                    ),
                  ).center;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_videoCtl.value.isInitialized) VideoPlayer(_videoCtl),
        if (widget.showScoreInfo)
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: _buildScoreInfo(),
          ),
        Positioned(
          right: 8,
          bottom: 8,
          child: GestureDetector(
            onTap: () {
              _videoMute.value = !_videoMute.value;
              if (_videoMute.value) {
                _videoCtl.setVolume(0);
              } else {
                _videoCtl.setVolume(1);
              }
            },
            child: ValueListenableBuilder(
              valueListenable: _videoMute,
              builder: (context, mute, child) {
                return ImageView(
                  mute
                      ? 'assets/images/vr/video_mute.svg'
                      : 'assets/images/vr/video_volume.svg',
                  key: ValueKey(mute),
                  width: 20.w,
                  height: 20.w,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScoreInfo() {
    final minHeight = 25.w;
    return UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black26,
              constraints: BoxConstraints(minHeight: minHeight),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Row(
                children: [
                  Text(
                    widget.teams.firstOrNull ?? '布莱顿海鸥',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _scoreInfo,
                    builder: (context, scoreInfo, child) {
                      return Text(
                        '${scoreInfo?.home ?? '0'}-${scoreInfo?.away ?? '0'}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  ).marginSymmetric(horizontal: 30),
                  Text(
                    widget.teams.lastOrNull ?? '维拉人',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              constraints: BoxConstraints(minWidth: 20, minHeight: minHeight),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: widget.curSeconds.isNotEmpty
                  ? Text(
                      widget.curSeconds,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColor.colorWhite,
                        fontStyle: FontStyle.italic,
                      ),
                    ).center
                  : ValueListenableBuilder(
                      valueListenable: _videoPosition,
                      builder: (context, seconds, child) {
                        return Text(
                          "$seconds'",
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColor.colorWhite,
                            fontStyle: FontStyle.italic,
                          ),
                        ).center;
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

extension VrVideoPlayerPlusStateHelper on VrVideoPlayerPlusState {
  VrSportReplayDetailScoreRanking? _teamsScore(int curMilliseconds) {
    final scoreInfos = widget.replayDetailValue?.list ?? [];

    final curScoreIndex = scoreInfos.lastIndexWhere(
      (scoreInfo) =>
          curMilliseconds >=
          ((double.tryParse(scoreInfo.updateTime) ?? 0) * 1000),
    );

    if (curScoreIndex != -1) {
      widget.replayDetailValue?.curScoreIndex = curScoreIndex;
      final scoreInfo = scoreInfos[curScoreIndex];
      return scoreInfo;
    }

    return null;
  }
}
