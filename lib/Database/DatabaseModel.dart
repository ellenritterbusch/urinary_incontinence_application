class DatabaseModel {

 late int? dailyEvaluationScore;
 late String? dailyEvaluationMemo;
 late String? date;
// late bool accident;

DatabaseModel(this.dailyEvaluationScore, this.dailyEvaluationMemo, this.date);


  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['evaluation'] = dailyEvaluationScore;
    map['memo'] = dailyEvaluationMemo;
    map['date'] = date;
   // map['accident']= accident;
    return map;
  }

  DatabaseModel.fromMapObject(Map<String,dynamic> map){
    this.dailyEvaluationScore= map['evaluation'];
    this.dailyEvaluationMemo = map['memo'];
    this.date = map['date'];
  }
}
