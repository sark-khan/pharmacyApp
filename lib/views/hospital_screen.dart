// views/doctor_list_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import '../models/hospital.dart';
import './bottom_navigation_bar.dart';
import '../utils/routes.dart';
import '../controllers/hospitals_screen_controller.dart';
import '../widgets/hospital_card.dart';
import '../components/hospitalComponents/search_results.dart';
import '../controllers/home_controller.dart';
import './hospital_details_screen.dart';

class HospitalScreen extends StatefulWidget {
  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  late HospitalController controller;
  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    controller = Get.put(HospitalController(), tag: 'HospitalScreen');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> payload = {};
      var arguments = Get.arguments;
      if (arguments != null && arguments.isNotEmpty) {
        payload = arguments;
      }

      controller.requestFetchHospitalsForHosptialScreen(
          homeController.selectedLocation.value, payload);

      setState(() {});
    });
    searchController.addListener(_onSearchChanged);
    // Initialize HospitalController each time DoctorsScreen is shown
  }

  @override
  void dispose() {
    // Dispose of the HospitalController when leaving HospitalScreen
    Get.delete<HospitalController>(tag: 'HospitalScreen');
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Perform the API call when the user stops typing
      final query = searchController.text.trim();
      controller.requestFetchHospitalsForHosptialScreen(
          homeController.selectedLocation.value, {"q": query});
      //api fetch here
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
            SearchResultsHeader(searchLocation: "HospitalScreen"),
            Obx(() {
              if (controller.isLoading.value == true) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                );
              }
              if (controller.hostpitalsList.length == 0) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "No Result Found.",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 20 / 16)),
                    ),
                  ),
                );
              }
              return Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: controller.hostpitalsList.length,
                itemBuilder: (context, index) {
                  Hospital hospital = controller.hostpitalsList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => HospitalPage(slug: hospital.slug));
                    },
                    child: HospitalCard(
                      hospital: hospital,
                      forHomeScreen: false,
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16),
              ));
            })
          ],
        ),
        bottomNavigationBar: BottomNavBar(
            selectedIndex:
                AppRoutes.routesIndex[AppRoutes.HospitalsRoute] as int));
  }
}
