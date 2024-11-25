import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_screen.dart';
import 'utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/routes.dart';
import './views/main_screen.dart';
import 'views/hospital_screen.dart';
import './views/home_screen.dart';
import './views/doctor_screen.dart';
import 'views/profile_screen.dart';
import './utils/routes.dart';
import './Bindings/doctor_screen_binding.dart';
import './views/transaction_booked.dart';
import './views/hospital_details_screen.dart';
import './views/doctor_booking_slot.dart';
import './views/dateCalender.dart';
import './views/doctor_booking_form.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Doctor Finder',
//       theme: ThemeData(primaryColor: AppColors.primary),
//       home: MainScreen(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Finder',
      theme: ThemeData(primaryColor: AppColors.primary),
      initialRoute: AppRoutes.HomeRoute, // Define initial route
      getPages: [
        GetPage(
            name: AppRoutes.HomeRoute,
            page: () => HomeScreen(),
            transition: Transition.noTransition),
        GetPage(
          name: AppRoutes.DoctorsRoute,
          page: () => DoctorsScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
            name: AppRoutes.HospitalsRoute,
            page: () => HospitalScreen(),
            transition: Transition.noTransition),
        GetPage(
            name: AppRoutes.profileRoute,
            page: () => ProfileScreen(),
            transition: Transition.noTransition),
      ],
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: CalendarWidget(),
//       ),
//     );
//   }
// }
