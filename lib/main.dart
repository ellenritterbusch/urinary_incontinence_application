import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/CalendarPage.dart';
import 'package:urinary_incontinence_application/Home/HomePage.dart';
import 'package:urinary_incontinence_application/Notifications/NotificationsPage.dart';

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
      debugShowCheckedModeBanner: false, //fjerne "debug" markat
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(207, 230, 55, 70),
          brightness: Brightness.light,
        ),
      textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
          titleLarge: GoogleFonts.quicksand(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.quicksand(),
          displaySmall: GoogleFonts.pacifico(),
      ),
       fontFamily: GoogleFonts.quicksand().fontFamily
        ),
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
    const HomePage(),
    const CalendarPage(),
    const NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
      onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
        destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: "Calendar"),
        NavigationDestination(icon: Icon(Icons.notifications), label: "Notifications")
      ],        
      ),
    );
  }
}

