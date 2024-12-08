// views/doctor_list_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import '../controllers/doctors_screen_controller.dart';
import '../models/doctor.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../components/doctorsComponents/search_results.dart';
import '../widgets/doctor_card.dart';
import './bottom_navigation_bar.dart';
import '../utils/routes.dart';
import '../controllers/home_controller.dart';
import '../controllers/bottom_filter_controller.dart';
import '../views/doctor_booking_slot.dart';

class DoctorsScreen extends StatefulWidget {
  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  late DoctorController controller;
  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    controller = Get.put(DoctorController(), tag: 'DoctorSearchScreen');
    // Delay setup until after the initial widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var arguments = Get.arguments;
      Map<String, dynamic> payload = {};
      if (arguments != null && arguments.isNotEmpty) {
        payload = arguments;
      }
      controller.requestFetchDoctorsForDoctorsSceen(
          homeController.selectedLocation.value, payload);
      setState(() {});
    });
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    Get.delete<DoctorController>(tag: 'DoctorSearchScreen');
    searchController.dispose(); // Dispose of the controller
    if (Get.isRegistered<FiltersController>(tag: "DoctorScreen")) {
      Get.delete<FiltersController>(tag: "DoctorScreen");
    }
    _debounce?.cancel(); // Cancel any ongoing debounce timer

    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Perform the API call when the user stops typing
      final query = searchController.text.trim();
      controller.requestFetchDoctorsForDoctorsSceen(
          homeController.selectedLocation.value,
          <String, dynamic>{"q": "${query}"}); // Add your search method here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.doctorScreenBackgroudColor,
        body: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 56, left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight:
                        Radius.circular(20)), // Optional: Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(
                        5, 102, 211, 0.25), // RGBA color with 25% opacity
                    offset: Offset(0, 0), // X and Y offset for the shadow
                    blurRadius: 8, // Spread of the shadow
                    spreadRadius: 0, // No extra spread, similar to CSS
                  ),
                ],
              ),
              child: Container(
                height: 41,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F8), // Light grey background color
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey, // Icon color
                    ),
                    hintText: 'Search...', // Placeholder text
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6), // Hint text color
                    )),
                    border: InputBorder.none, // Remove underline
                  ),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Text color
                  )),
                ),
              ),
            ),
            SizedBox(height: 6),
            SearchResultsHeader(
              screenLocation: "DoctorScreen",
            ),
            Obx(() {
              if (controller == null || controller.isLoading.value == true) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                );
              }
              return Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: controller.doctors.length,
                itemBuilder: (context, index) {
                  Doctor doctor = controller.doctors[index];
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => DoctorBookingSlot(slug: doctor.slug),
                            arguments: {"slug": doctor.hospitalSlug});
                      },
                      child: DoctorCard(doctor: doctor));
                },
                separatorBuilder: (context, index) => SizedBox(height: 16),
              ));
            })
          ],
        ),
        bottomNavigationBar: BottomNavBar(
            selectedIndex:
                AppRoutes.routesIndex[AppRoutes.DoctorsRoute] as int));
  }
}
