enum OddsButtonState {
  open, //开盘
  lock, //封盘
  close, //关盘
  none;

  /// 详情逻辑 ： mhs: 0开 1封 2关 11锁
  ///           hs: 0开 1封 2关 11锁
  ///           os: 1开 2封 3隐藏不显示不占地方
  static OddsButtonState betState(int mhs, int hs, int os) {
    //开盘_mhs=0或者锁盘_mhs=11
    if (mhs == 0 || mhs == 11) {
      if (hs == 0 || hs == 11) {
        // os = 1 开盘
        if (os == 1) {
          return open;
        }
        // os = 2 封盘
        else if (os == 2) {
          return lock;
        } else {
          return none;
        }
      }
      // hs=1封盘
      else if(hs == 1){
        if(os == 3){
          return none;
        }else{
          return lock;
        }

      }
      else if(hs == 2){
        // 盘口级别状态关盘要显示占位
        return none;
      }
      else{
        return none;
      }
    }
    //封盘_mhs=1
    else if (mhs == 1) {
      return lock;
    }
    // 关盘_mhs=2
    else if (mhs == 2) {
      return close;
    } else {
      return none;
    }
  }
}

enum OddsTextDirection {
  vertical, // 垂直
  horizontal,// 水平
}

enum OddsBetType {
  common, //普通
  guanjun,//冠军
  esport, //电竞
  vr      //VR
}
