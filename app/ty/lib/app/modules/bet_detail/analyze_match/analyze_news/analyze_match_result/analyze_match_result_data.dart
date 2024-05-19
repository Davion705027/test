class AnalyzeMatchResultData{
  List<AnalyzeMatchResultItem>   ring_statistics=[];
  List<AnalyzeMatchResultItem>   card_corner_list=[];
  List<AnalyzeMatchResultItem>   progress_graph=[];
}
class AnalyzeMatchResultItem{
  String  score_type;
  String  title;
  String  icon;
  int home=0;
  int away=0;
  int proportion=0;
  AnalyzeMatchResultItem(this.score_type,this.title,this.icon);
}


