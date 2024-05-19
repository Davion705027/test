import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/account_info.dart';

AccountInfo $AccountInfoFromJson(Map<String, dynamic> json) {
  final AccountInfo accountInfo = AccountInfo();
  final String? continentCode = jsonConvert.convert<String>(
      json['continent_code']);
  if (continentCode != null) {
    accountInfo.continentCode = continentCode;
  }
  final String? h5 = jsonConvert.convert<String>(json['h5']);
  if (h5 != null) {
    accountInfo.h5 = h5;
  }
  final String? pc = jsonConvert.convert<String>(json['pc']);
  if (pc != null) {
    accountInfo.pc = pc;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    accountInfo.token = token;
  }
  return accountInfo;
}

Map<String, dynamic> $AccountInfoToJson(AccountInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['continent_code'] = entity.continentCode;
  data['h5'] = entity.h5;
  data['pc'] = entity.pc;
  data['token'] = entity.token;
  return data;
}

extension AccountInfoExtension on AccountInfo {
  AccountInfo copyWith({
    String? continentCode,
    String? h5,
    String? pc,
    String? token,
  }) {
    return AccountInfo()
      ..continentCode = continentCode ?? this.continentCode
      ..h5 = h5 ?? this.h5
      ..pc = pc ?? this.pc
      ..token = token ?? this.token;
  }
}