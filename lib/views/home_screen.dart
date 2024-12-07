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

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  final GlobalKey<HeroComponentState> heroKey = GlobalKey<HeroComponentState>();

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide dropdown when tapping outside the HeroComponent
        print(heroKey.currentState?.isDropdownVisible);
        if (heroKey.currentState?.isDropdownVisible ?? false) {
          heroKey.currentState?.toggleDropdownVisibility();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeroComponent(key: heroKey),
              SizedBox(height: 10),
              SpecialtySlider(),
              SizedBox(height: 10),
              HomeScreenDoctorList(),
              HospitalSlider(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: AppRoutes.routesIndex[AppRoutes.HomeRoute] as int,
        ),
      ),
    );
  }
}
