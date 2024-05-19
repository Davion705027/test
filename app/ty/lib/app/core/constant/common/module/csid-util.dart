class CsidUtil {

  /**
   * @Description 是否虚拟体育的球种ID
   * @param {String} csid 球种id
   * @returns {Boolean} 返回是否是虚拟体育的布尔值
   */
  static is_virtual_csid(csid) {
    // 虚拟足球1001  虚拟赛狗1002  虚拟篮球1004 虚拟摩托1010 虚拟赛马1011 泥地摩托车1009
    return [1001, 1002, 1004, 1010, 1011, 1009].contains(
        int.tryParse(csid??'') ?? 0);
  }

  /**
   * @Description 是否电竞的球种ID
   * @param {undefined} undefined
   */
  static is_eports_csid (csid)  {
    // 英雄联盟100  dota2 101 csgo 102 王者荣耀103
    return [100, 101, 102, 103].contains  (int.tryParse(csid??'') ?? 0);
  }

  /**
   * 根据  一级 菜单ID 计算 赛种 ID
   * @param {*} mi
   */
  static compute_sport_id (mi)  {
    var obj = {
      101: 1,
      102: 2,
      103: 3,
      104: 4,
      105: 5,
      106: 6,
      107: 7,
      108: 8,
      109: 9,
      110: 10,
      111: 11,
      112: 12,
      113: 13,
      114: 14,
      115: 15,
      116: 16,
      118: 18,
      300: 10001,
      400: 10002,
      2000: 10003,
    };
    return obj[mi] ?? mi;
  }

}
