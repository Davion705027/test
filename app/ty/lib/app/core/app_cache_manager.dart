import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'tyCachedImageData';

  static final AppCacheManager _instance = AppCacheManager._();

  factory AppCacheManager() {
    return _instance;
  }

  AppCacheManager._() : super(Config(key));

  List<String> imageUrls = [];

  void preLoadImages() {
    for (var url in imageUrls) {
      downloadFile(url);
    }
  }
}
