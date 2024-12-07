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
import '../widgets/homescreen_doctor_card.dart';
import '../controllers/home_controller.dart';
import '../views/doctor_booking_slot.dart';

class HomeScreenDoctorList extends StatefulWidget {
  @override
  State<HomeScreenDoctorList> createState() => _HomeScreenDoctorListState();
}

class _HomeScreenDoctorListState extends State<HomeScreenDoctorList> {
  final DoctorController controller =
      Get.put(DoctorController(), tag: 'HomeScreenDoctorList');
  final HomeController homeController = Get.find<HomeController>();
  String selectedDepartment = "All";
  @override
  void initState() {
    super.initState();

    ever(homeController.selectedLocation, (location) {
      if (location != null && location.isNotEmpty) {
        controller.requestFetchDoctors(location, selectedDepartment);
      }
    });
  }

  void onDepartmentChange(department) {
    controller.requestFetchDoctors(
        homeController.selectedLocation.value, department);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Title and See All button
          Row(
            children: [
              Text(
                "Our Medical Specialists",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.DoctorsRoute);
                },
                child: Text(
                  "See All",
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 26),
          // Specialties List
          Container(
            height: 28,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemCount: controller.specialties.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDepartment = controller.specialties[index];
                      onDepartmentChange(controller.specialties[index]);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      color: selectedDepartment == controller.specialties[index]
                          ? Color.fromRGBO(5, 102, 211, 1)
                          : Color.fromRGBO(242, 244, 245, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.specialties[index],
                      style: GoogleFonts.poppins(
                        color:
                            selectedDepartment == controller.specialties[index]
                                ? Colors.white
                                : Color.fromRGBO(0, 0, 0, 0.6),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Doctor list display
          Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }
            if (controller.doctors.length == 0) {
              return Container(
                height: 90,
                margin: EdgeInsets.only(top: 24, bottom: 24),
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.doctorScreenBackgroudColor,
                ),
                child: Center(
                  child: Text("No Doctor found.",
                      style: GoogleFonts.poppins(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                ),
              );
            }
            return Column(
              children: [
                for (var doctor in controller.doctors)
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DoctorBookingSlot(slug: doctor.slug),
                          arguments: {"slug": doctor.hospitalSlug});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: HomeScreenDoctorCard(doctor: doctor),
                    ),
                  ),
                SizedBox(height: 24),
              ],
            );
          })
        ],
      ),
    );
  }
}
