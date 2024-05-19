import 'package:flutter_ty_app/generated/json/account_info.g.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';

/// Generated class description...
@JsonSerializable()
class AccountInfo {
  /// continent_code
  @JSONField(name: 'continent_code')
  String? continentCode;

  /// h5
  String? h5;

  /// pc
  String? pc;

  /// token
  String? token;

  /// Constructor...
  AccountInfo();

  /// Deserializer...
  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      $AccountInfoFromJson(json);

  /// Serializer...
  Map<String, dynamic> toJson() => $AccountInfoToJson(this);
}