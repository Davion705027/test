class AnalyzeMatchInformationEntity {
  int? benefit;
  String? content;
  String? typeId;
  String? typeName;

  AnalyzeMatchInformationEntity(
      {this.benefit, this.content, this.typeId, this.typeName});

  AnalyzeMatchInformationEntity.fromJson(Map<String, dynamic> json) {
    benefit = json['benefit'];
    content = json['content'];
    typeId = json['typeId'];
    typeName = json['typeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['benefit'] = this.benefit;
    data['content'] = this.content;
    data['typeId'] = this.typeId;
    data['typeName'] = this.typeName;
    return data;
  }
}
