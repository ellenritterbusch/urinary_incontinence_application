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
import 'package:urinary_incontinence_application/Visualization/History_Box.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();     //for notification navigation
int currentPage = 0;
final controller = PersistentTabController(initialIndex: 0);
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initialize database
  tz.initializeTimeZones();                 //initialize timezones
  SetNotifications setNotifications = SetNotifications();
  setNotifications.initializeNotification();    //initialize notifications

  //  handle in terminated state
  // var initialNotification = 
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // if (initialNotification?.didNotificationLaunchApp == true) {
  //   Future.delayed(Duration(seconds: 1), () {
  //     navigatorKey.currentState!.pushNamed('/CalendarPage',
  //         arguments: initialNotification?.notificationResponse?.payload);
  //   });
  // }

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
      navigatorKey: navigatorKey,
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
        '/RootPage': (context) => const RootPage(),
        '/HomePage': (context) => const HomePage(),
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
  

  // void setSelectedIndex(int index) {
  //   setState(() {
  //     currentPage = index;
  //   });
  // }


  List<Widget> buildScreens = [
    const HomePage(),
    const CalendarPage(),
    const NotificationPage(),
  ];
  

  List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: const Icon(Icons.home),
                title: ("Home"),
                activeColorPrimary: Theme.of(context).colorScheme.primary,
                inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
                icon: const Icon(Icons.calendar_month_outlined),
                title: ("Calendar"),
                activeColorPrimary: Theme.of(context).colorScheme.primary,
                inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
                icon: const Icon(Icons.settings),
                title: ("Settings"),
                activeColorPrimary: Theme.of(context).colorScheme.primary,
                inactiveColorPrimary: Colors.grey,
            ),
        ];
    }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[currentPage],
//       bottomNavigationBar: NavigationBar(
//       onDestinationSelected: setSelectedIndex,
//         selectedIndex: currentPage,
//         destinations: const [
//         NavigationDestination(icon: Icon(Icons.home), label: "Home"),
//         NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: "Calendar"),
//         NavigationDestination(icon: Icon(Icons.settings_outlined), label: "Settings")
//       ],        
//       ),
//     );
//   }
// }



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
 }
