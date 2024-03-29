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
  

  @override //Used to take user input for memo
    void initState(){
    super.initState();
    
    controller = TextEditingController();
    }

  
  //ATTRIBUTES FOR DAILY EVALUATION
  
  String dailyEvaluationMemo =''; //Initialize a memo string to be filled out later
  int dailyEvaluation = 0; //Used to store result of daily evaluation, 1= bad, 2=neutral, 3= good
  bool isVisible = false;  //Used for displaying note button when an evaluation has been given

  bool goodDay = false; //Used for color of green button
  bool mehDay = false; //Used for color of yellow button
  bool badDay = false; //Used for color of red button
  //Color saveButtonColor = Colors.grey; //Used for color of  save button, defined below. 


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
          title: const Text('Daily Evaluation '), //Page title
          centerTitle: true,
      ),

      body : 
        Column( //Page is 1 column containing a button for green, yellow, and red, and one for "Submit daily evaluation"
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EvaluationButton(      
                          //green button
                  yourIcon: Icons.sentiment_satisfied_rounded,
                  iconcolor: Colors.green,
                  bordercolor: goodDay? Colors.green: kDefaultIconLightColor,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                     goodDay = true;
                     mehDay = false;
                     badDay = false;     
                  });
                }),
                EvaluationButton(
                  yourIcon: Icons.sentiment_neutral_rounded,
                  iconcolor: Colors.yellow,
                  bordercolor: mehDay? Colors.yellow: kDefaultIconLightColor,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                    goodDay = false;
                    mehDay = true;
                    badDay = false;
                  });
                }),
                EvaluationButton(
                  yourIcon: Icons.sentiment_dissatisfied_outlined,
                  iconcolor: Colors.red,
                  bordercolor: badDay? Colors.red: kDefaultIconLightColor,
                onPressed: (){
                  setState(() {
                    isVisible = true;
                    goodDay = false;
                    mehDay = false;
                    badDay = true;
                  });
                }),
      
                ////Save button////
                if ((goodDay) | (mehDay) | (badDay))
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                     onPressed : (){
                       setState(() {
                        databaseModelDE.dailyEvaluationScore = dailyEvaluation;
                        databaseModelDE.dailyEvaluationMemo = dailyEvaluationMemo;
                      });
                    }, 
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.40, MediaQuery.of(context).size.height * 0.08), 
                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),  
                    child: Text('Save', style: 
                    TextStyle(
                      color: Colors.black, fontSize: 28),),       
                        ),
                ),
                ]),


    ///Button to open textfield for memo. 
    ///Invisible until the user has chosen one of the three icons. 
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


