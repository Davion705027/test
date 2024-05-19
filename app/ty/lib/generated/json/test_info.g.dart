import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/test_info.dart';

TestInfo $TestInfoFromJson(Map<String, dynamic> json) {
  final TestInfo testInfo = TestInfo();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    testInfo.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    testInfo.name = name;
  }
  return testInfo;
}

Map<String, dynamic> $TestInfoToJson(TestInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  return data;
}

extension TestInfoExtension on TestInfo {
  TestInfo copyWith({
    int? id,
    String? name,
  }) {
    return TestInfo()
      ..id = id ?? this.id
      ..name = name ?? this.name;
  }
}