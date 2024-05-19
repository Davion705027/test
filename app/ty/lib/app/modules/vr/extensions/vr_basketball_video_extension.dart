import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';

extension VrBasketVideoUrl on VrSportReplayDetailValue? {
  String get formattedPlayUrl {
    final url = this?.thirdMatchVideoUrl ?? '';
    debugPrint('formattedPlayUrl thirdMatchVideoUrl: $url');
    if (url.isEmpty) return '';

    debugPrint('formattedPlayUrl oriUrl: $url');

    String mimeType = url.mimeType;
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

  String formattedPlayUrlWith(int type) {
    if (type == 2) return this?.thirdMatchVideoUrl ?? '';
    return formattedPlayUrl;
  }
}

extension _UrlMimeType on String? {
  String get mimeType {
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




extension _UrlMimeNewType on String? {
  String get mimeNewType {
    final url = this ?? '';
    if (url.contains('.mov')) {
      return '.mov';
    } else if (url.contains('.flv')) {
      return '.flv';
    } else if (url.contains('.mp4')) {
      return '.mp4';
    }
    return '';
  }
}