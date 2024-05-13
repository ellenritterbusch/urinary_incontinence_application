import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Calendar_bar.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Time_picker.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Save_button.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Slider.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';


class BladderDiaryPage extends StatefulWidget {
  const BladderDiaryPage({super.key});

  @override
  State<BladderDiaryPage> createState() => _BladderDiaryState();
}

class _BladderDiaryState extends State<BladderDiaryPage> {
  late bool accident;
  late String date;
  late String time;

  DatabaseModel databaseModelBD = DatabaseModel.BD('','',0, 0, 0);

  bool sliderChanged = false; //Used for saving

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bladder Diary"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },),
      ),
      body:  SingleChildScrollView(   
        child: 
    
    // Track Button navigates to Bladder Diary //
      Column(
      children: [
        const Calender_Bar(),                               //instance of the Calendar_bar
        const Padding(
        padding: EdgeInsets.all(20.0)), 
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children:[
          const Text('Severity of accident', style:         //title
          TextStyle(fontSize: 25, fontWeight:FontWeight.bold),),

          const SizedBox(height: 80,),

          //Slider//
          SeveritySlider(
            sliderChanged: (double value) {
             setState(() {
               currentSliderValue = value;
             });
             setSliderValue();
            }
          ),

          //explaining text//
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Nothing'),
              SizedBox(width: 70,),
              Text('Some'),
              SizedBox(width: 65,),
              Text('Moderate'),
              SizedBox(width: 60,),
              Text('Much'),
            ],
          )   
         ]),

        ////// time picker /////
        const SizedBox(height: 60,),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Time_picker(),
        ),

        ///// save button ////
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Save_Button(
            onpressed:() async {
              //set date//
              date = today.toString().substring(0,10);
              databaseModelBD.date = date;
            
              
              //set time//
              time = selectedTime.toString().substring(10,15);
              databaseModelBD.time = time;

    //HARD CODE VALUE FOR STIM TYPE AND TIME SETTING, MUST BE CHANGED WHEN BLUETOOTH CONNECTION IS IMPLEMENTED//
              databaseModelBD.stimTimeSetting = 240;
              databaseModelBD.stimType = 1;
              //insert to database//
              await DatabaseManager.databaseManager.insertBladderDiary(databaseModelBD);
              debugPrint('data is sucessfully inserted');
              final diary = await DatabaseManager.databaseManager.getBladderDiary();
              debugPrint('$diary');
              final diaryEntry = await DatabaseManager.databaseManager.getBladderDiarydate(date);

               //snack bar//
               if (diaryEntry != null){            //If the entry has a value the value is saved
              const snackBar = SnackBar(
                content: Text('Accident is saved'),
              );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                 //navigate to CalendarPage
                Navigator.pop(context);
             }
                          
          }),
        ),
      ]),
      )
    );
  }


  setSliderValue(){
      if (currentSliderValue == 0){
        databaseModelBD.accident = 0;
      }
      if (currentSliderValue == 1){
        databaseModelBD.accident = 1;
      }
      if (currentSliderValue == 2){
        databaseModelBD.accident = 2;
      }
      if (currentSliderValue == 3){
        databaseModelBD.accident = 3;
      }
    
  }
}