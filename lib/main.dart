import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage.dart';

void main() {
  runApp(
 const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UrDiary",
      debugShowCheckedModeBanner: false, //fjerne "debug" markat
      //theme: ThemeData(
        //fontFamily: GoogleFonts.quicksand().fontFamily),
      home: const RootPage()
    );
  }
}

class RootPage extends StatefulWidget { //vigtigt at denne er stateful - betyder den kan ændres
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}


class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = [
    //const HomePage(),
    const BladderDiaryPage(),
    //const NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      pages[currentPage],
      bottomNavigationBar: NavigationBar(destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: "Calendar"),
        NavigationDestination(icon: Icon(Icons.notifications), label: "Notifications")
      ],
      onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage
      ),
    );
  }
}
