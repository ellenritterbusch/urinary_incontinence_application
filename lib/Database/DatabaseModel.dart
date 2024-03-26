class DatabaseModel {

 late int? dailyEvaluationScore;
 late String? dailyEvaluationMemo;
 late String? date;
 late int? accident;
 late String? time;
 late int? stimType;
 late int? stimIntensity;
 late int? stimeTimeSetting;
 late int? id;
 late int? PIN;

DatabaseModel.DE(this.dailyEvaluationScore, this.dailyEvaluationMemo, this.date);
DatabaseModel.BD(this.date, this.time, this.accident);
DatabaseModel.User(this.PIN);



/// TO/FROM MAP FOR DAILY EVALUATION
  Map<String,dynamic> toMapDE(){
    var map = Map<String, dynamic>();
    map['evaluation'] = dailyEvaluationScore;
    map['memo'] = dailyEvaluationMemo;
    map['date'] = date;
    return map;
  }
  DatabaseModel.fromMapObjectDE(Map<String,dynamic> map){
    this.dailyEvaluationScore= map['evaluation'];
    this.dailyEvaluationMemo = map['memo'];
    this.date = map['date'];
  }

  /// TO/FROM MAP FOR BLADDER DIARY
  Map<String,dynamic> toMapBD(){
    var map = Map<String, dynamic>();
    map['accident'] = accident;
    map['time'] = time;
    map['date'] = date;
   // map['stimtype']= stimType;
    //map ['stimintensity']= stimIntensity;
   // map ['stimtimesetting'] = stimeTimeSetting;
    return map;
  }
  DatabaseModel.fromMapObjectBD(Map<String,dynamic> map){
    accident = map['accident'];
    time = map['time'];
    date = map['date'];
    stimType = map['stimtype'];
    stimIntensity = map ['stimintensity'];
    stimeTimeSetting = map ['stimtimesetting'];

  }/// TO/FROM MAP FOR USER
  Map<String,dynamic> toMapUser(){
    var map = Map<String, dynamic>();
    map['pin'] = PIN;
    return map;
  }
  DatabaseModel.fromMapObjectUser(Map<String,dynamic> map){
    this.PIN= map['pin'];
  }
}
