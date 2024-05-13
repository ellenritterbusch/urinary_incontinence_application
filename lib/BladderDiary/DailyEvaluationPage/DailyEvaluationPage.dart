import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/Evaluation_Button.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/Text_Field.dart';



class DailyEvaluationPage extends StatefulWidget {
 const DailyEvaluationPage({super.key});

  @override
  State<DailyEvaluationPage> createState() => _DailyEvaluationPageState();
}

class _DailyEvaluationPageState extends State<DailyEvaluationPage> {
  late TextEditingController controller;
  final memoController = TextEditingController();  
  late String date;

  

  @override //Used to take user input for memo
    void initState(){
    super.initState();
    controller = TextEditingController();
    }

   @override
  void dispose() {
    memoController.dispose();
    super.dispose();
  }


  //ATTRIBUTES FOR DAILY EVALUATION
  
  String dailyEvaluationMemo =''; //Initialize a memo string to be filled out later
  int dailyEvaluation = 0; //Used to store result of daily evaluation, 1= bad, 2=neutral, 3= good
  bool isVisible = false;  //Used for displaying note button when an evaluation has been given

  bool goodDay = false; //Used for color of green button
  bool mehDay = false; //Used for color of yellow button
  bool badDay = false; //Used for color of red button
  
   DatabaseModel databaseModelDE = DatabaseModel.DE(0,'','');

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
              title: const Text('Daily Evaluation Note'), 
              
              content: TextField(
                maxLines: null, //set to null so that note doesn't appear as one long line. 
                autofocus: true, //Makes keyboard pop up automatically when textfield is opened
                decoration: const InputDecoration(hintText: 'Enter additional context for daily evaluation'),
                controller: controller,
                onSubmitted: (_) => submit(), //if user presses submit on keyboard, submit. 
                ),
                actions: [
                  TextButton(
                    onPressed: (close), 
                    child: const Text('Cancel')),
                    TextButton(
                    onPressed: (submit), 
                    child: const Text('Submit'))
                ],
            ),
          );

    return  Scaffold(
      appBar: AppBar(
          title: const Text('Daily Evaluation '), //Page title
          centerTitle: true,
          leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },),
      ),

      body : 
        SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('How was your day?',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row( //Page is 1 column containing a button for green, yellow, and red, and one for "Submit daily evaluation"
                    mainAxisAlignment: MainAxisAlignment.center,
  
                    children: [
              
                      EvaluationButton(
                        yourIcon: Icons.sentiment_dissatisfied_outlined,
                        iconcolor: Colors.red,
                        bordercolor: badDay? Colors.red: kDefaultIconLightColor,
                      onPressed: (){
                        setState(() {
                          databaseModelDE.dailyEvaluationScore = 1;
                          isVisible = true;
                          goodDay = false;
                          mehDay = false;
                          badDay = true;
                        });
                      }),
              
                      EvaluationButton(
                        yourIcon: Icons.sentiment_neutral_rounded,
                        iconcolor: Colors.yellow,
                        bordercolor: mehDay? Colors.yellow: kDefaultIconLightColor,
                      onPressed: (){
                        setState(() {
                          databaseModelDE.dailyEvaluationScore = 2;
                          isVisible = true;
                          goodDay = false;
                          mehDay = true;
                          badDay = false;
                        });
                      }),
                      
                      EvaluationButton(      
                        yourIcon: Icons.sentiment_satisfied_rounded,
                        iconcolor: Colors.green,
                        bordercolor: goodDay? Colors.green: kDefaultIconLightColor,
                      onPressed: (){
                        setState(() {
                          databaseModelDE.dailyEvaluationScore = 3;
                          isVisible = true;
                           goodDay = true;
                           mehDay = false;
                           badDay = false;     
                        });
                      }),
                    ]
                    )),
                     
                      if ((goodDay) | (mehDay) | (badDay))        //if a evaluationbutton is pressed then show the save button and the textfield

                    //Text field ////

                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextField(
                        controller: memoController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 228, 226, 226),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          hintText: 'Describe your day',
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                        maxLines: 5,
                      ),
                    ),

                    ////Save button/////
                      const  SizedBox(height: 80),
                      if ((goodDay) | (mehDay) | (badDay))
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: OutlinedButton(
                           onPressed : () async{
                            //set date
                            date = today.toString().substring(0,10);
                            databaseModelDE.date = date;

                            //set memo
                            dailyEvaluationMemo = memoController.text;
                            databaseModelDE.dailyEvaluationMemo = dailyEvaluationMemo;
              
                            //insert to database
                            await DatabaseManager.databaseManager.insertDailyEvaluation(databaseModelDE);
                            debugPrint('data is sucessfully inserted');
                            final evaluation = await DatabaseManager.databaseManager.getDailyEvaluations();
                            debugPrint('$evaluation');
                            final evaluationEntry = await DatabaseManager.databaseManager.getDailyEvaluationsdate(date);  //for snackbar
              
                            //snack bar//
                            if (evaluationEntry != null){            
                              const snackBar = SnackBar(
                                 content: Text('Daily evaluation is saved'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              //navigate to CalendarPage
                              Navigator.pop(context);
                            }
                          }, 
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width * 0.70, MediaQuery.of(context).size.height * 0.06), 
                             shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),  
                          child: const Text('Save', style: 
                          TextStyle(
                            color: Colors.black, fontSize: 25),),       
                              ),
                          ),  
          ],
        ),
        )    
    );

  }
}


