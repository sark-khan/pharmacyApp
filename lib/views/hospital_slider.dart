// views/doctor_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/colors.dart';
import '../models/hospital.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../components/doctorsComponents/search_results.dart';
import './bottom_navigation_bar.dart';
import '../utils/routes.dart';
import '../controllers/hospitals_screen_controller.dart';
import '../widgets/hospital_card.dart';
import '../controllers/home_controller.dart';
import '../views/hospital_details_screen.dart';

class HospitalSlider extends StatefulWidget {
  @override
  State<HospitalSlider> createState() => _HospitalSliderState();
}

class _HospitalSliderState extends State<HospitalSlider> {
  final HospitalController controller =
      Get.put(HospitalController(), tag: 'HospitalSlider');
  final homeController = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    // Initialize HospitalController each time DoctorsScreen is shown

    ever(homeController.selectedLocation, (location) {
      if (location != null && location.isNotEmpty) {
        print("locations send");
        print(location);
        controller.requestFetchHospitals(location);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Row(
              children: [
                Text(
                  "Best Of Healthcare",
                  style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.HospitalsRoute);
                  },
                  child: Text(
                    "See All",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 20 / 14)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 26,
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                    height: 90,
                    margin: EdgeInsets.only(top: 24, bottom: 24),
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )),
              );
            }
            if (controller.hostpitalsList.length == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 90,
                  margin: EdgeInsets.only(top: 24, bottom: 24),
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: AppColors.doctorScreenBackgroudColor,
                  ),
                  child: Center(
                    child: Text("No Hospital found.",
                        style: GoogleFonts.poppins(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(left: 24, bottom: 24),
              child: SizedBox(
                height: 300, // Adjust height based on the size of the card
                child: ListView.separated(
                  scrollDirection: Axis.horizontal, // Set horizontal scrolling
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.hostpitalsList.length,
                  itemBuilder: (context, index) {
                    Hospital hospital = controller.hostpitalsList[index];
                    return Container(
                      width: 340,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => HospitalPage(slug: hospital.slug));
                        },
                        child: HospitalCard(
                          hospital: hospital,
                          forHomeScreen: true,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: 16), // Space between cards
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
