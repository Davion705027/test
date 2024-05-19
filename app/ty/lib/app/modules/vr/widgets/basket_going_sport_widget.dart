// ignore_for_file: dead_code

import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_ball_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_replay_detail_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_video_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/player/basket_video_player_plus.dart';
import 'package:flutter_ty_app/app/modules/vr/player/video_player_plus.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/ball_realtime_team_score_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/basketball_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/basketball_remain_time_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/football_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/match_video_placeholder.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/other_sport_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_video_countdown_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';

import 'dog_horse_finished_rank_widget.dart';
import 'dog_horse_rank_row.dart';

class BasketGoingSportWidget extends StatefulWidget {
  const BasketGoingSportWidget({
    super.key,
    required this.type,
    required this.vrMatch,
    this.getVirtualReplay,
    this.nextVrMatch,
    this.onNextMatchCountdownEnd,
    this.onVideoPlayFinished,
    this.onGetMatchScore,
    this.isShowItem = true,
    this.aspectRatio = 380 / 190,
  });

  final int type;
  final VrMatchEntity vrMatch;
  final VrMatchEntity? nextVrMatch;
  final Future<VrSportReplayEntity?> Function(VrMatchEntity vrMatch)?
      getVirtualReplay;
  final VoidCallback? onNextMatchCountdownEnd;
  final VoidCallback? onVideoPlayFinished;
  final Function(String mids)? onGetMatchScore;
  final bool isShowItem;
  final double aspectRatio;

  @override
  State<BasketGoingSportWidget> createState() => _BasketGoingSportWidgetState();
}

class _BasketGoingSportWidgetState extends State<BasketGoingSportWidget> {
  VrSportReplayEntity? _replayEntity;

  late final ValueNotifier<String> _videoUrl;

  // 足球、篮球当前选中比赛队伍
  int _selTeamIndex = 0;

  // 点击篮球视频播放页面显示时间进度
  late ValueNotifier<bool> _showBasketballCountdown;

  // 当前播放视频的进度：秒
  int _videoPosition = 0;
  // 视频是否播放完成
  late ValueNotifier<bool> _videoFinished;
  // 视频播放页回传的队友时间段的比分
  late ValueNotifier<VrSportReplayDetailScoreRanking?> _scoreInfo;

  // 用于篮球这种需要更新所有队伍比分的情况
  late ValueNotifier<Map<String, VrSportReplayDetailScoreRanking?>?>
      _multiScoreInfoMap;

  Timer? _basketballLodTimer;

  @override
  void initState() {
    debugPrint(
        'vrMatch lod: ${widget.vrMatch.lod}, mmp: ${widget.vrMatch.mmp}, no: ${widget.vrMatch.no}');
    _videoUrl = ValueNotifier('');
    _videoFinished = ValueNotifier(false);

    _scoreInfo = ValueNotifier(null);
    _multiScoreInfoMap = ValueNotifier(null);
    _showBasketballCountdown = ValueNotifier(false);

    final didMatchBegin = widget.vrMatch.didMatchBeginWith(widget.type);
    if (didMatchBegin) {
      if (!_showBasketballCountdown.value) {
        // 下一场比赛数据需要过一段时间才会更新
        20.seconds.delay(() {
          if (widget.vrMatch.inGame) return;
          if (mounted) {
            widget.onNextMatchCountdownEnd?.call();
          }
        });
      }
      _getReplay();
    }

    super.initState();
  }

