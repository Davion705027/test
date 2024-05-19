class AnalyzeFavoriteArticleEntity {
  String? articleContent;
  String? articleId;
  String? articleTittle;
  String? authorName;
  String? categoryName;
  num? count;
  num? excludeIds;
  String? id;
  String? matchDetail;
  num? matchId;
  String? readCounts;
  String? showTime;
  String? sportId;
  String? summary;
  String? tagColor;
  String? tagName;
  String? thumbnails;
  String? updateTime;

  AnalyzeFavoriteArticleEntity(
      {this.articleContent,
        this.articleId,
        this.articleTittle,
        this.authorName,
        this.categoryName,
        this.count,
        this.excludeIds,
        this.id,
        this.matchDetail,
        this.matchId,
        this.readCounts,
        this.showTime,
        this.sportId,
        this.summary,
        this.tagColor,
        this.tagName,
        this.thumbnails,
        this.updateTime});

  AnalyzeFavoriteArticleEntity.fromJson(Map<String, dynamic> json) {
    articleContent = json['articleContent'];
    articleId = json['articleId'];
    articleTittle = json['articleTittle'];
    authorName = json['authorName'];
    categoryName = json['categoryName'];
    count = json['count'];
    excludeIds = json['excludeIds'];
    id = json['id'];
    matchDetail = json['matchDetail'];
    matchId = json['matchId'];
    readCounts = json['readCounts'];
    showTime = json['showTime'];
    sportId = json['sportId'];
    summary = json['summary'];
    tagColor = json['tagColor'];
    tagName = json['tagName'];
    thumbnails = json['thumbnails'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articleContent'] = this.articleContent;
    data['articleId'] = this.articleId;
    data['articleTittle'] = this.articleTittle;
    data['authorName'] = this.authorName;
    data['categoryName'] = this.categoryName;
    data['count'] = this.count;
    data['excludeIds'] = this.excludeIds;
    data['id'] = this.id;
    data['matchDetail'] = this.matchDetail;
    data['matchId'] = this.matchId;
    data['readCounts'] = this.readCounts;
    data['showTime'] = this.showTime;
    data['sportId'] = this.sportId;
    data['summary'] = this.summary;
    data['tagColor'] = this.tagColor;
    data['tagName'] = this.tagName;
    data['thumbnails'] = this.thumbnails;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
