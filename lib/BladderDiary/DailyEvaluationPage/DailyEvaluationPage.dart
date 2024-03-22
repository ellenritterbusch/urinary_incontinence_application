//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/EvaluationButton.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';


class DailyEvaluationPage extends StatefulWidget {
  const DailyEvaluationPage({super.key});

  @override
  State<DailyEvaluationPage> createState() => _DailyEvaluationPageState();
}

class _DailyEvaluationPageState extends State<DailyEvaluationPage> {
  late TextEditingController controller; //initialize controller for memo

  @override //Used to take user input for memo
    void initState(){
    super.initState();
    
    controller = TextEditingController();
    }

  

  //ATTRIBUTES FOR DAILY EVALUATION
  
  String dailyEvaluationMemo =''; //Initialize a memo string to be filled out later
  int dailyEvaluation = 0; //Used to store result of daily evaluation, 1= bad, 2=neutral, 3= good
  bool isVisible = false;  //Used for displaying note button when an evaluation has been given
  DatabaseModel databaseModelDE = DatabaseModel(0, '', '');

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
                EvaluationButton(iconcolor: Colors.green,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                  });
                }),
                EvaluationButton(iconcolor: Colors.yellow,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                  });
                }),
                EvaluationButton(iconcolor: Colors.red,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                  });
                }),
      
                //save button//
                OutlinedButton(
                   onPressed : (){
                     setState(() {
                      databaseModelDE.date = '1';
                      databaseModelDE.dailyEvaluationScore = dailyEvaluation;
                      databaseModelDE.dailyEvaluationMemo = dailyEvaluationMemo;
                    });
                  }, 
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.40, MediaQuery.of(context).size.height * 0.08)),  
                  child: Text('Save', style: TextStyle(color: Colors.black, fontSize: 28),),       
                      ),
                ]),
    ///Button to open textfield for memo. Invisible until the user has chosen one of the three icons. Needs to be repositioned. 
        floatingActionButton: 
          Visibility(visible: isVisible,
            child:  ElevatedButton(
                    onPressed : () async {
                        final dailyEvaluationMemo = await openDialog();
                        setState(() => this.dailyEvaluationMemo=dailyEvaluationMemo);
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


// <Widget>[
              // Row( //Green Button
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[ ElevatedButton(
              //       onPressed : () {setState(() {
              // dailyEvaluation = 3;
              // isVisible = true;
              //                                 });
              //                       }, 
              //       style:  ElevatedButton.styleFrom(
              //            fixedSize: Size(120, 120),
              //            shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(23.0))),
              //       child: 
              //       const Icon(
              //           Icons.sentiment_satisfied_rounded, size: 70.0, color: Colors.green,),
              //       )
              //     ],
      
              //     ),
              // Row( //Yellow button
              //   mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[ ElevatedButton(
              //       onPressed : () {setState(() {
              // dailyEvaluation = 2;
              // isVisible = true;
              //                                     });
              //                        }, 
              //       style:  ElevatedButton.styleFrom(
              //            fixedSize: Size(120, 120),
              //            shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(23.0))),
              //       child: const Icon(
              //           Icons.sentiment_satisfied_rounded, size: 70.0, color: Colors.yellow),
              //       )
              //     ],
      
              //     ),
              // Row( //Red button
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[ 
              //       ElevatedButton(
              //       onPressed : () {setState(() {
              //       dailyEvaluation = 1;
              //         isVisible = true;
              //                                   });                      
              //                       }, 
              //       style:  ElevatedButton.styleFrom(
              //            fixedSize: Size(MediaQuery.of(context).size.width * 0.30, MediaQuery.of(context).size.width * 0.30),
              //            shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(23.0))),
              //       child: const Icon(
              //           Icons.sentiment_satisfied_rounded, size: 80, color: Colors.red),
              //       )
              //     ],