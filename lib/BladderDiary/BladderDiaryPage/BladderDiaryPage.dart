import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Accident_button.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Calendar_bar.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Time_picker.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Save_button.dart';
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
  DatabaseModel databaseModelBD = DatabaseModel.BD('','',0);

  bool yespressed = false; //Used for bordercolor of accident buttons
  bool nopressed = false; //Used for bordercolor of accident buttons

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
      body:     
  
    
    // Track Button navigates to Bladder Diary //
      Column(
      children: [
        Calender_Bar(), 
        Padding(
        padding: EdgeInsets.all(20.0)), 
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children:[ 
            Padding(
              padding: const EdgeInsets.all(8.0),
              ///////   accidentButton /////
              child: Accident_Button(                      
                accidentText: 'Accident',
                icon: const Icon(Icons.water_drop, size: 90, color:  Colors.yellow),
                bordercolor: yespressed? kDefaultIconDarkColor : Colors.yellow,
              onPressed: () {setState(() {
                yespressed = true;
                nopressed = false;
                databaseModelBD.accident = 1;
              });}
              ),
            ),
            /////// NO  accidentButton /////
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: No_Accident_Button(                           
                accidentText: 'No accident',
                icon: Icon(Icons.water_drop, size: 70, color:  Colors.yellow.withOpacity(0.6),),
                stackIcon: Icon(Icons.dnd_forwardslash_outlined, size: 100,color: Colors.yellow,),
                bordercolor: nopressed? kDefaultIconDarkColor : Colors.yellow,
              onPressed: () {setState(() {
                yespressed = false;
                nopressed = true;
                databaseModelBD.accident  = 2;
              });}
              ),
            ),
          ]
        ),
        ////// time picker /////
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Time_picker(),
        ),
        ///// save button ////
        if (yespressed | nopressed)
        Padding(
          padding: EdgeInsets.all(25.0),
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
          }),
        ),
      ]),
    );
  }
}