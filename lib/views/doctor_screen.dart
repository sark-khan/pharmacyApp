// views/doctor_list_screen.dart
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

class DoctorsScreen extends StatefulWidget {
  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  late DoctorController controller;
  @override
  void initState() {
    super.initState();
    // Initialize DoctorController each time DoctorsScreen is shown
    controller = Get.put(DoctorController(), tag: 'DoctorsScreen');
  }

  @override
  void dispose() {
    // Dispose of the DoctorController when leaving DoctorsScreen
    Get.delete<DoctorController>(tag: 'DoctorsScreen');
    super.dispose();
    print("delte");
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
            Obx(() {
              return SearchResultsHeader(
                resultCount: controller.filteredDoctors.length,
              );
            }),
            Obx(() {
              print("we are in this bro ");
              print(controller.isLoading.value);
              if (controller.isLoading.value == true) {
                print("we are in this bro3232323 ");
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
                itemCount: controller.filteredDoctors.length,
                itemBuilder: (context, index) {
                  Doctor doctor = controller.filteredDoctors[index];
                  print(doctor);
                  return DoctorCard(doctor: doctor);
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
