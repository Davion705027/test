import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';

import 'video_player_plus.dart';

class BasketVrVideoPlayerPlus extends StatefulWidget {
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

  const BasketVrVideoPlayerPlus({
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
  }) : super(key: key);

  const BasketVrVideoPlayerPlus.network(
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
  }) : super(key: key);

  const BasketVrVideoPlayerPlus.file(
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
  }) : super(key: key);

  const BasketVrVideoPlayerPlus.asset(
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
  }) : super(key: key);

  @override
  BasketVrVideoPlayerPlusState createState() => BasketVrVideoPlayerPlusState();
}

class BasketVrVideoPlayerPlusState extends State<BasketVrVideoPlayerPlus> {
  // @override
  // Widget build(BuildContext context) {
  //   return const Text('demo').center;
  // }

  final FijkPlayer _player = FijkPlayer();

  // 视频总秒数，初始为1，后面视频加载好后会赋值
  int _videoTotalSecond = 1;

  late ValueNotifier<int> _videoPosition;
  late ValueNotifier<VrSportReplayDetailScoreRanking?> _scoreInfo;
  late ValueNotifier<bool> _videoMute;
  StreamSubscription? _currentPosSubs;
  Duration _currentPos = Duration.zero;

  void _fijkPlayerListener() {
    switch (_player.state) {
      case FijkState.prepared:
        _videoTotalSecond = _player.value.duration.inSeconds;
        //确保跳转的秒数小于等于视频的总秒数，如果大于则不跳转
        if (widget.seekToSecond != null) {
          if (widget.seekToSecond! <= _videoTotalSecond) {
            _player.seekTo(widget.seekToSecond! * 1000);
          } else {
            _player.seekTo(_videoTotalSecond * 1000);
          }
        }
      case FijkState.completed:
        _videoPosition.value = _currentPos.inSeconds;
        final curMilliseconds = _currentPos.inMilliseconds;
        _callbackVideoChanged(
          curMilliseconds,
          _player.state == FijkState.completed,
          _currentPos,
        );

      default:
    }
  }

  void _fijkPlayerCurPosListener(Duration currentPos) {
    debugPrint('_player.value: ${_player.value.toString()}');
    debugPrint('_player.value currentPos: $currentPos');

    _currentPos = currentPos;

    _videoPosition.value = currentPos.inSeconds;
    final curMilliseconds = currentPos.inMilliseconds;

    _callbackVideoChanged(curMilliseconds, false, currentPos);
  }

  void _callbackVideoChanged(
    int curMilliseconds,
    bool finished,
    Duration currentPos,
  ) {
    _scoreInfo.value = _teamsScore(
      curMilliseconds,
      widget.replayDetailValue,
    );
    widget.onVideoPositionChanged?.call(
      currentPos,
      finished,
      _scoreInfo.value,
    );

    // 篮球比分
    final teamScores = _basketballTeamsScores(curMilliseconds);
    widget.onBasketballVideoPositionChanged?.call(
      currentPos,
      finished,
      teamScores,
    );
  }

  void fijkPlayerCurPListener(Duration currentPos) {
    debugPrint('_player.value: ${_player.value.toString()}');
    debugPrint('_player.value currentPos: $currentPos');

    _currentPos = currentPos;

    _videoPosition.value = currentPos.inSeconds;
    final curMilliseconds = currentPos.inMilliseconds;

    _callbackVideoChanged(curMilliseconds, false, currentPos);
  }

  // _videoPlayerControllerListener() {
  //   final position = _videoCtl.value.position;
  //   _videoPosition.value = position.inSeconds;
  //   final curMilliseconds = position.inMilliseconds;
  //   _scoreInfo.value = _teamsScore(
  //     curMilliseconds,
  //     widget.replayDetailValue,
  //   );
  //   widget.onVideoPositionChanged?.call(
  //     _videoCtl.value.position,
  //     _videoPosition.value >= _videoTotalSecond,
  //     _scoreInfo.value,
  //   );

