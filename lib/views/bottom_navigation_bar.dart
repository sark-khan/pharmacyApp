import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/hostpital_detaill_screen.dart';
import 'home_screen.dart';
import 'doctor_screen.dart';
import 'hospital_screen.dart';
import 'profile_screen.dart';
import '../utils/colors.dart'; // Make sure to import your AppColors utility
import '../utils/routes.dart';
import '../controllers/bottom_filter_controller.dart';
import '../utils/auth_helper.dart';
import '../controllers/payment_controller.dart';
import '../controllers/appoinment_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  BottomNavBar({
    super.key,
    required this.selectedIndex,
  });
  void _onItemTapped(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<FiltersController>(tag: "DoctorScreen")) {
        Get.delete<FiltersController>(tag: "DoctorScreen");
      }
      if (Get.isRegistered<FiltersController>(tag: "HospitalScreen")) {
        Get.delete<FiltersController>(tag: "HospitalScreen");
      }
      if (Get.isRegistered<PaymentController>(tag: "PaymentScreen")) {
        Get.delete<PaymentController>(tag: "PaymentScreen");
      }
      if (Get.isRegistered<AppoinmentController>(tag: "AppoinmentScreen")) {
        Get.delete<AppoinmentController>(tag: "AppoinmentScreen");
      }
      if (AppRoutes.routesArray[index] != AppRoutes.HospitalsRoute) {
        if (Get.isRegistered<HospitalDetailsController>(
            tag: "HospitalDetailScreen")) {
          Get.delete<HospitalDetailsController>(tag: "HospitalDetailScreen");
        }
      }

      if (AppRoutes.routesArray[index] == AppRoutes.profileRoute) {
        var token = AuthHelper.getToken();

        if (token == null || token.isEmpty) {
          Get.toNamed(AppRoutes.loginRoute);
        } else {
          Get.toNamed(AppRoutes.profileRoute);
        }
      } else {
        // here check if user is goint to Porfile screen then check user have token or not
        Get.toNamed(AppRoutes.routesArray[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      // color: Colors.white,
      height: 90,
      // Set the height of the entire BottomNavigationBar
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Color(0x400566D3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavigationBarItem(
              label: 'Home',
              index: 0,
              unSelectedSvg: "assets/images/home_grey.svg",
              selectedSvg: "assets/images/home_blue.svg"),
          _buildBottomNavigationBarItem(
            unSelectedSvg: "assets/images/doctor_grey.svg",
            selectedSvg: "assets/images/doctor_blue.svg",
            label: 'Doctors',
            index: 1,
          ),
          _buildBottomNavigationBarItem(
            unSelectedSvg: "assets/images/hospital_grey.svg",
            selectedSvg: "assets/images/hospital_blue.svg",
            label: 'Hospitals',
            index: 2,
          ),
          _buildBottomNavigationBarItem(
            unSelectedSvg: "assets/images/profile_grey.svg",
            selectedSvg: "assets/images/profile_blue.svg",
            label: 'Profile',
            index: 3,
          ),
        ],
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {required String label,
      required int index,
      required String selectedSvg,
      required String unSelectedSvg}) {
    return BottomNavigationBarItem(
      icon: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          if (selectedIndex == index)
            Positioned(
              top: -10,
              child: Container(
                height: 4,
                width: 63,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
          SvgPicture.asset(selectedIndex == index ? selectedSvg : unSelectedSvg)
        ],
      ),
      label: label,
    );
  }
}
