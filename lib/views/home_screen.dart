import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../components/homeComponents/hero_component.dart';
import '../components/homeComponents/specialitySlider.dart';
import '../components/homeComponents/doctor_list.dart';
import './bottom_navigation_bar.dart';
import '../utils/routes.dart';
import '../views/hospital_slider.dart';

import './home_screen_doctor_list.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroComponent(),
            SizedBox(height: 10),
            SpecialtySlider(),
            SizedBox(height: 10),
            HomeScreenDoctorList(), // No need for an Expanded here
            HospitalSlider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: AppRoutes.routesIndex[AppRoutes.HomeRoute] as int,
      ),
    );
  }
}