  //   // 篮球比分
  //   final teamScores = _basketballTeamsScores(curMilliseconds);
  //   widget.onBasketballVideoPositionChanged?.call(
  //     _videoCtl.value.position,
  //     _videoPosition.value >= _videoTotalSecond,
  //     teamScores,
  //   );
  // }

  // void _initVideoPlayerController() {
  //   switch (widget.videoType) {
  //     case VideoType.network:
  //       _videoCtl =
  //           VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
  //     case VideoType.file:
  //       _videoCtl = VideoPlayerController.file(File(widget.videoPath));
  //     case VideoType.asset:
  //       _videoCtl = VideoPlayerController.asset(widget.videoPath);
  //   }

  //   _videoCtl
  //     ..initialize().then(
  //       (_) {
  //         // 确保在初始化视频后显示第一帧，直至在按下播放按钮。
  //         if (widget.autoPlay) {
  //           _videoCtl.play();
  //         }

  //         _videoCtl.setLooping(widget.looping);
  //         _videoTotalSecond = _videoCtl.value.duration.inSeconds;

  //         _videoCtl.setVolume(0);

  //         //确保跳转的秒数小于等于视频的总秒数，如果大于则不跳转
  //         if (widget.seekToSecond != null) {
  //           if (widget.seekToSecond! <= _videoTotalSecond) {
  //             _videoCtl.seekTo(widget.seekToSecond!.seconds);
  //           }
  //         }

  //         if (mounted) setState(() {});
  //       },
  //     )
  //     ..addListener(_videoPlayerControllerListener);
  // }

  void _initFijkPlayer() {
    switch (widget.videoType) {
      case VideoType.network:
        _player
          ..setDataSource(widget.videoPath, autoPlay: true)
          ..setVolume(0)
          ..addListener(_fijkPlayerListener);
      case VideoType.file:
        _player
          ..setDataSource(widget.videoPath, autoPlay: true)
          ..setVolume(0)
          ..addListener(_fijkPlayerListener);
      case VideoType.asset:
        _player
          ..setDataSource(widget.videoPath, autoPlay: true)
          ..setVolume(0)
          ..addListener(_fijkPlayerListener);
    }

    _currentPosSubs ??=
        _player.onCurrentPosUpdate.listen(_fijkPlayerCurPosListener);
  }

  @override
  void initState() {
    _videoPosition = ValueNotifier(1);
    _videoMute = ValueNotifier(true);
    _scoreInfo = ValueNotifier(null);
    // 20.milliseconds.delay(() {
    //   if (mounted) {
    //     // 篮球先回调一次，因为比分更新从进入滚球就开始了
    //     _callbackVideoChanged(0, false, Duration.zero);
    //   }
    // });
    // _initVideoPlayerController();
    _initFijkPlayer();

    // 20.milliseconds.delay(() {
    //   if (mounted) {
    //     // 篮球先回调一次，因为比分更新从进入滚球就开始了
    //     _callbackVideoChanged(0, false, Duration.zero);
    //   }
    // });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPosition.dispose();
    _videoMute.dispose();
    _scoreInfo.dispose();
    _currentPosSubs?.cancel();
    // _videoCtl.removeListener(_videoPlayerControllerListener);
    // _videoCtl.dispose();
    _player.removeListener(_fijkPlayerListener);
    // _player.release();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CupertinoActivityIndicator().center,
        // if (_videoCtl.value.isInitialized) VideoPlayer(_videoCtl),
        FijkView(
          player: _player,
          fit: FijkFit.fill,
          panelBuilder: (player, data, context, viewSize, texturePos) =>
              const SizedBox(),
          color: Colors.black,
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
              // if (_videoMute.value) {
              //   _videoCtl.setVolume(0);
              // } else {
              //   _videoCtl.setVolume(1);
              // }
              if (_videoMute.value) {
                _player.setVolume(0);
              } else {
                _player.setVolume(1);
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

extension VrVideoPlayerPlusStateHelper on BasketVrVideoPlayerPlusState {
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
