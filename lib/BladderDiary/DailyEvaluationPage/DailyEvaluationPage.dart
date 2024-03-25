//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/EvaluationButton.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';


class DailyEvaluationPage extends StatefulWidget {
  const DailyEvaluationPage({super.key});

  @override
  State<DailyEvaluationPage> createState() => _DailyEvaluationPageState();
}

class _DailyEvaluationPageState extends State<DailyEvaluationPage> {
  late TextEditingController controller;
  late DatabaseModel evaluation;

  @override //Used to take user input for memo
    void initState(){
    super.initState();
    
    controller = TextEditingController();
    }

  

  //ATTRIBUTES FOR DAILY EVALUATION
  
  String dailyEvaluationMemo =''; //Initialize a memo string to be filled out later
  bool isVisible = false;  //Used for displaying note button when an evaluation has been given
  DatabaseModel databaseModelDE = DatabaseModel(0,'',10);

  

  @override
  Widget build(BuildContext context) {
   
    void submit(){ //Method used to save user input for memo and close window. Called when 'Submit' button is pressed.
  Navigator.of(context).pop(controller.text);
}
  void close (){ //Method used to close memo window without saving user input. Called when 'Cancel' button is pressed. 
    Navigator.of(context).pop(controller.text);
    controller.text = '';
  }

   openDialog() => showDialog(//method for creating the daily evaluation note. Called when Memo button is pressed
            context: context,
            builder:(context) => AlertDialog(
              title: Text ('Daily Evaluation Note'), 
              
              content: TextField(
                maxLines: null, //set to null so that note doesn't appear as one long line. 
                autofocus: true, //Makes keyboard pop up automatically when textfield is opened
                decoration: InputDecoration(hintText: 'Enter additional context for daily evaluation'),
                controller: controller,
                onSubmitted: (_) => submit(), //if user presses submit on keyboard, submit. 
                ),
                actions: [
                  TextButton(
                    onPressed: (close), 
                    child: Text('Cancel')),
                    TextButton(
                    onPressed: (submit), 
                    child: Text('Submit'))
                ],
            ),
          );
    return  Scaffold(
      appBar: AppBar(
          title: const Text('Daily Evaluation '), //Page title
          centerTitle: true,
      ),

      body : 
        Column( //Page is 1 column containing a button for green, yellow, and red, and one for "Submit daily evaluation"
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EvaluationButton(                             //green button
                  yourIcon: Icons.sentiment_satisfied_rounded,
                  iconcolor: Colors.green,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                    databaseModelDE.dailyEvaluationScore = 3;
                  });
                }),
                EvaluationButton(
                  yourIcon: Icons.sentiment_neutral_rounded,
                  iconcolor: Colors.yellow,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                    databaseModelDE.dailyEvaluationScore = 2;
                  });
                }),
                EvaluationButton(
                  yourIcon: Icons.sentiment_dissatisfied_outlined,
                  iconcolor: Colors.red,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                    databaseModelDE.dailyEvaluationScore = 1;
                  });
                }),
      
                //save button//
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                     onPressed : () async{
                      
                       await DatabaseManager.databaseManager.insertDailyEvaluation(databaseModelDE);
                      debugPrint('here');
                      //final DBcheck = await DatabaseManager.databaseManager.getDailyEvaluationMapList(today);
                      //debugPrint('$evaluation value inserted');
                    }, 
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.40, MediaQuery.of(context).size.height * 0.08)),  
                    child: Text('Save', style: TextStyle(color: Colors.black, fontSize: 28),),       
                        ),
                ),
                ]),
    ///Button to open textfield for memo. Invisible until the user has chosen one of the three icons. Needs to be repositioned. 
        floatingActionButton: 
          Visibility(visible: isVisible,
            child:  ElevatedButton(
                    onPressed : () async {
                        final dailyEvaluationMemo = await openDialog();
                        setState(() => databaseModelDE.dailyEvaluationMemo = dailyEvaluationMemo);
                    }, 
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    child: Icon(
                        Icons.edit_note, size: 50.0, color: Colors.black,),
                    ),
                    ),
                );

  }
}

