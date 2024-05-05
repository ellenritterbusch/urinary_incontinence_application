import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/CalendarPage.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/DailyEvaluationPage.dart';
import 'package:urinary_incontinence_application/Home/HomePage.dart';
import 'package:urinary_incontinence_application/Notifications/NotificationsPage.dart';
import 'package:urinary_incontinence_application/Notifications/SetNotifications.dart';
import 'package:urinary_incontinence_application/Notifications/SwitchStateNotifier.dart';
import 'package:timezone/data/latest_all.dart' as tz;
//import 'package:urinary_incontinence_application/Visualization/HomePage/History_Box.dart';

final navigatorKey = GlobalKey<NavigatorState>();     //for notification navigation
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initialize database
  tz.initializeTimeZones();                 //initialize timezones
  await SetNotifications.initializeNotification();    //initialize notifications

  //  handle in terminated state
  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed('/CalendarPage',
          arguments: initialNotification?.notificationResponse?.payload);
    });
  }

  runApp(ChangeNotifierProvider(
      create: (context) => SwitchStateNotifier(),
      child: const MyApp()));
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
          seedColor: Colors.blue,
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
          displaySmall: GoogleFonts.quicksand(),
      ),
       fontFamily: GoogleFonts.quicksand().fontFamily
        ),
        routes: {
        '/CalendarPage': (context) => const CalendarPage(),
      },
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
        NavigationDestination(icon: Icon(Icons.settings_outlined), label: "Settings")
      ],        
      ),
    );
  }
}



//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Flutter ShowDialog"),
//         ), // AppBar
//         body: Center(
//           child: Builder(builder: (context){
//             return ElevatedButton(
//               onPressed: () {
//                 const snackBar = SnackBar(content: Text("Yay a snackbar"));
//               },
//               child: const Text('Show SnackBar'),
//             ); 
//           }), 
//         ), 
//         ), 
//       );
//   }
// }
