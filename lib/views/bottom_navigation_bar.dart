import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';
import 'doctor_screen.dart';
import 'hospital_screen.dart';
import 'profile_screen.dart';
import '../utils/colors.dart'; // Make sure to import your AppColors utility
import '../utils/routes.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  BottomNavBar({
    super.key,
    required this.selectedIndex,
  });
  void _onItemTapped(int index) {
    print(index);
    print(AppRoutes.routesArray[index]);
    Get.offNamed(AppRoutes.routesArray[index]);
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
            icon: Icons.home,
            label: 'Home',
            index: 0,
          ),
          _buildBottomNavigationBarItem(
            icon: Icons.medical_services_outlined,
            label: 'Doctors',
            index: 1,
          ),
          _buildBottomNavigationBarItem(
            icon: Icons.local_hospital_outlined,
            label: 'Hospitals',
            index: 2,
          ),
          _buildBottomNavigationBarItem(
            icon: Icons.person_outline,
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

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
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
          Icon(icon),
        ],
      ),
      label: label,
    );
  }
}
