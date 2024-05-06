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
  DatabaseModel databaseModelBD = DatabaseModel.BD('','',0,null, null);

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
        const Calender_Bar(), 
        const Padding(
        padding: EdgeInsets.all(20.0)), 
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children:[
          //overskrift//
          const Text('Severity of accident', style: 
          TextStyle(fontSize: 25, fontWeight:FontWeight.bold),),

          const SizedBox(height: 80,),

          //slider//
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
        if (sliderChanged)
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

              //insert to database//
              await DatabaseManager.databaseManager.insertBladderDiary(databaseModelBD);
              debugPrint('data is sucessfully inserted');
              final diary = await DatabaseManager.databaseManager.getBladderDiary();
              debugPrint('$diary');
              final diaryEntry = await DatabaseManager.databaseManager.getBladderDiarydate(date);

               //snack bar//
               if (diaryEntry != null){            //hvis der ligger en værdi for datoen har vi gemt evalueringen
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
  sliderChanged = true;
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