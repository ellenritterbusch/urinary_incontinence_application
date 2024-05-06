import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/Visualization/CreateFakeData.dart';


class History_Box extends StatefulWidget {
  const History_Box({super.key});

  @override
  State<History_Box> createState() => _History_BoxState();
}

class _History_BoxState extends State<History_Box> {

dynamic amountAccident;
int accidentcounter = 0;
dynamic stimType;
int stimTypecounter = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [ const Data_Button(),
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: OutlinedButton (
            onPressed : () async{ 
              String date = '2024-05-03';
               
              accidentcounter = 0; // accidentcounter
              amountAccident = await DatabaseManager.databaseManager.getBladderDiaryAccident(date); //snak med database
              int amountAccidentlength = amountAccident.length;
                //debugPrint('$accidentcounter');
                
              for (int i = 0; i< amountAccidentlength; i++) {
                dynamic individualAccident = amountAccident[i];
                int accident = individualAccident['accident'];
                //debugPrint('$accident'); 
               if (accident != 0) {
                 accidentcounter++;
               }
              } setState(() {
                accidentcounter = accidentcounter;
              },);

              //debugPrint('$accidentcounter');

              stimTypecounter = 0; // Resetting stimTypecounter
              stimType = await DatabaseManager.databaseManager.getBladderDiaryStimType(date); // Retrieving data from the database
              debugPrint('$stimType');
              int stimTypelength = stimType.length;
              debugPrint('$stimTypelength');
              for (int i = 0; i < stimTypelength ; i++) {
                dynamic individualStimType = stimType[i];
                int stim = individualStimType['stimtype']; // Renamed to avoid conflict
                  debugPrint('$stimType'); 
              if (stim == 1) {
                stimTypecounter++;
               }
              } setState(() {
                stimTypecounter = stimTypecounter;
              });
              debugPrint('$stimTypecounter');
             

            },
          style: OutlinedButton.styleFrom(
          //fixedSize: Size(MediaQuery.of(context).size.width * 0.70, MediaQuery.of(context).size.height * 0.06), 
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30))),  
          child: const Text('Update', style: 
          TextStyle(
            color: Colors.black, fontSize: 25),),
  
  )), 
  

        SizedBox(
          width: double.infinity,
          height: 250.0,
          child: Card(color: const Color.fromARGB(255, 207, 208, 207),
          child: 
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Accidents', style: //printer antal accidents
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text('$accidentcounter', style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                    const Padding(
                      padding: EdgeInsets.all(12.0)),

                  const Text('On-demand stimulations', style: //printer antal on demand stimuleringer
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text('$stimTypecounter', style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                    const Padding(
                      padding: EdgeInsets.all(12.0)),

                  const Text('Continous stimulation', style: //printer samlede tid contnínous stimulering
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const Text('0 min', style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
          ],),

                const VerticalDivider( //den lodrette linje der skiller information i boxen
                  width: 100,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Color.fromARGB(255, 142, 141, 141),),

             // const Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
               // crossAxisAlignment: CrossAxisAlignment.center,
                 // Text('Use of app', style:
                   // TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                 // Padding(
                   // padding: EdgeInsets.all(20.0)),
                 // Text('1h 3min', style:
                   // TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),),],
              //)
    ])))]); // children
        
  }
}