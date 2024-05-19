// import 'package:fijkplayer/fijkplayer.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'basket_vlc_video_player_view.dart';
import 'video_player_plus.dart';

class BasketVlcVideoPlayerPlus extends StatefulWidget {
  // 视频类型 本地 /网络
  final VideoType videoType;

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
  final void Function(
    Duration videoPosition,
    bool isFinished,
    Map<String, VrSportReplayDetailScoreRanking?> scoreInfoMap,
  )? onBasketballVideoPositionChanged;

  final List<String> teams;

  final String curSeconds;

  final bool showScoreInfo;

  final VrSportReplayDetailValue? replayDetailValue;
  final VrSportReplayEntity? replayEntity;

  final double aspectRatio;
  final String aspectRatioStr;

  const BasketVlcVideoPlayerPlus({
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
    this.replayEntity,
    this.onVideoPositionChanged,
    this.onBasketballVideoPositionChanged,
    this.aspectRatio = 16 / 9,
    this.aspectRatioStr = '16:9',
  }) : super(key: key);

  const BasketVlcVideoPlayerPlus.network(
    this.videoPath, {
    Key? key,
    this.videoType = VideoType.network,
    this.autoPlay = false,
    this.looping = false,
    this.seekToSecond,
    this.teams = const [],
    this.curSeconds = '',
    this.showScoreInfo = false,
    this.replayDetailValue,
    this.replayEntity,
    this.onVideoPositionChanged,
    this.onBasketballVideoPositionChanged,
    this.aspectRatio = 16 / 9,
    this.aspectRatioStr = '16:9',
  }) : super(key: key);

  const BasketVlcVideoPlayerPlus.file(
    this.videoPath, {
    Key? key,
    this.videoType = VideoType.file,
    this.autoPlay = false,
    this.looping = false,
    this.seekToSecond,
    this.teams = const [],
    this.curSeconds = '',
    this.showScoreInfo = false,
    this.replayDetailValue,
    this.replayEntity,
    this.onVideoPositionChanged,
    this.onBasketballVideoPositionChanged,
    this.aspectRatio = 16 / 9,
    this.aspectRatioStr = '16:9',
  }) : super(key: key);

  const BasketVlcVideoPlayerPlus.asset(
    this.videoPath, {
    Key? key,
    this.videoType = VideoType.asset,
    this.autoPlay = false,
    this.looping = false,
    this.seekToSecond,
    this.teams = const [],
    this.curSeconds = '',
    this.showScoreInfo = false,
    this.replayDetailValue,
    this.replayEntity,
    this.onVideoPositionChanged,
    this.onBasketballVideoPositionChanged,
    this.aspectRatio = 16 / 9,
    this.aspectRatioStr = '16:9',
  }) : super(key: key);

  @override
  BasketVlcVideoPlayerPlusState createState() =>
      BasketVlcVideoPlayerPlusState();
}

class BasketVlcVideoPlayerPlusState extends State<BasketVlcVideoPlayerPlus> {
  late VlcPlayerController _videoPlayerController;

  _videoPlayerControllerListener() {
    final position = _videoPlayerController.value.position;
    _videoPosition.value = position.inSeconds;
    final curMilliseconds = position.inMilliseconds;
    _scoreInfo.value = _teamsScore(
      curMilliseconds,
      widget.replayDetailValue,
    );
    widget.onVideoPositionChanged?.call(
      _videoPlayerController.value.position,
      _videoPosition.value >= _videoTotalSecond,
      _scoreInfo.value,
    );

    // 篮球比分
    final teamScores = _basketballTeamsScores(curMilliseconds);
    widget.onBasketballVideoPositionChanged?.call(
      _videoPlayerController.value.position,
      _videoPosition.value >= _videoTotalSecond,
      teamScores,
    );
  }

  void _initVideoPlayerController() {
    switch (widget.videoType) {
      case VideoType.network:
        _videoPlayerController = VlcPlayerController.network(
          'https://hls-stream-google-mixmoon-net.akamaized.net/hls-service/basket/master/A024C003.m3u8/-/j32KFdrs_En7EXqANg02CA/1714211095', // widget.videoPath,
          hwAcc: HwAcc.full,
          autoPlay: widget.autoPlay,
          options: VlcPlayerOptions(),
        );
      case VideoType.file:
        _videoPlayerController = VlcPlayerController.file(
          File(widget.videoPath),
          hwAcc: HwAcc.full,
          autoPlay: widget.autoPlay,
          options: VlcPlayerOptions(),
        );
      case VideoType.asset:
        _videoPlayerController = VlcPlayerController.asset(
          widget.videoPath,
          hwAcc: HwAcc.full,
          autoPlay: widget.autoPlay,
          options: VlcPlayerOptions(),
        );
    }

    _videoPlayerController
      ..setVideoScale(widget.aspectRatio)
      ..addOnInitListener(() async {
        await _videoPlayerController.startRendererScanning();

        // _videoPlayerController.setLooping(widget.looping);
        // _videoTotalSecond = _videoPlayerController.value.duration.inSeconds;

        // _videoPlayerController.setVolume(0);

        // // 确保跳转的秒数小于等于视频的总秒数，如果大于则不跳转
        // if (widget.seekToSecond != null) {
        //   if (widget.seekToSecond! <= _videoTotalSecond) {
        //     _videoPlayerController.seekTo(widget.seekToSecond!.seconds);
        //   }
        // }

        if (mounted) setState(() {});
      })
      ..addOnRendererEventListener(
        (p0, p1, p2) {
          debugPrint('OnRendererEvent $p0');
          debugPrint('OnRendererEvent $p1');
          debugPrint('OnRendererEvent $p2');
        },
      )
      ..addListener(_videoPlayerControllerListener);
  }

  // 视频总秒数，初始为1，后面视频加载好后会赋值
  int _videoTotalSecond = 1;

  late ValueNotifier<int> _videoPosition;
  late ValueNotifier<VrSportReplayDetailScoreRanking?> _scoreInfo;
  late ValueNotifier<bool> _videoMute;

  @override
  void initState() {
    _videoPosition = ValueNotifier(1);
    _videoMute = ValueNotifier(true);
    _scoreInfo = ValueNotifier(null);
    _initVideoPlayerController();

    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    _videoPosition.dispose();
    _videoMute.dispose();
    _scoreInfo.dispose();

    await _videoPlayerController.stopRecording();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CupertinoActivityIndicator().center,
        BasketVlcVideoPlayerView(
          controller: _videoPlayerController,
          aspectRatio: widget.aspectRatio,
          placeholder: const Center(child: CircularProgressIndicator()),
        ),
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
                _videoPlayerController.setVolume(0);
              } else {
                _videoPlayerController.setVolume(1);
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
}

extension VrVideoPlayerPlusStateHelper on BasketVlcVideoPlayerPlusState {
  VrSportReplayDetailScoreRanking? _teamsScore(
    int curMilliseconds,
    VrSportReplayDetailValue? detailValue,
  ) {
    final scoreInfos = detailValue?.list ?? [];

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

  Map<String, VrSportReplayDetailScoreRanking?> _basketballTeamsScores(
      int curMilliseconds) {
    final replayDetails = widget.replayEntity?.detail ?? {};

    Map<String, VrSportReplayDetailScoreRanking?> scoreInfos = {};
    for (final key in replayDetails.keys) {
      final teamScore = _teamsScore(
        curMilliseconds,
        replayDetails[key],
      );
      scoreInfos[key] = teamScore;
    }
    return scoreInfos;
  }
}
