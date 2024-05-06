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

//int amountAccident = 1;
//late int i;
dynamic amountAccident;
//late int accident;
int counter = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [ Data_Button(),
        SizedBox(height: 80),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: OutlinedButton (
            onPressed : () async{ 
              counter = 0;
              String date = '2024-05-01';
              amountAccident = await DatabaseManager.databaseManager.getBladderDiaryAccident(date); //snak med database
              int amountAccidentlength = amountAccident.length;
            debugPrint('$counter');
              for (int i = 0; i< amountAccidentlength; i++) {
                dynamic individualAccident = amountAccident[i];
                int accident = individualAccident['accident'];
                debugPrint('$accident'); 
               if (accident != 0) {
                 counter = counter+1;
                 
               }
              } debugPrint('$counter');
              
              },
          style: OutlinedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.70, MediaQuery.of(context).size.height * 0.06), 
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30))),  
          child: Text('Update', style: 
          TextStyle(
            color: Colors.black, fontSize: 25),),
  
  )), 
  

        SizedBox(
          width: double.infinity,
          height: 250.0,
          child: Card(color: Color.fromARGB(255, 207, 208, 207),
          child: 
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Accidents', style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                 
                  Text('$counter', style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                    Padding(
                      padding: EdgeInsets.all(12.0)),


                  Text('On-demand stimulations', style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text('22', style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                    Padding(
                      padding: EdgeInsets.all(12.0)),


                  Text('Continous stimulation', style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text('0 min', style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
          ],),

                VerticalDivider(
                  width: 100,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Color.fromARGB(255, 142, 141, 141),),
          
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Use of app', style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: EdgeInsets.all(20.0)),
                  Text('1h 3min', style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),]
              )
          ], // children
          )),),
    ],
    );
  }
}