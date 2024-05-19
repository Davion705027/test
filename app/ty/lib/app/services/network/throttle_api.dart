class ThrottleUtil {
  ///接口名
  static String getCategoryList = '/yewu11/v1/m/category/getCategoryList';
  static String getESMatchOddsInfo =
      '/yewu11/v1/m/matchDetail/getESMatchOddsInfo';
  static String matchesPB = '/yewu11/v1/m/matchesPB';
  static const String userAmount = '/yewu12/user/amount';
  // static const String getMatchBaseInfoByMids =
  //     '/yewu11/v1/m/getMatchBaseInfoByMids';

  // @POST('/yewu11/v1/m/getMatchBaseInfoByMids')

  ///添加监听数组 定义key之后 这里需要添加进来
  static List throttleApiList = [
    getCategoryList,
    matchesPB,
    userAmount,
    // getMatchBaseInfoByMids
  ];

  // DateTime nextAvailable = DateTime.now();
  ///需要节流的接口时间 毫秒级别 接口名作为key   可以不传 不传默认为1000ms
  static Map throttleMilliseconds = {
    getCategoryList: {'milliseconds': 1500, 'nextAvailable': DateTime.now()},
    matchesPB: {'milliseconds': 1500, 'nextAvailable': DateTime.now()},
    userAmount: {'milliseconds': 1500, 'nextAvailable': DateTime.now()},
    // getMatchBaseInfoByMids: {
    //   'milliseconds': 1500,
    //   'nextAvailable': DateTime.now()
    // }
  };
}
