import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import './bottom_navigation_bar.dart';
import '../widgets/main_info_hospital.dart';
import '../widgets/doctor_booking_card.dart';
import '../widgets/review_card.dart';
import "../widgets/doctor_details_bottom_sheet.dart";
import '../widgets/hospital_image_pageview.dart';
import './dateCalender.dart';
import '../controllers/hostpital_detaill_screen.dart';
import '../utils/app_constant.dart';
import '../utils/helper_class.dart';

class DoctorBookingSlot extends StatefulWidget {
  final String slug;
  DoctorBookingSlot({super.key, required this.slug});
  @override
  State<DoctorBookingSlot> createState() => _DoctorBookingSlotState();
}

class _DoctorBookingSlotState extends State<DoctorBookingSlot> {
  late final HospitalDetailsController controller;
  bool isControllerInitialized = false; // Track initialization state

  @override
  void initState() {
    super.initState();
    final argumnents = Get.arguments;
    // Ensure the controller is registered
    if (!Get.isRegistered<HospitalDetailsController>(
        tag: "HospitalDetailScreen")) {
      controller =
          Get.put(HospitalDetailsController(), tag: "HospitalDetailScreen");
    } else {
      controller =
          Get.find<HospitalDetailsController>(tag: "HospitalDetailScreen");
    }

    // Fetch data and set the initialization state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Create a list of futures
      List<Future> futures = [];

      // Conditionally add fetchHospitalDetails if the slug exists
      if (argumnents?["slug"] != null && argumnents?["slug"].isNotEmpty) {
        futures.add(controller.fetchHospitalDetails(argumnents["slug"]));
      }

      // Add fetchParticularDoctorDetails to the list
      futures.add(controller.fetchParticularDoctorDetails(widget.slug));

      // Wait for all futures to complete
      Future.wait(futures).then((_) {
        if (mounted) {
          setState(() {
            isControllerInitialized = true; // Mark as ready to build
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            isControllerInitialized = false; // Mark as failed if needed
          });
        }
        debugPrint("Error fetching data: $error");
      });
    });
  }

  @override
  void dispose() {
    // Clear the controller's data when the widget is disposed
    controller.doctorDetails.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading state until the controller is initialized
    if (!isControllerInitialized) {
      return Scaffold(
        backgroundColor: AppColors.doctorScreenBackgroudColor,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    // Render the UI once the controller is initialized
    return Scaffold(
      backgroundColor: AppColors.doctorScreenBackgroudColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
        if (controller.doctorDetails.isEmpty) {
          return Center(
            child: Text(
              "Doctor Details Not Found",
              style: GoogleFonts.poppins(
                height: 24 / 16,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }
        return SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
            children: [
              HospitalImagePageview(),
              Column(
                children: [
                  MainInfoOfHospital(),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {
                        _showFilterBottomSheet(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.doctorScreenBackgroudColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  (controller.doctorDetails["image"]?.isEmpty ??
                                          true)
                                      ? "${AppConstant.ImageDomain}/doctor-fallback.jpg"
                                      : "${AppConstant.ImageDomain}/${controller.doctorDetails["image"]}",
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${controller.doctorDetails["honorific"]} ${StringFunctions.convertToTitleCase(controller.doctorDetails["name"])}",
                                  style: GoogleFonts.poppins(
                                    height: 24 / 16,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "${controller.doctorDetails["department"]} • ${controller.doctorDetails["experienceCount"] ?? 0}+ Years Experience",
                                  style: GoogleFonts.poppins(
                                    color: Color.fromRGBO(0, 0, 0, 0.6),
                                    height: 16 / 12,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Container(
                              width: 12.08,
                              height: 7.24,
                              child: SvgPicture.asset(
                                "assets/images/arrow_down.svg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        CalendarWidget(),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: AppRoutes.routesIndex[AppRoutes.HospitalsRoute] as int,
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: DocterDetailsBottomSheet(
            slug: widget.slug,
          ),
        );
      },
    );
  }
}
