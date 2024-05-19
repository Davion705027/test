import '../../../services/models/res/match_entity.dart';

// 附加盘投注项集合
class BetItemCollection {
  MatchHpsHlOl ol;
  MatchHpsHl hl;
  MatchHps? hps;

  BetItemCollection({
    required this.ol,
    required this.hl,
    this.hps
  });

  @override
  String toString() {
    return "$ol";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BetItemCollection &&
          runtimeType == other.runtimeType &&
          ol.oid == other.ol.oid &&
          hl.hid == other.hl.hid;

  @override
  int get hashCode => ol.oid.hashCode + hl.hid.hashCode;
}
