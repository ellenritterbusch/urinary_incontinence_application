//import 'dart:ffi';

import 'package:flutter/material.dart';
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
  

  @override //Used to take user input for memo
    void initState(){
    super.initState();
    
    controller = TextEditingController();
    }

  

  //ATTRIBUTES FOR DAILY EVALUATION
  
  String dailyEvaluationMemo =''; //Initialize a memo string to be filled out later
  int dailyEvaluation = 0; //Used to store result of daily evaluation, 1= bad, 2=neutral, 3= good
  bool isVisible = false;  //Used for displaying note button when an evaluation has been given
  DatabaseModel databaseModelDE = DatabaseModel(0,'',today);

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
          title: const Text('Daily Evaluation: '), //Page title
          centerTitle: true,
      ),

      body : Column( //Page is 1 column with 4 rows, containing a button for green, yellow, and red, and one for "Submit daily evaluation "
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,         
          children: <Widget>[
              Row( //Green Button
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[ ElevatedButton(
                    onPressed : () {
                      setState(() {
                        isVisible = true;
                        dailyEvaluation = 3;
                        databaseModelDE.dailyEvaluationScore = dailyEvaluation;
                      });
                       }, 
                    style:  ElevatedButton.styleFrom(
                         backgroundColor: Colors.green),
                    child: Icon(
                        Icons.sentiment_satisfied_rounded, size: 50.0, color: Colors.black),
                    )
                  ],
      
                  ),
              Row( //Yellow button
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[ ElevatedButton(
                    onPressed : () {
                      setState(() {
                        isVisible = true;
                        dailyEvaluation = 2;
                        databaseModelDE.dailyEvaluationScore = dailyEvaluation;
                      });
                       }, 
                    style:  ElevatedButton.styleFrom(
                         backgroundColor: Colors.yellow),
                    child: Icon(
                        Icons.sentiment_neutral_rounded, size: 50.0, color: Colors.black),
                    )
                  ],
      
                  ),
              Row( //Red button
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[ ElevatedButton(
                    onPressed : () {
                      setState(() {
                        isVisible = true;
                        dailyEvaluation = 1;
                        databaseModelDE.dailyEvaluationScore = dailyEvaluation;
                      });
                       },  
                    style:  ElevatedButton.styleFrom(
                         backgroundColor: Colors.red),
                    child: Icon(
                        Icons.sentiment_dissatisfied_rounded, size: 50.0, color: Colors.black),
                    )
                  ],
      
                  ),
              Row( // "Save daily evaluation" button
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[ 
                    ElevatedButton(
                      onPressed : ()async{
                          await DatabaseManager.databaseManager.insertDailyEvaluation(databaseModelDE);
                      },   
                      child: Text('Save'),       
                    ),
                  ],
                )
            ]
          ),
          floatingActionButton: //Button to open textfield for memo. Invisible until the user has chosen one of the three icons. Needs to be repositioned. 
          Visibility(visible: isVisible,
                            child:  ElevatedButton(
                    onPressed : () async {
                        final dailyEvaluationMemo = await openDialog();
                        setState(() => databaseModelDE.dailyEvaluationMemo = dailyEvaluationMemo);
                    }, 
                    child: Icon(
                        Icons.edit_note, size: 50.0,),
                    ),)
          
          );

  }
}