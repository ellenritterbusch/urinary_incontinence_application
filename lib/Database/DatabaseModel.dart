class DatabaseModel {

 late int? dailyEvaluationScore;
 late String? dailyEvaluationMemo;
 late DateTime? date;
 late bool accident;

DatabaseModel(this.dailyEvaluationScore, this.dailyEvaluationMemo, this.date);


  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['dailyEvaluationScore'] = dailyEvaluationScore;
    map['dailyEvaluationMemo'] = dailyEvaluationMemo;
    map['date'] = date;
    map['accident']= accident;
    return map;
  }

  DatabaseModel.fromMapObject(Map<String,dynamic> map){
    this.dailyEvaluationScore= map['dailyEvaluationScore'];
    this.dailyEvaluationMemo = map['dailyEvaluationMemo'];
    this.date = map['date'];
  }
}
