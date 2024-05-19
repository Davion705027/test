class FormatMoney {
  /// @description: 数字转中文
  /// @param {Integer} number 形如123的数字
  /// @return {String} 返回转换成的形如 一百二十三 的字符串
  static String numberToChinese(int number) {
    // 单位和字符映射表
    Map<String, String> t = {'units': '个十百千万@#%亿^&~', 'chars': '零一二三四五六七八九'};

    List<String> a = number.toString().split('');
    List<String> s = [];
    int j = a.length - 1;

    if (a.length > 12) {
      throw ArgumentError('too big');
    } else {
      for (int i = 0; i <= j; i++) {
        if (j == 1 || j == 5 || j == 9) {
          // 两位数 处理特殊的 1*
          if (i == 0) {
            if (a[i] != '1') s.add(t['chars']![int.parse(a[i])]);
          } else {
            s.add(t['chars']![int.parse(a[i])]);
          }
        } else {
          s.add(t['chars']![int.parse(a[i])]);
        }
        if (i != j) {
          s.add(t['units']![j - i]);
        }
      }
    }

    return s
        .join('')
        .replaceAllMapped(RegExp(r'零([十百千万亿@#%^&~])'), (match) {
          // 优先处理 零百 零千 等
          var d = match.group(1);
          int b = t['units']!.indexOf(d!);
          if (b != -1) {
            if (d == '亿') return d;
            if (d == '万') return d;
            if (a[j - b] == '0') return '零';
          }
          return '';
        })
        .replaceAll(RegExp(r'零+'), '零')
        .replaceAllMapped(RegExp(r'零([万亿])'), (match) {
          // 零百 零千处理后 可能出现 零零相连的 再处理结尾为零的
          var b = match.group(1);
          return b!;
        })
        .replaceAll(RegExp(r'亿[万千百]'), '亿')
        .replaceAll(RegExp(r'[零]$'), '')
        .replaceAllMapped(RegExp(r'([亿万])([一-九])'), (match) {
          var d = match.group(1);
          var b = match.group(2);
          int c = t['units']!.indexOf(d!);
          if (c != -1) {
            if (a[j - c] == '0') return '$d零$b';
          }
          return match.group(0)!;
        });
  }
}
