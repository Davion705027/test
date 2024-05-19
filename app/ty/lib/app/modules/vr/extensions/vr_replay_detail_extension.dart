import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';

extension VrVideoFinished on VrSportReplayDetailValue? {
  bool get isFinish {
    // 时间戳：毫秒
    final startTime = int.tryParse(this?.mgt ?? '0') ?? 0;
    // 时间：秒
    final totalTime = double.tryParse(this?.totalTime ?? '0') ?? 0;
    if (startTime == 0 || totalTime == 0) return true;

    // 时间戳：毫秒
    final endTime = startTime.toDouble() + totalTime * 1000;
    final nowTime = DateTime.now().millisecondsSinceEpoch;

    // 提前 2 秒结束
    if (nowTime.toDouble() - 2 * 1000 > endTime) {
      return true;
    }
    return false;
  }

  String get formattedPlayUrlNew {
    final url = this?.thirdMatchVideoUrl ?? '';
    debugPrint('formattedPlayUrl thirdMatchVideoUrl: $url');
    if (url.isEmpty) return '';

    debugPrint('formattedPlayUrl oriUrl: $url');

    String mimeType = url.mimeTypeNew;
    debugPrint('formattedPlayUrl mimeType: $mimeType');
    if (mimeType.isEmpty) return url;

    final urlSplit = url.split(mimeType);
    final first = urlSplit.firstOrNull ?? '';
    debugPrint('formattedPlayUrl first: $first');
    if (first.isEmpty) return url;

    final formattedUrl = first + mimeType;
    debugPrint('formattedPlayUrl formattedUrl: $formattedUrl');
    return formattedUrl;
  }

  String formattedPlayUrlNewWith(int type) {
    if (type == 2) return this?.thirdMatchVideoUrl ?? '';
    return formattedPlayUrlNew;
  }
}

extension _UrlMimeTypeNew on String? {
  String get mimeTypeNew {
    final url = this ?? '';
    if (url.contains('.m3u8')) {
      return '.m3u8';
    } else if (url.contains('.flv')) {
      return '.flv';
    } else if (url.contains('.mp4')) {
      return '.mp4';
    }
    return '';
  }
}
