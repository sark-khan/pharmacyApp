import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
import './views/login.dart';

import './views/login_verification_otp.dart';
import './utils/auth_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final storage = GetStorage();
  final keys = storage.getKeys();
  keys.forEach((key) => print('Key: $key, Value: ${storage.read(key)}'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Finder',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      initialRoute: AppRoutes.HomeRoute,
      getPages: [
        GetPage(
          name: AppRoutes.loginRoute,
          page: () => LoginScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: AppRoutes.HomeRoute,
          page: () => HomeScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: AppRoutes.DoctorsRoute,
          page: () => DoctorsScreen(),
          transition: Transition.noTransition,
          binding: DoctorBindings(),
        ),
        GetPage(
          name: AppRoutes.HospitalsRoute,
          page: () => HospitalScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: AppRoutes.profileRoute,
          page: () => ProfileScreen(),
          transition: Transition.noTransition,
        ),
      ],
    );
  }
}
