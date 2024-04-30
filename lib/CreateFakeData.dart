import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/Database/database.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/BladderDiaryPage.dart';
class Data_Button extends StatefulWidget {
  final Function() onpressed;
  
  const Data_Button({super.key, required this.onpressed});

  @override
  State<Data_Button> createState() => _Data_ButtonState();
}

class _Data_ButtonState extends State<Data_Button> {
  late bool accident;
  late String date;
  late String time;
  DatabaseModel databaseModelBD = DatabaseModel.BD('','',0, null, null);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 0.40, MediaQuery.of(context).size.height * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20))
         ),

        onPressed: fakeData,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Make data", style: TextStyle(fontSize: 28, color: Colors.black),),],
          ));
  }

  fakeData() async {
      date;
  }
}