  @override
  void dispose() {
    _videoUrl.dispose();
    _videoFinished.dispose();
    _scoreInfo.dispose();
    _multiScoreInfoMap.dispose();
    _showBasketballCountdown.dispose();
    _basketballLodTimer?.cancel();
    _basketballLodTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _videoFinished,
      builder: (context, isFinished, child) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: widget.aspectRatio,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  MatchVideoPlaceholder(type: widget.type),
                  _buildWaitingWidget(),
                  _buildVideoArea(),
                  _buildFinishedWidget(),
                  _buildBasketballCountdown(),
                ],
              ),
            ),
            if (widget.isShowItem) _buildRealtimeTeamScoreWidget(),
          ],
        );
      },
    );
  }

  Widget _buildWaitingWidget() {
    return VrSportVideoCountdownWidget(
      no: widget.vrMatch.no,
      mgt: widget.vrMatch.mgt,
      onCountdownFinished: () {
        // widget.onNextMatchCountdownEnd?.call();
        debugPrint(
            '_replayEntity widget.vrMatch.inGame: ${widget.vrMatch.inGame}');
        if (!_showBasketballCountdown.value) {
          // 下一场比赛数据需要过一段时间才会更新
          20.seconds.delay(() {
            if (widget.vrMatch.inGame) return;
            if (mounted) {
              widget.onNextMatchCountdownEnd?.call();
            }
          });
        }

        _getReplay();
        // 2.seconds.delay(() {
        //   _getReplay();
        //   // 刷新列表
        //   // widget.onNextMatchCountdownEnd?.call();
        // });
      },
    );
  }

  Widget _buildVideoArea() {
    if (!_videoFinished.value) {
      return ValueListenableBuilder(
        valueListenable: _videoUrl,
        builder: (context, videoUrl, child) {
          debugPrint('_videoUrl: ${_videoUrl.value}');
          final teams = _selTeamIndex >= 0
              ? widget.vrMatch.matchTeams[_selTeamIndex]
              : <String>[];

          final mid = widget.vrMatch.matchMids[_selTeamIndex];
          final replayDetailValue = _replayEntity?.detail?[mid];

          return videoUrl.isNotEmpty
              ? SizedBox.expand(
                  child: Platform.isAndroid
                      ? BasketVrVideoPlayerPlus.network(
                          videoUrl,
                          key: ValueKey('${videoUrl}_$_selTeamIndex'),
                          autoPlay: true,
                          seekToSecond: _videoPosition,
                          teams: teams,
                          showScoreInfo: widget.type <= 2,
                          curSeconds: widget.type == 2 ? 'LIVE' : '',
                          replayDetailValue: replayDetailValue,
                          replayEntity: _replayEntity,
                          onVideoPositionChanged: _onVideoPositionChanged,
                          onBasketballVideoPositionChanged:
                              _onBasketballVideoPositionChanged,
                        )
                      : VrVideoPlayerPlus.network(
                          videoUrl,
                          key: ValueKey('${videoUrl}_$_selTeamIndex'),
                          autoPlay: true,
                          seekToSecond: _videoPosition,
                          teams: teams,
                          showScoreInfo: widget.type <= 2,
                          curSeconds: widget.type == 2 ? 'LIVE' : '',
                          replayDetailValue: replayDetailValue,
                          replayEntity: _replayEntity,
                          onVideoPositionChanged: _onVideoPositionChanged,
                          onBasketballVideoPositionChanged:
                              _onBasketballVideoPositionChanged,
                        ),
                )
              : const SizedBox();
        },
      );
    }
    return const SizedBox();
  }

  Widget _buildFinishedWidget() {
    return ValueListenableBuilder(
      valueListenable: _videoFinished,
      builder: (context, finished, child) {
        if (finished) {
          final score = _teamsScore(_selTeamIndex, isFinished: true);
          final teams = widget.vrMatch.matchTeams[_selTeamIndex];
          switch (widget.type) {
            case 1:
              return FootballFinishedWidget(
                teams: teams,
                mhlu: widget.vrMatch.matchMhlus[_selTeamIndex],
                malu: widget.vrMatch.matchMalus[_selTeamIndex],
                score: score,
                nextVrMatch: widget.nextVrMatch,
                onNextMatchCountdownEnd: widget.onNextMatchCountdownEnd,
              );
            case 2:
              return BasketballFinishedWidget(
                teams: teams,
                mhlu: widget.vrMatch.matchMhlus[_selTeamIndex],
                malu: widget.vrMatch.matchMalus[_selTeamIndex],
                score: score,
                onNextMatchCountdownEnd: widget.onNextMatchCountdownEnd,
              );
          }
          return OtherSportFinishedWidget(
            teams: teams,
            score: score,
            nextVrMatch: widget.nextVrMatch,
            onNextMatchCountdownEnd: widget.onNextMatchCountdownEnd,
            // 赛狗多等待一段时间
            callbackSeconds: widget.type == 4 ? 20 : 10,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildRealtimeTeamScoreWidget() {
    switch (widget.type) {
      case 1:
      case 2:
        return _buildBallTeams();
    }
    return _buildDogHorseGoingRank();
  }
}

extension _BallsUI on _BasketGoingSportWidgetState {
  Widget _buildBallTeams() {
    return ValueListenableBuilder(
      valueListenable: _multiScoreInfoMap,
      builder: (context, multiScoreInfoMap, child) {
        return GridView.builder(
          key: ValueKey('teams_${multiScoreInfoMap?.length}'),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.w,
            childAspectRatio: 179 / 45,
          ),
          shrinkWrap: true,
          padding: EdgeInsets.all(8.w),
          itemCount: widget.vrMatch.matchTeams.length,
          itemBuilder: (BuildContext context, int index) {
            final isSelected = _selTeamIndex == index;
            final teams = widget.vrMatch.matchTeams[index];
            final mid = widget.vrMatch.matchMids[index];

            VrSportReplayDetailScoreRanking? score =
                (isSelected || widget.type == 2)
                    ? (multiScoreInfoMap?[mid])
                    : _teamsScore(
                        index,
                        isFinished: _videoFinished.value,
                      );

            return BallRealtimeTeamScoreWidget(
              teams: teams,
              score: score,
              isSelected: isSelected,
              onItemTap: () => _onTeamChanged(index),
            );
          },
        );
      },
    );
  }

  // 应该是视频播放的时候，点击显示，一段时间后自动隐藏
  _buildBasketballCountdown() {
    return ValueListenableBuilder(
      valueListenable: _showBasketballCountdown,
      builder: (context, show, child) {
        if (!show) return const SizedBox();

        return const BasketballRemainTimeWidget();
      },
    );
  }
}

extension _DogHorseUI on _BasketGoingSportWidgetState {
  Widget _buildDogHorseGoingRank() {
    final match = widget.vrMatch.matchs.firstOrNull;

    if (match == null) return const SizedBox();

    Map<String, Map<String, String?>?> oriTeamsRanking = {};
    for (int i = 0; i < match.teams.length; i++) {
      final key = '${i + 1}';
      oriTeamsRanking[key] = {
        'teamNum': key,
        'teamName': match.teams[i],
      };
    }

    return ValueListenableBuilder(
      valueListenable: _scoreInfo,
      builder: (context, rankingInfo, child) {
        final newTeamsRanking = _teamsRanking(
          oriTeamsRanking,
          rankingInfo,
        );

        if (_videoFinished.value) {
          return DogHorseFinishedRankWidget(
            match: match,
            championHps: match.championHps,
            topTwoHps: match.topTwoHps,
            topThreeHps: match.topThreeHps,
            oddEvenHps: match.oddEvenHps,
            sizeHps: match.sizeHps,
            teamRankingInfo: newTeamsRanking,
            championOls: match.championOls,
            topTwoOls: match.topTwoOls,
            topThreeOls: match.topThreeOls,
            oddEvenOls: match.oddEvenOls,
            sizeOls: match.sizeOls,
          );
        }

        return GridView.builder(
          key: ValueKey('dog_horse_${rankingInfo?.updateTime}'),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 8.w,
            childAspectRatio: 364 / 40,
          ),
          shrinkWrap: true,
          padding: EdgeInsets.all(8.w),
          itemCount: newTeamsRanking.length,
          itemBuilder: (BuildContext context, int index) {
            final teamsMapKey = newTeamsRanking.keys.toList()[index];
            final teamNumNameMap = newTeamsRanking[teamsMapKey];

            final teamNum = teamNumNameMap?['teamNum'] ?? '1';
            final teamName = teamNumNameMap?['teamName'] ?? '';

            return DogHorseRankRow(
              rank: index,
              teamNum: teamNum,
              title: teamName,
            );
          },
        );
      },
    );
  }
}

extension _TeamsScoreHelper on _BasketGoingSportWidgetState {
  VrSportReplayDetailScoreRanking? _teamsScore(
    int index, {
    bool isFinished = false,
  }) {
    if (_replayEntity == null) return null;
    if (index >= widget.vrMatch.matchMids.length) return null;

    final mid = widget.vrMatch.matchMids[index];
    final replayDetailValue = _replayEntity?.detail?[mid];

    final scoreInfos = replayDetailValue?.list ?? [];

    if (isFinished) {
      return scoreInfos.lastOrNull;
    }

    // 非当前选中视频的默认比分
    int lastScoreIndex = replayDetailValue?.curScoreIndex ?? -1;

    // 其他 item 返回上次的比分
    if (lastScoreIndex != -1 && lastScoreIndex < scoreInfos.length) {
      return scoreInfos[lastScoreIndex];
    }

    return null;
  }

  Map<String, Map<String, String?>?> _teamsRanking(
    Map<String, Map<String, String?>?> oriTeamsRanking,
    VrSportReplayDetailScoreRanking? rankingInfo,
  ) {
    if (_replayEntity == null) return oriTeamsRanking;
    if (widget.vrMatch.matchMids.isEmpty) return oriTeamsRanking;

    // 更新排名展示
    if (rankingInfo != null) {
      final ranking1TeamNum = rankingInfo.ranking1;
      final ranking1Team = oriTeamsRanking[ranking1TeamNum];
      final ranking2TeamNum = rankingInfo.ranking2;
      final ranking2Team = oriTeamsRanking[ranking2TeamNum];
      final ranking3TeamNum = rankingInfo.ranking3;
      final ranking3Team = oriTeamsRanking[ranking3TeamNum];
      final ranking4TeamNum = rankingInfo.ranking4;
      final ranking4Team = oriTeamsRanking[ranking4TeamNum];
      final ranking5TeamNum = rankingInfo.ranking5;
      final ranking5Team = oriTeamsRanking[ranking5TeamNum];
      final ranking6TeamNum = rankingInfo.ranking6;
      final ranking6Team = oriTeamsRanking[ranking6TeamNum];
      return SplayTreeMap.from(
        {
          '1': ranking1Team,
          '2': ranking2Team,
          '3': ranking3Team,
          '4': ranking4Team,
          '5': ranking5Team,
          '6': ranking6Team,
        },
      );
    }

    return oriTeamsRanking;
  }
}

extension _BasketGoingSportWidgetStateLogic on _BasketGoingSportWidgetState {
  _onTeamChanged(int index) async {
    // 不支持点击
    return;
    if (_selTeamIndex == index) return;
    _selTeamIndex = index;
    _updatePlayingVideo();

    _getReplay();
  }

  Future<void> _getReplay() async {
    if (!mounted) return;

    final res = await widget.getVirtualReplay?.call(widget.vrMatch);
    _replayEntity = res;

    debugPrint('_replayEntity lod: ${_replayEntity?.lod}');
    debugPrint('_replayEntity lod vrMatch: ${widget.vrMatch.lod}');

    // ) && widget.vrMatch.lod != 'INGAME'
    if (_replayEntity == null || _replayEntity?.lod == 'PREGAME') {
      if (widget.vrMatch.lod != 'INGAME') {
        _showBasketballCountdown.value = true;
      } else {
        _showBasketballCountdown.value = false;
      }
      await _getReplay();
      // return;
    }

    if (_replayEntity?.lod == 'INGAME') {
      final matchs = _replayEntity?.matchs ?? [];
      Map<String, VrSportReplayDetailScoreRanking> scoreInfoMap = {};
      for (var match in matchs) {
        scoreInfoMap[match.mid] = VrSportReplayDetailScoreRanking.fromJson({
          'away': match.awayScore,
          'home': match.homeScore,
        });
      }

      debugPrint('_replayEntity scoreInfoMap: $scoreInfoMap');

      _onBasketballVideoPositionChanged(
        Duration.zero,
        false,
        scoreInfoMap,
      );
    }

    if (_replayEntity?.lod == 'INGAME' && widget.vrMatch.lod != 'INGAME') {
      _showBasketballCountdown.value = false;
      widget.onNextMatchCountdownEnd?.call();
      // // 下一场比赛数据需要过一段时间才会更新
      // 5.seconds.delay(() {
      //   if (mounted) {
      //     widget.onNextMatchCountdownEnd?.call();
      //   }
      // });
      // return;
    }

    _updatePlayingVideo();
  }

  void _updatePlayingVideo() {
    if (_replayEntity == null) return;
    String mid;
    switch (widget.type) {
      case 1:
      case 2:
        if (widget.vrMatch.matchMids.length <= _selTeamIndex) return;
        mid = widget.vrMatch.matchMids[_selTeamIndex];
      default:
        if (widget.vrMatch.matchMids.isEmpty) return;
        mid = widget.vrMatch.matchMids.first;
    }
    final detail = _replayEntity!.detail?[mid];
    if (detail == null) return;

    // 时间戳：毫秒
    final startTime = int.tryParse(detail.mgt) ?? 0;
    // 时间：秒
    final totalTime = double.tryParse(detail.totalTime) ?? 0;
    if (startTime == 0 || totalTime == 0) return;

    // 时间戳：毫秒
    final nowTime = DateTime.now().millisecondsSinceEpoch;

    // 提前 2 秒结束
    if (detail.isFinish) {
      // 已结束
      _videoFinished.value = true;
      widget.onVideoPlayFinished?.call();
      return;
    }

    if (mounted) {
      _videoPosition =
          ((nowTime.toDouble() - startTime.toDouble()) / 1000).round();
      debugPrint('_videoPosition: $_videoPosition');
      _videoUrl.value = detail.formattedPlayUrlWith(widget.type);
    }
  }

  void _onVideoPositionChanged(
    Duration position,
    bool isFinished,
    VrSportReplayDetailScoreRanking? scoreInfo,
  ) {
    _videoPosition = max(position.inSeconds, _videoPosition);
    _showBasketballCountdown.value = false;
    if (_videoPosition == 20) {
      // 请求一轮数据
      widget.onNextMatchCountdownEnd?.call();
    }
    _videoFinished.value = isFinished;
    _scoreInfo.value = scoreInfo;
    if (isFinished) {
      widget.onVideoPlayFinished?.call();
    }
  }

  void _onBasketballVideoPositionChanged(
    Duration position,
    bool isFinished,
    Map<String, VrSportReplayDetailScoreRanking?> scoreInfoMap,
  ) {
    try {
      _multiScoreInfoMap.value = scoreInfoMap;
    } catch (e) {
      debugPrint('update _multiScoreInfoMap error: $e');
    }
  }
}
