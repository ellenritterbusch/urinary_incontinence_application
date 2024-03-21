class DatabaseModel {

 late int _dailyEvaluationScore;
 late String _dailyEvaluationMemo;
 late String _date;
 late bool _accident;

  DatabaseModel(this._dailyEvaluationScore, this._dailyEvaluationMemo, this._date);

  // Getters
  int get dailyEvaluationScore => _dailyEvaluationScore;
  String get dailyEvaluationMemo => _dailyEvaluationMemo;
  String get date => _date;

  // Setters
  set dailyEvaluationScore(int score) {
    _dailyEvaluationScore = score;
  }

  set dailyEvaluationMemo(String memo) {
    _dailyEvaluationMemo = memo;
  }

  set date(String date) {
    _date = date;
  }

  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['dailyEvaluationScore'] = _dailyEvaluationScore;
    map['dailyEvaluationMemo'] = _dailyEvaluationMemo;
    map['date'] = _date;
    map['accident']= _accident;
    return map;
  }

  DatabaseModel.fromMapObject(Map<String,dynamic> map){
    this._dailyEvaluationScore= map['dailyEvaluationScore'];
    this._dailyEvaluationMemo = map['dailyEvaluationMemo'];
    this._date = map['date'];
  }
}
