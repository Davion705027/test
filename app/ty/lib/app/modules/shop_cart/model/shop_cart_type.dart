
enum ShopCartBetStatus {
  Prebook,//预约投注
  // 1-投注状态,2-投注中状态,3-投注成功状态(主要控制完成按钮),4-投注失败状态,5-投注项失效 6-预约中 7-预约成功  8-预约取消
  Normal,
  Betting,
  Success,
  Failure,
  Invalid,
  Prebooking,
  PrebookSuccess,
  PrebookCancel,
  OneClickBetting,
}

enum OddStateType {
  oddUp,
  oddDown,
  none,
  oddOverrun,
}