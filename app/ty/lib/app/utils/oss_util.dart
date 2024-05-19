abstract class OssUtil {
  /// 检查是否是本地图片
  static bool checkIsLocal(String uri) {
    return uri.startsWith("assets");
  }

  /// 获取本地图片路径
  // assets/images/common/logo/logo_Basketball.png
  // /images/common/logo/logo_Basketball.png
  static String getServerPath(String localPath) {
    //return getBaseUrl() + localPath.replaceFirst('assets', 'assets-2024-03-27-19-00');
    return getBaseUrl() + localPath.replaceFirst('assets', 'assets-2024-04-05-12-00');
  }

  static String getBaseUrl() {
    return "https://assets-image.oceasfe.com/public/upload/app/ty/";
  }
}
